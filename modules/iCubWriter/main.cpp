/* 
 * Copyright (C) 2013 iCub Facility - Istituto Italiano di Tecnologia
 * Author: Ugo Pattacini
 * email:  ugo.pattacini@iit.it
 * Permission is granted to copy, distribute, and/or modify this program
 * under the terms of the GNU General Public License, version 2 or any
 * later version published by the Free Software Foundation.
 *
 * A copy of the license can be found at
 * http://www.robotcub.org/icub/license/gpl.txt
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details
*/

/** 
\defgroup icub_iCubWriter iCubWriter
 
A very simple module that lets the iCub reproduce on a sheet of 
paper a drawing given in svg format. 
 
\section intro_sec Description 
By using the actionPrimitives library the iCub can reproduce a 
drawing given in vectorial form. \n 
Note that only the <i>line</i> and <i>polyline</i> svg commands 
are recognized. \n 
 
\section lib_sec Libraries 
- YARP.
- actionPrimitives. 

\section parameters_sec Parameters
--part \e part
- select the arm to control.
 
--drawing \e drawing
- select the svg file containing the drawing to write.

\section portsc_sec Ports Created 

\e /iCubWriter/rpc receives the [go] command to start writing.
 
\section tested_os_sec Tested OS
Windows, Linux
 
\author Ugo Pattacini
*/ 

#include <string>
#include <sstream>
#include <deque>
#include <algorithm>

#include <yarp/os/all.h>
#include <yarp/sig/all.h>
#include <yarp/dev/all.h>
#include <yarp/math/Math.h>
#include <iCub/action/actionPrimitives.h>

#include <tinyxml.h>


YARP_DECLARE_DEVICES(icubmod)

using namespace std;
using namespace yarp::os;
using namespace yarp::dev;
using namespace yarp::sig;
using namespace yarp::math;
using namespace iCub::action;


/************************************************************************/
class Gazer : public RateThread
{
    IGazeControl     *igaze;
    ActionPrimitives *action;
    Vector offset;

public:
    /************************************************************************/
    Gazer(PolyDriver &driver, ActionPrimitives *action, const Vector &offset) : 
          RateThread(50)
    {
        driver.view(this->igaze);
        this->action=action;
        this->offset=offset;
    }

    /************************************************************************/
    void run()
    {
        Vector x,o;
        action->getPose(x,o);
        igaze->lookAtFixationPoint(x+offset);
    }
};


/************************************************************************/
class WriterModule: public RFModule
{
protected:
    ActionPrimitives *action;
    PolyDriver        driverArm;
    PolyDriver        driverGaze;
    Gazer            *gazer;
    RpcServer         rpcPort;
    bool              interrupting;
    bool              impedanceOn;

    struct SegmentParameters
    {
        string type;
        Vector orientation;
        double delta_z;
        double reach_above;
        double segment_time;
        double cartesian_time;
        double cartesian_straightness;
    };

    deque<SegmentParameters> segParams;
    deque<deque<ActionPrimitivesWayPoint> > wayPoints;    
    Vector stiffness_old,damping_old,orientation;
    double scale,reach_above,segment_time,cartesian_time,cartesian_straightness;
    Matrix H;

    /************************************************************************/
    void setStraightness(const double straightness)
    {
        ICartesianControl *icart;
        action->getCartesianIF(icart);

        Bottle options;
        Bottle &straightOpt=options.addList();
        straightOpt.addString("straightness");
        straightOpt.addDouble(straightness);
        icart->tweakSet(options);
    }

    /************************************************************************/
    Vector parseDrawing(TiXmlDocument& drawing)
    {
        SegmentParameters params;
        params.orientation=orientation;
        params.delta_z=0.0;
        params.reach_above=reach_above;
        params.segment_time=segment_time;
        params.cartesian_time=cartesian_time;
        params.cartesian_straightness=cartesian_straightness;

        ActionPrimitivesWayPoint wp;
        wp.granularity=0.05;
        wp.trajTime=cartesian_time;
        wp.duration=segment_time;
        wp.x=0.0;
        wp.o=orientation;
        wp.oEnabled=true;

        Vector top_left_corner(2,0.0);

        TiXmlHandle hText(&drawing);
        TiXmlElement *pElem;

        pElem=hText.FirstChildElement().Element();
        if (pElem==NULL)
            return top_left_corner;

        string type=pElem->Value();
        if (type!="svg")
            return top_left_corner;
        
        pElem=TiXmlHandle(pElem).FirstChildElement().Element();
        while (pElem!=NULL)
        {            
            string type=pElem->Value();
            if (type=="line")
            {
                deque<ActionPrimitivesWayPoint> path;

                pElem->QueryDoubleAttribute("x1",&wp.x[0]);
                pElem->QueryDoubleAttribute("y1",&wp.x[1]);
                wp.x*=scale;
                path.push_back(wp);

                top_left_corner[0]=std::min(top_left_corner[0],wp.x[0]);
                top_left_corner[1]=std::min(top_left_corner[1],wp.x[1]);

                pElem->QueryDoubleAttribute("x2",&wp.x[0]);
                pElem->QueryDoubleAttribute("y2",&wp.x[1]);
                wp.x*=scale;
                path.push_back(wp);

                top_left_corner[0]=std::min(top_left_corner[0],wp.x[0]);
                top_left_corner[1]=std::min(top_left_corner[1],wp.x[1]);

                params.type="line";
                segParams.push_back(params);
                wayPoints.push_back(path);
            }
            else if (type=="polyline")
            {
                deque<ActionPrimitivesWayPoint> path;                
                Bottle points(pElem->Attribute("points"));
                wp.duration/=points.size();

                for (int i=0; i<points.size(); i+=2)
                {
                    wp.x[0]=scale*points.get(i).asDouble();
                    wp.x[1]=scale*points.get(i+1).asDouble();
                    path.push_back(wp);

                    top_left_corner[0]=std::min(top_left_corner[0],wp.x[0]);
                    top_left_corner[1]=std::min(top_left_corner[1],wp.x[1]);
                }

                params.type="polyline";
                segParams.push_back(params);
                wayPoints.push_back(path);
            }

            pElem=pElem->NextSiblingElement();
        }

        return top_left_corner;
    }

    /************************************************************************/
    void tranformPoints(const Vector &data_top_left_corner)
    {
        for (size_t i=0; i<wayPoints.size(); i++)
        {
            for (size_t j=0; j<wayPoints[i].size(); j++)
            {
                Vector p=wayPoints[i][j].x;
                p.push_back(1.0);

                p[0]-=data_top_left_corner[0];
                p[1]-=data_top_left_corner[1];

                wayPoints[i][j].x=(H*p).subVector(0,2);
                wayPoints[i][j].x[2]+=segParams[i].delta_z;
            }
        }
    }

    /************************************************************************/
    void printPoints()
    {
        for (size_t i=0; i<wayPoints.size(); i++)
        {
            for (size_t j=0; j<wayPoints[i].size(); j++)
            {
                yInfo()<<"point["<<i<<"]["<<j<<"]=("
                       <<wayPoints[i][j].x.toString(3,3).c_str()<<")";
            }
        }
    }

    /************************************************************************/
    bool doWriting()
    {
        if (gazer!=NULL)
        {
            if (gazer->isSuspended())
                gazer->resume();
            else
                gazer->start();
        }

        Vector torsoEnabled,torsoDisabled(3,0.0);
        action->getTorsoJoints(torsoEnabled);

        Vector x,o,x_offset(3,0.0);

        bool done;
        size_t i;
        for (i=0; i<wayPoints.size(); i++)
        {
            setStraightness(segParams[i].cartesian_straightness);

            action->getPose(x,o);
            x_offset[2]=segParams[i].reach_above;
            action->pushAction(x+x_offset,segParams[i].orientation);
            action->pushAction(wayPoints[i][0].x+x_offset,segParams[i].orientation);
            action->pushAction(wayPoints[i][0].x,segParams[i].orientation);
            
            action->checkActionsDone(done,true);
            if (interrupting)
                return false;
            
            action->setTorsoJoints(torsoDisabled);
            action->pushAction(wayPoints[i]);

            action->checkActionsDone(done,true);
            action->setTorsoJoints(torsoEnabled);
            if (interrupting)
                return false;
        }

        i--;
        action->getPose(x,o);
        x_offset[2]=segParams[i].reach_above;
        action->pushAction(x+x_offset,segParams[i].orientation);

        if (gazer!=NULL)
            gazer->suspend();

        return true;
    }

public:
    /************************************************************************/
    WriterModule() : action(NULL), gazer(NULL), interrupting(false) { }

    /************************************************************************/
    bool configure(ResourceFinder &rf)
    {
        string name=rf.find("name").asString().c_str();
        setName(name.c_str());

        string partUsed=rf.find("part").asString().c_str();
        if ((partUsed!="left_arm") && (partUsed!="right_arm"))
        {
            yError()<<"invalid part requested!";
            return false;
        }        

        Property config; config.fromConfigFile(rf.findFile("from").c_str());
        Bottle &bGeneral=config.findGroup("general");
        if (bGeneral.isNull())
        {
            yError()<<"group \"general\" is missing!";
            return false;
        }

        Property option(bGeneral.toString().c_str());
        option.put("local",name.c_str());
        option.put("part",partUsed.c_str());
        option.put("grasp_model_type",rf.find("grasp_model_type").asString().c_str());
        option.put("grasp_model_file",rf.findFile("grasp_model_file").c_str());
        option.put("hand_sequences_file",rf.findFile("hand_sequences_file").c_str());

        Bottle &bWriting=config.findGroup("writing_general");
        if (bWriting.isNull())
        {
            yError()<<"group \"writing_general\" is missing!";
            return false;
        }
        
        scale=bWriting.check("scale",Value(1.0)).asDouble();
        scale*=bWriting.check("conversion",Value(1.0)).asDouble();
        reach_above=bWriting.check("reach_above",Value(0.05)).asDouble();
        segment_time=bWriting.check("segment_time",Value(1.0)).asDouble();
        cartesian_time=bWriting.check("cartesian_time",Value(1.0)).asDouble();
        cartesian_straightness=bWriting.check("cartesian_straightness",Value(1.0)).asDouble();

        orientation.resize(4,0.0);
        if (Bottle *pB=bWriting.find("orientation").asList())
        {
            int len=std::min((int)orientation.length(),pB->size());
            for (int i=0; i<len; i++)
                orientation[i]=pB->get(i).asDouble();
        }

        Vector top_left_corner(3,0.0);
        if (Bottle *pB=bWriting.find("top_left_corner").asList())
        {
            int len=std::min((int)top_left_corner.length(),pB->size());
            for (int i=0; i<len; i++)
                top_left_corner[i]=pB->get(i).asDouble();
        }
        top_left_corner.push_back(1.0);

        H.resize(4,4);
        H(0,1)=1.0; H(1,0)=1.0; H(2,2)=-1.0;
        H.setCol(3,top_left_corner);

        TiXmlDocument drawing(rf.findFile("drawing").c_str());
        if (!drawing.LoadFile())
        {
            close();
            return false;
        }

        Vector data_top_left_corner=parseDrawing(drawing);
        for (size_t i=0; i<wayPoints.size(); i++)
        {
            ostringstream segment_tag;
            segment_tag<<"writing_segment_"<<i;
            Bottle &bSegment=config.findGroup(segment_tag.str().c_str());
            if (!bSegment.isNull())
            {            
                if (Bottle *pB=bSegment.find("orientation").asList())
                {
                    int len=std::min((int)orientation.length(),pB->size());
                    for (int i=0; i<len; i++)
                        segParams[i].orientation[i]=pB->get(i).asDouble();
                }

                segParams[i].delta_z=bSegment.check("delta_z",Value(segParams[i].delta_z)).asDouble();
                segParams[i].reach_above=bSegment.check("reach_above",Value(segParams[i].reach_above)).asDouble();
                segParams[i].segment_time=bSegment.check("segment_time",Value(segParams[i].segment_time)).asDouble();
                segParams[i].cartesian_time=bSegment.check("cartesian_time",Value(segParams[i].cartesian_time)).asDouble();
                segParams[i].cartesian_straightness=bSegment.check("cartesian_straightness",Value(segParams[i].cartesian_straightness)).asDouble();

                for (size_t j=0; j<wayPoints[i].size(); j++)
                {
                    wayPoints[i][j].o=segParams[i].orientation;
                    wayPoints[i][j].trajTime=segParams[i].cartesian_time;
                    wayPoints[i][j].duration=segParams[i].segment_time;
                    if (segParams[i].type!="line")
                        wayPoints[i][j].duration/=wayPoints[i].size();
                }
            }            
        }

        tranformPoints(data_top_left_corner);
        printPoints();
        
        yInfo()<<"***** Instantiating primitives for "<<partUsed;
        action=new ActionPrimitives(option);
        if (!action->isValid())
        {
            close();
            return false;
        }
        
        setStraightness(cartesian_straightness);

        impedanceOn=false;
        Bottle &bImpedance=config.findGroup("impedance");
        if (!bImpedance.isNull())
        {
            impedanceOn=bImpedance.check("enable",Value("off")).asString()=="on";
            if (impedanceOn)
            {
                Vector stiffness(5,0.0);
                if (Bottle *pB=bImpedance.find("stiffness").asList())
                {
                    int len=std::min((int)stiffness.length(),pB->size());
                    for (int i=0; i<len; i++)
                        stiffness[i]=pB->get(i).asDouble();
                }

                Vector damping(stiffness.length(),0.0);
                if (Bottle *pB=bImpedance.find("damping").asList())
                {
                    int len=std::min((int)damping.length(),pB->size());
                    for (int i=0; i<len; i++)
                        damping[i]=pB->get(i).asDouble();
                }

                string robot=bGeneral.check("robot",Value("icub")).asString().c_str();
                Property driverOption("(device remote_controlboard)");
                driverOption.put("remote",("/"+robot+"/"+partUsed).c_str());
                driverOption.put("local",("/"+name+"/impedance").c_str());
                if (driverArm.open(driverOption))
                {
                    IInteractionMode  *imod;
                    IImpedanceControl *iimp;

                    driverArm.view(imod);
                    driverArm.view(iimp);

                    size_t len=std::min(stiffness.length(),damping.length());
                    stiffness_old.resize(len); damping_old.resize(len);
                    for (size_t i=0; i<len; i++)
                    {
                        iimp->getImpedance(i,&stiffness_old[i],&damping_old[i]);
                        iimp->setImpedance(i,stiffness[i],damping[i]);
                        imod->setInteractionMode(i,VOCAB_IM_COMPLIANT);
                    }
                }
                else
                {
                    close();
                    return false;
                }
            }
        }

        Bottle &bGaze=config.findGroup("gaze");
        if (!bGaze.isNull())
        {
            if (bGaze.check("enable",Value("off")).asString()=="on")
            {
                Vector offset(3,0.0);
                if (Bottle *pB=bGaze.find("offset").asList())
                {
                    int len=std::min((int)offset.length(),pB->size());
                    for (int i=0; i<len; i++)
                        offset[i]=pB->get(i).asDouble();
                }

                Property driverOption("(device gazecontrollerclient)");
                driverOption.put("remote","/iKinGazeCtrl");
                driverOption.put("local",("/"+name+"/gaze").c_str());
                if (driverGaze.open(driverOption))
                    gazer=new Gazer(driverGaze,action,offset);
                else
                {
                    close();
                    return false;
                }
            }
        }

        rpcPort.open(("/"+name+"/rpc").c_str());
        attach(rpcPort);

        return true;
    }

    /************************************************************************/
    bool respond(const Bottle &command, Bottle &reply)
    {
        int ack=Vocab::encode("ack");
        int nack=Vocab::encode("nack");

        if (command.size()>0)
        {
            switch (command.get(0).asVocab())
            {
                //-----------------
                case VOCAB2('g','o'):
                {
                    if (doWriting())
                        reply.addVocab(ack);
                    else
                        reply.addVocab(nack);

                    return true;
                }
                
                //-----------------
                default:
                    return RFModule::respond(command,reply);
            }
        }

        reply.addVocab(nack);
        return true;
    }

    /************************************************************************/
    double getPeriod()
    {
        return 0.1;
    }

    /************************************************************************/
    bool updateModule()
    {
        return true;
    }

    /************************************************************************/
    bool interruptModule()
    {
        interrupting=true;
        action->syncCheckInterrupt(true);

        return true;
    }

    /************************************************************************/
    bool close()
    {
        if (action!=NULL)
            delete action;

        if (driverArm.isValid())
        {
            if (impedanceOn)
            {
                IInteractionMode  *imod; 
                IImpedanceControl *iimp;

                driverArm.view(imod);
                driverArm.view(iimp);

                for (size_t i=0; i<stiffness_old.length(); i++)
                {
                    imod->setInteractionMode(i,VOCAB_IM_STIFF);
                    iimp->setImpedance(i,stiffness_old[i],damping_old[i]);                    
                }
            }

            driverArm.close();
        }

        if (driverGaze.isValid())
        {
            gazer->stop();
            delete gazer;
            driverGaze.close();
        }

        rpcPort.close();
        return true;
    }
};


/************************************************************************/
int main(int argc, char *argv[])
{
    Network yarp;
    if (!yarp.checkNetwork())
    {
        yError()<<"YARP server not available!";
        return -1;
    }

    YARP_REGISTER_DEVICES(icubmod)

    ResourceFinder rf;
    rf.setVerbose(true);
    rf.setDefaultContext("funny-things");
    rf.setDefaultConfigFile("iCubWriter.ini");
    rf.setDefault("part","right_arm");
    rf.setDefault("grasp_model_type","springy");
    rf.setDefault("grasp_model_file","grasp_model.ini");
    rf.setDefault("hand_sequences_file","hand_sequences.ini");
    rf.setDefault("drawing","drawings/icub.svg");
    rf.setDefault("name","iCubWriter");
    rf.configure(argc,argv);

    WriterModule mod;
    return mod.runModule(rf);
}




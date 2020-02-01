/* 
 * Copyright (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
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
\defgroup icub_funnyPostures funnyPostures

A simple module that makes use of the cartesian and gaze 
interfaces to put the iCub in ... funny postures upon tactile 
detection. 

\section intro_sec Description 
This module obtains tactile input from the awareTouch module and 
generates specific robot gestures as response. Optionally, this 
module can interact with the IOL framework to avoid generating 
postures while a IOL action is currently being executed. 
 
\section lib_sec Libraries 
- YARP.
- cartesian and gaze I/F's. 
- ctrlLib. 

\section parameters_sec Parameters
--name \e name
- select the module stem-name.
 
--robot \e robot
- select the robot name to connect to. 
 
--context \e context 
- select the module context. 
 
--from \e file 
- select the configuration file containing the emotions 
  definitions.

\section portsc_sec Ports Created 

\e /funnyPostures/emotions/raw to be connected to the robot 
   emotions port to control the emotions.
 
\e /funnyPostures/iol/status:rpc to be connected to the IOL 
   status port to know whether any ongoing action is currently
   being performed.
 
\e /funnyPostures/iol/human:rpc to be connected to the IOL input 
   port to enable/disable attention and send speech commands.
 
\e /funnyPostured/rpc to be connected to the awareTouch module 
   port to receive currently detected tactile input. Tactile
   inputs handled by this module are: "caress", "poke", "pinch".
 
tested_os_sec Tested OS Windows, Linux 

\author Ugo Pattacini
*/

#include <cstdio>
#include <cmath>
#include <sstream>
#include <string>
#include <limits>
#include <map>

#include <yarp/os/all.h>
#include <yarp/dev/all.h>
#include <yarp/sig/all.h>
#include <yarp/math/Math.h>

using namespace std;
using namespace yarp::os;
using namespace yarp::dev;
using namespace yarp::sig;
using namespace yarp::math;

constexpr double DEG2RAD = M_PI / 180.0;


/*********************************************/
class PosturesModule : public RFModule
{
protected:
    PolyDriver         drvArmL,drvArmR;
    PolyDriver         drvCartL,drvCartR,drvGaze;
    IEncoders         *iencsL,*iencsR;
    IPositionControl  *ipossL,*ipossR;
    ICartesianControl *icartL,*icartR;
    IGazeControl      *igaze;
    int nEncs;

    map<string,Bottle> emotionsRaw;

    RpcServer rpcPort;
    RpcClient iolPortStatus;
    RpcClient iolPortHuman;
    Port emotionsPort;

    /*********************************************/
    void handHelper(const string &type, const Vector &poss)
    {
        Vector vels(9,0.0);
        vels[0]=80.0;
        vels[1]=80.0;
        vels[2]=80.0;
        vels[3]=80.0;
        vels[4]=80.0;
        vels[5]=80.0;
        vels[6]=80.0;
        vels[7]=80.0;
        vels[8]=200.0;

        IControlMode     *imode;
        IPositionControl *iposs;
        if (type=="left")
        {
            drvArmL.view(imode);
            drvArmL.view(iposs);
        }
        else
        {
            drvArmR.view(imode);
            drvArmR.view(iposs);
        }

        int i0=nEncs-poss.length();
        for (int i=i0; i<nEncs; i++)
        {
            imode->setControlMode(i,VOCAB_CM_POSITION);
            iposs->setRefAcceleration(i,std::numeric_limits<double>::max());
            iposs->setRefSpeed(i,vels[i-i0]);
            iposs->positionMove(i,poss[i-i0]);
        }
    }

    /*********************************************/
    void openHand(const string &type)
    {
        Vector poss(9,0.0);
        poss[0]=20.0;

        printf("open hand\n");
        handHelper(type,poss);
    }

    /*********************************************/
    void closeHand(const string &type)
    {
        Vector poss(9,0.0);
        poss[0]=40.0;
        poss[1]=30.0;
        poss[2]=20.0;
        poss[3]=90.0;
        poss[4]=70.0;
        poss[5]=100.0;
        poss[6]=70.0;
        poss[7]=100.0;
        poss[8]=200.0;

        printf("open hand\n");
        handHelper(type,poss);
    }

    /*********************************************/
    void karateHand(const string &type)
    {
        Vector poss(9,0.0);
        poss[0]=60.0;
        poss[1]=0.0;
        poss[2]=50.0;

        printf("karate hand\n");
        handHelper(type,poss);
    }

    /*********************************************/
    void pointHand(const string &type)
    {
        Vector poss(9,0.0);
        poss[0]=40.0;
        poss[1]=30.0;
        poss[2]=20.0;
        poss[3]=90.0;
        poss[4]=00.0;
        poss[5]=00.0;
        poss[6]=70.0;
        poss[7]=100.0;
        poss[8]=200.0;

        printf("point hand\n");
        handHelper(type,poss);
    }

    /*********************************************/
    void postureHelper(const string &priority,
                       const Matrix &targetL,
                       const Matrix &targetR,
                       const Vector &targetG,
                       const Vector &torso=Vector(3,0.0))
    {
        int ctxtL,ctxtR,ctxtG;
        Vector dof;

        if (targetG.length()>=3)
        {
            printf("looking at target\n"); 
            igaze->storeContext(&ctxtG);
            igaze->blockNeckRoll(0.0);
            igaze->lookAtAbsAngles(targetG);
        }

        icartL->storeContext(&ctxtL);
        icartL->getDOF(dof); dof=1.0;
        icartL->setDOF(dof,dof);
        icartL->setLimits(0,torso[0],torso[0]);
        icartL->setLimits(1,torso[1],torso[1]);
        icartL->setLimits(2,torso[2],torso[2]);
        icartL->setPosePriority(priority.c_str());
        icartL->setTrajTime(0.8);

        printf("reaching for left target\n");
        icartL->goToPoseSync(targetL.getCol(3),dcm2axis(targetL));        

        icartR->storeContext(&ctxtR);
        icartR->getDOF(dof); dof=1.0;
        dof[0]=dof[1]=dof[2]=0.0;
        icartR->setDOF(dof,dof);
        icartR->setTrackingMode(true);
        icartR->setPosePriority(priority.c_str());
        icartR->setTrajTime(0.8);

        printf("reaching for right target\n");
        icartR->goToPoseSync(targetR.getCol(3),dcm2axis(targetR));

        printf("waiting for right arm... ");
        icartR->waitMotionDone();
        printf("done\n");

        printf("waiting for left arm... ");
        icartL->waitMotionDone();
        printf("done\n");

        icartL->restoreContext(ctxtL);
        icartL->deleteContext(ctxtL);

        icartR->restoreContext(ctxtR);
        icartR->deleteContext(ctxtR);

        if (targetG.length()>=3)
        {
            igaze->restoreContext(ctxtG);
            igaze->deleteContext(ctxtG);
        }
    }

    /*********************************************/
    void beSuspicious(const Vector &lim=Vector(3,0.0))
    {
        int ctxt;
        igaze->storeContext(&ctxt);

        igaze->blockNeckPitch(lim[0]);
        igaze->blockNeckRoll(lim[1]);
        igaze->blockNeckYaw(lim[2]);

        Vector targetG(3,0.0);

        targetG[0]=-30.0;
        igaze->lookAtAbsAngles(targetG);
        Time::delay(1.0);

        targetG[0]=30.0;
        igaze->lookAtAbsAngles(targetG);
        Time::delay(0.7);

        targetG[0]=0.0;
        igaze->lookAtAbsAngles(targetG);
        igaze->waitMotionDone();

        igaze->restoreContext(ctxt);
        igaze->deleteContext(ctxt);
    }

    /*********************************************/
    int beHappy(const double roll)
    {
        int ctxt;
        igaze->storeContext(&ctxt);

        igaze->blockNeckPitch(-20.0);
        igaze->blockNeckRoll(roll);
        igaze->blockNeckYaw(0.0);
        igaze->blockEyes(0.0);

        Vector targetG(3,0.0);
        igaze->lookAtAbsAngles(targetG);
        
        return ctxt;
    }

    /*********************************************/
    bool posture(const string &part,
                 const string &type,
                 const Vector &x=Vector(3,0.0))
    {
        Vector targetG(3,0.0);
        Matrix targetL=zeros(4,4);
        Matrix targetR=zeros(4,4);
        targetL(3,3)=targetR(3,3)=1.0;

        if (type=="home")
        {
            targetL(0,0)=targetR(0,0)=-1.0;
            targetL(2,1)=targetR(2,1)=-1.0;
            targetL(1,2)=targetR(1,2)=-1.0;

            targetL(0,3)=targetR(0,3)=-0.25;
            targetL(2,3)=targetR(2,3)=0.05;

            targetL(1,3)=-0.3;
            targetR(1,3)=0.3;

            openHand("left");
            openHand("right");

            postureHelper("position",targetL,targetR,targetG);
            return true;
        }
        else if (type=="pinch")
        {
            say("ouch!");
            if (part!="torso")
            {
                printf("looking at (%s)\n",x.toString(3,3).c_str()); 
                igaze->lookAtFixationPoint(x);
                Time::delay(2.0);
                igaze->stopControl();
            }

            emotion(type);
            say("that hurt");

            karateHand("left");
            karateHand("right");
            
            targetL(2,0)=targetR(2,0)=1.0;
            targetL(0,1)=targetR(0,1)=-1.0;
            targetL(1,2)=targetR(1,2)=-1.0;

            targetL(0,3)=-0.35;
            targetL(1,3)=-0.03;
            targetL(2,3)=0.20;

            targetR(0,3)=-0.25;
            targetR(1,3)=0.03;
            targetR(2,3)=0.15;

            Vector r(4,0.0);
            r[1]=-1.0; r[3]=DEG2RAD*30.0;
            targetL=axis2dcm(r)*targetL;
            targetR=axis2dcm(r)*targetR;

            targetG=0.0;

            Vector lim(3,0.0); lim[2]=30.0;            
            postureHelper("orientation",targetL,targetR,targetG,lim);
            say("go ahead, make my day");
            beSuspicious(lim);
            Time::delay(1.0);
            
            say("I'm watching you!");
            posture(part,"home");
            emotion("happy");
            return true;
        }
        else if (type=="poke")
        {
            emotion(type);
            say("what was that?");
            if (part=="torso")
            {
                targetL(0,0)=targetR(0,0)=-1.0;
                targetL(2,1)=targetR(2,1)=-1.0;
                targetL(1,2)=targetR(1,2)=-1.0;

                targetL(0,3)=targetR(0,3)=-0.25;
                targetL(2,3)=targetR(2,3)=0.0;

                targetL(1,3)=-0.25;
                targetR(1,3)=0.25;

                Vector r(4,0.0);
                r[2]=1.0; r[3]=DEG2RAD*20.0;
                targetL=axis2dcm(r)*targetL;

                r[2]=-1.0;
                targetR=axis2dcm(r)*targetR;

                targetG[1]=-90.0;

                openHand("left");
                openHand("right");

                Vector lim(3,0.0); lim[0]=-5.0;                
                postureHelper("orientation",targetL,targetR,targetG,lim);
            }
            else
            {
                printf("looking at (%s)\n",x.toString(3,3).c_str()); 
                igaze->lookAtFixationPoint(x);
                Time::delay(2.0);
                igaze->stopControl();
            }
            
            if (part=="right_arm")
            {
                targetR(0,0)=-1.0;
                targetR(2,1)=-1.0;
                targetR(1,2)=-1.0;
                targetR(0,3)=-0.25;
                targetR(1,3)=0.15;
                targetR(2,3)=0.0;

                targetL(0,0)=-1.0;
                targetL(2,1)=-1.0;
                targetL(1,2)=-1.0;
                targetL(0,3)=-0.25;
                targetL(1,3)=0.05;
                targetL(2,3)=0.2;

                Vector r(4,0.0);
                r[2]=-1.0; r[3]=DEG2RAD*50.0;
                targetL=axis2dcm(r)*targetL;

                targetG[0]=40.0;
                targetG[1]=10.0;

                pointHand("left");
                openHand("right");
            }
            else
            {
                targetL(0,0)=-1.0;
                targetL(2,1)=-1.0;
                targetL(1,2)=-1.0;
                targetL(0,3)=-0.25;
                targetL(1,3)=-0.15;
                targetL(2,3)=0.0;

                if (part=="torso")
                {
                    targetR(0,0)=-1.0;
                    targetR(2,1)=-1.0;
                    targetR(1,2)=-1.0;
                    targetR(0,3)=-0.3;
                    targetR(1,3)=0.10;
                    targetR(2,3)=0.15;

                    targetG=0.0;
                }
                else
                {
                    targetR(0,0)=-1.0;
                    targetR(2,1)=-1.0;
                    targetR(1,2)=-1.0;
                    targetR(0,3)=-0.25;
                    targetR(1,3)=-0.05;
                    targetR(2,3)=0.2;

                    Vector r(4,0.0);
                    r[2]=1.0; r[3]=DEG2RAD*50.0;
                    targetR=axis2dcm(r)*targetR;

                    targetG[0]=-40.0;
                    targetG[1]=10.0;
                }

                pointHand("right");
                openHand("left");
            }

            emotion("you");
            say("was it you?");
            postureHelper("orientation",targetL,targetR,targetG);
            Time::delay(2.0);

            posture(part,"home");
            emotion("happy");
            return true;
        }
        if (type=="caress")
        {
            targetL(0,0)=targetR(0,0)=-1.0;
            targetL(2,1)=targetR(2,1)=-1.0;
            targetL(1,2)=targetR(1,2)=-1.0;

            targetL(0,3)=targetR(0,3)=-0.25;
            targetL(2,3)=targetR(2,3)=0.1;

            targetL(1,3)=-0.15;
            targetR(1,3)=0.15;

            Vector r(4,0.0);
            r[1]=1.0; r[3]=DEG2RAD*20.0;
            targetL=axis2dcm(r)*targetL;
            targetR=axis2dcm(r)*targetR;

            closeHand("left");
            closeHand("right");

            double roll=0.0;
            if (part=="left_arm")
                roll=-30.0;
            else if (part=="right_arm")
                roll=30.0;

            emotion(type);
            say("he, he he he");
            int ctxt=beHappy(roll);

            Vector nolook(1);
            postureHelper("orientation",targetL,targetR,nolook);
            Time::delay(2.0);

            igaze->restoreContext(ctxt);
            igaze->deleteContext(ctxt);

            emotion("happy");
            posture(part,"home");
            return true;
        }
        else
            return false;
    }

    /*********************************************/
    bool getGrant()
    {
        if (iolPortHuman.getOutputCount()==0)
            return true;

        Bottle cmd,reply;
        cmd.addVocab(Vocab::encode("status"));
        if (iolPortStatus.write(cmd,reply))
        {
            if (reply.size()>1)
            {
                if ((reply.get(0).asString()=="ack") &&
                    (reply.get(1).asString()=="idle"))
                {
                    cmd.clear();
                    cmd.addVocab(Vocab::encode("attention"));
                    cmd.addString("stop");
                    printf("sending: %s\n",cmd.toString().c_str());
                    bool ok=iolPortHuman.write(cmd,reply);
                    printf("received: %s\n",reply.toString().c_str());
                    if (ok)
                        return (reply.get(0).asString()=="ack");
                }
            }
        }

        return false;
    }

    /*********************************************/
    bool giveGrant()
    {
        if (iolPortHuman.getOutputCount()==0)
            return true;

        Bottle cmd,reply;
        cmd.addVocab(Vocab::encode("attention"));
        cmd.addString("start");
        printf("sending: %s\n",cmd.toString().c_str());
        bool ok=iolPortHuman.write(cmd,reply);
        printf("received: %s\n",reply.toString().c_str());
        if (ok)
            return (reply.get(0).asString()=="ack");

        return false;
    }

    /*********************************************/
    bool say(const string &sentence)
    {
        if (iolPortHuman.getOutputCount()>0)
        {
            Bottle cmd,reply;
            cmd.addVocab(Vocab::encode("say"));
            cmd.addString(sentence.c_str());
            if (iolPortHuman.write(cmd,reply))
                return (reply.get(0).asString()=="ack");
        }

        return false;
    }

    /*********************************************/
    bool emotion(const string &type)
    {
        if (emotionsPort.getOutputCount()>0)
        {
            map<string,Bottle>::iterator it=emotionsRaw.find(type);
            if (it!=emotionsRaw.end())
            {
                Bottle &b=it->second;
                for (int i=0; i<b.size(); i++)
                {
                    Bottle cmd;
                    cmd.addString(b.get(i).asString());
                    emotionsPort.write(cmd);
                    Time::delay(0.001);
                }

                return true;
            }
        }

        return false;
    }

    /*********************************************/
    void configureEmotions(ResourceFinder &rf)
    {
        int numEmotions=rf.check("num_emotions",Value(0)).asInt();
        for (int i=0; i<numEmotions; i++)
        {
            ostringstream tag;
            tag<<"emotion_"<<i;

            Bottle &emotion=rf.findGroup(tag.str().c_str());
            if (!emotion.isNull())
            {
                if (emotion.check("name"))
                {
                    string name=emotion.find("name").asString().c_str();
                    if (Bottle *raw=emotion.find("raw").asList())
                        emotionsRaw[name]=*raw;
                }
            }
        }
    }

public:
    /*********************************************/
    bool configure(ResourceFinder &rf)
    {
        string robot=rf.check("robot",Value("icub")).asString().c_str();
        string name=rf.check("name",Value("funnyPostures")).asString().c_str();

        rpcPort.open(("/"+name+"/rpc").c_str());
        iolPortStatus.open(("/"+name+"/iol/status:rpc").c_str());
        iolPortHuman.open(("/"+name+"/iol/human:rpc").c_str());
        emotionsPort.open(("/"+name+"/emotions/raw").c_str());

        // open drivers
        Property optionArmL("(device remote_controlboard)");
        optionArmL.put("remote",("/"+robot+"/left_arm").c_str());
        optionArmL.put("local",("/"+name+"/joint/left").c_str());
        if (!drvArmL.open(optionArmL))
            printf("Position left_arm controller not available!\n");

        Property optionArmR("(device remote_controlboard)");
        optionArmR.put("remote",("/"+robot+"/right_arm").c_str());
        optionArmR.put("local",("/"+name+"/joint/right").c_str());
        if (!drvArmR.open(optionArmR))
            printf("Position right_arm controller not available!\n");

        Property optionCartL("(device cartesiancontrollerclient)");
        optionCartL.put("remote",("/"+robot+"/cartesianController/left_arm").c_str());
        optionCartL.put("local",("/"+name+"/cartesian/left").c_str());
        if (!drvCartL.open(optionCartL))
            printf("Cartesian left_arm controller not available!\n");

        Property optionCartR("(device cartesiancontrollerclient)");
        optionCartR.put("remote",("/"+robot+"/cartesianController/right_arm").c_str());
        optionCartR.put("local",("/"+name+"/cartesian/right").c_str());
        if (!drvCartR.open(optionCartR))
            printf("Cartesian right_arm controller not available!\n");

        Property optionGaze("(device gazecontrollerclient)");
        optionGaze.put("remote","/iKinGazeCtrl");
        optionGaze.put("local",("/"+name+"/gaze").c_str());
        if (!drvGaze.open(optionGaze))
            printf("Gaze controller not available!\n");
        
        // quitting condition
        if (!drvArmL.isValid()  || !drvArmR.isValid()  ||
            !drvCartL.isValid() || !drvCartR.isValid() ||
            !drvGaze.isValid())
        {
            printf("Something wrong occured while configuring drivers... quitting!\n");
            terminate();
            return false;
        }

        // open devices views
        drvArmL.view(iencsL); drvArmL.view(ipossL); drvCartL.view(icartL);
        drvArmR.view(iencsR); drvArmR.view(ipossR); drvCartR.view(icartR);
        drvGaze.view(igaze);
        iencsL->getAxes(&nEncs);

        attach(rpcPort);

        configureEmotions(rf);

        return true;
    }

    /*********************************************/
    double getPeriod()
    {
        return 1.0;
    }

    /*********************************************/
    bool updateModule()
    {
        return true;
    }

    /*********************************************/
    bool respond(const Bottle &cmd, Bottle &reply)
    {
        int ack=Vocab::encode("ack");
        int nack=Vocab::encode("nack");

        Value item=cmd.get(0);
        if (item.isString())
        {
            if (item.asString()=="home")
            {
                if (getGrant())
                {
                    posture("foo","home");
                    giveGrant();
                    reply.addVocab(ack);
                }
                else
                    reply.addVocab(nack);

                return true;
            }
        }

        int ans=nack;
        if (Bottle *what=item.asList())
        {
            if (what->size()>1)
            {                
                string part=what->get(0).asString().c_str();
                string type=what->get(1).asString().c_str();

                Vector x(3,0.0);
                if (cmd.size()>1)
                    if (Bottle *where=cmd.get(1).asList())
                        for (int i=0; i<where->size(); i++)
                            x[i]=where->get(i).asDouble();
                
                if (getGrant())
                {
                    ans=posture(part,type,x)?ack:nack;
                    giveGrant();
                }
                else
                    ans=nack;
            }
        }
        
        Bottle rep;
        if (ans==ack)
            reply.addVocab(ack);
        else if (RFModule::respond(cmd,rep))
            reply=rep;
        else
            reply.addVocab(nack);

        return true;
    }

    /*********************************************/
    void terminate()
    {
        rpcPort.close();
        iolPortStatus.close();
        iolPortHuman.close();
        emotionsPort.close();

        if (drvArmL.isValid())
            drvArmL.close();

        if (drvArmR.isValid())
            drvArmR.close();

        if (drvCartL.isValid())
            drvCartL.close();

        if (drvCartR.isValid())
            drvCartR.close();

        if (drvGaze.isValid())
            drvGaze.close();    
    }

    /*********************************************/
    bool close()
    {
        terminate();
        return true;
    }

};


/****************************************************************/
int main(int argc, char *argv[])
{
    Network yarp;
    if (!yarp.checkNetwork())
    {
        printf("YARP server not available!\n");
        return 1;
    }

    ResourceFinder rf;
    rf.setDefaultContext("funny-things");
    rf.setDefaultConfigFile("emotions.ini");
    rf.configure(argc,argv);
    
    PosturesModule mod;
    return mod.runModule(rf);
}



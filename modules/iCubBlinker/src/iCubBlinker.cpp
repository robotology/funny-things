/* 
 * Copyright (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
 * Author: Ugo Pattacini & Alessandro Roncone
 * email:  ugo.pattacini@iit.it
 * website: www.robotcub.org
 * Permission is granted to copy, distribute, and/or modify this program
 * under the terms of the GNU General Public License, version 2 or any
 * later version published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details
*/

#include <iostream>
#include <fstream>
#include <iomanip>
#include <string>

#include <yarp/os/all.h>
#include <yarp/math/Rand.h>
#include <yarp/math/NormRand.h>

#include "iCubBlinker_IDL.h"

using namespace std;
using namespace yarp::os;
using namespace yarp::math;

enum InteractionMode
{ 
    INTERACTION_MODE_UNKNOWN=0, 
    INTERACTION_MODE_IDLE, INTERACTION_MODE_CONVERSATION,
    INTERACTION_MODE_CALIBRATION_CLOSURE,INTERACTION_MODE_CALIBRATION_OPENING
};

string int2hex(const int _i)
{
    std::ostringstream hex;
    hex << std::hex << _i;
    return hex.str();
}

string int2string(const int _a)
{
    std::ostringstream ss;
    ss << _a;
    return ss.str();
}

/***************************************************************/
class Blinker: public RFModule, public iCubBlinker_IDL
{
private:
    // Resource finder used to find for files and configurations:
    ResourceFinder* rf;

    string name,robot;

    Port emotionsPort;
    RpcServer rpcPort;

    Mutex mutex;
    bool blinking;

    double min_dt,max_dt;

    double dt,t0;
    int doubleBlinkCnt;

    InteractionMode int_mode;
    double blinkper_nrm, blinkper_sgm;  // period of the blinking
    double closure_nrm, closure_sgm;    // closure statistics
    double sustain_nrm, sustain_sgm;    // sustain statistics
    double opening_nrm, opening_sgm;    // opening statistics

    string eyelids_open;    // it's the `E` command
    string eyelids_closed;  // it's the `U` command

    /***************************************************************/
    bool sendRawValue(const string &_value)
    {
        if (emotionsPort.getOutputCount()>0)
        {
            Bottle cmd;
            cmd.addString(_value);
            emotionsPort.write(cmd);

            return true;
        }
        else
            return false;
    }

    /***************************************************************/
    bool doSingleBlink()
    {
        LockGuard lg(mutex);

        bool res = true;

        res = res && sendRawValue("S00"); // close eyelids
        Time::delay(0.05);

        res = res && sendRawValue("S99"); // open  eyelids
        Time::delay(0.05);

        return res;
    }

    /***************************************************************/
    bool doBlinkTimed()
    {
        double t_cl = NormRand::scalar(closure_nrm,closure_sgm);
        // Cut the normal distribution to its first sigma
        while (t_cl<closure_nrm-closure_sgm || t_cl>closure_nrm+closure_sgm)
        {
            t_cl = NormRand::scalar(closure_nrm,closure_sgm);
        }
         
        double t_su = NormRand::scalar(sustain_nrm,sustain_sgm);
        // Cut the normal distribution to its first sigma
        while (t_su<sustain_nrm-sustain_sgm || t_su>sustain_nrm+sustain_sgm)
        {
            t_su = NormRand::scalar(sustain_nrm,sustain_sgm);
        }

        double t_op = NormRand::scalar(opening_nrm,opening_sgm);
        // Cut the normal distribution to its first sigma
        while (t_op<opening_nrm-opening_sgm || t_op>opening_nrm+opening_sgm)
        {
            t_op = NormRand::scalar(opening_nrm,opening_sgm);
        }

        yDebug("Starting a timed blink. T_cl %g \t T_su %g \t T_op %g Total %g",
                t_cl,t_su,t_op,t_cl+t_su+t_op);

        for (int i = 0; i < 11; i++)
        {
            string rawvalue = "S" + int2string(100-i*10);
            yDebug("Sending raw value: %s %i",rawvalue.c_str(),100-i*10);
            sendRawValue(rawvalue);
            Time::delay(t_cl/10.0);
        }

        Time::delay(t_su);

        for (int i = 0; i < 11; i++)
        {
            string rawvalue = "S" + int2string(i*10);
            yDebug("Sending raw value: %s %i",rawvalue.c_str(),i*10);
            sendRawValue(rawvalue);
            Time::delay(t_op/10.0);
        }
    }

    /***************************************************************/
    bool set_calib_values()
    {
        bool res = true;
        res = res && sendRawValue(eyelids_closed); // close eyelids
        res = res && sendRawValue(eyelids_open);   // open  eyelids

        return res;
    }

    /***************************************************************/
    bool setInteractionMode_IDLE()
    {
        // we should set:
        //   1. the frequency of multiple blinks
        //   2. the speed with which the icub closes its eyes
        //   3. the time the icub stays with the eyes closed
        //   4. the speed with which the icub opens its eyes

        blinkper_nrm = 5.2;             blinkper_sgm = 3.7;
        
        // These would be the "slow" settings:
        closure_nrm = 0.111;            closure_sgm = 0.031;
        sustain_nrm = 0.020;            sustain_sgm = 0.005;
        opening_nrm = 0.300;            opening_sgm = 0.123;

        // // These would be the "fast" settings:
        // closure_nrm = 0.111-0.031;            closure_sgm = 0.031;
        // sustain_nrm = 0.020-0.005;            sustain_sgm = 0.005;
        // opening_nrm = 0.300-0.123;            opening_sgm = 0.123;

        int_mode = INTERACTION_MODE_IDLE;

        return true;
    }

    /***************************************************************/    
    bool setInteractionMode_CONVERSATION()
    {
        // we should set:
        //   1. the frequency of multiple blinks
        //   2. the speed with which the icub closes its eyes
        //   3. the time the icub stays with the eyes closed
        //   4. the speed with which the icub opens its eyes

        blinkper_nrm = 2.3;             blinkper_sgm = 2.0;

        // These would be the "slow" settings:
        closure_nrm = 0.111;            closure_sgm = 0.031;
        sustain_nrm = 0.020;            sustain_sgm = 0.005;
        opening_nrm = 0.300;            opening_sgm = 0.123;

        // // These would be the "fast" settings:
        // closure_nrm = 0.111-0.031;            closure_sgm = 0.031;
        // sustain_nrm = 0.020-0.005;            sustain_sgm = 0.005;
        // opening_nrm = 0.300-0.123;            opening_sgm = 0.123;

        int_mode = INTERACTION_MODE_CONVERSATION;

        return true;
    }

public:
    /***************************************************************/
    bool configure(ResourceFinder &_mainRF)
    {
        rf = const_cast<ResourceFinder*>(&_mainRF);

        name =rf->check("name", Value("iCubBlinker")).asString().c_str();
        robot=rf->check("robot",Value("icub")).asString().c_str();

        // min_dt=rf->check("min_dt",Value(3.0)).asDouble();
        // max_dt=rf->check("max_dt",Value(10.0)).asDouble();

        blinking=rf->check("autoStart");

        emotionsPort.open(("/"+name+"/emotions/raw").c_str());
        Network::connect(emotionsPort.getName().c_str(),"/"+robot+"/face/raw/in");

        rpcPort.open(("/"+name+"/rpc").c_str());
        attach(rpcPort);

        load();

        Rand::init();
        NormRand::init();
        doubleBlinkCnt=0;
        
        dt = NormRand::scalar(blinkper_nrm,blinkper_sgm);
        // Cut the normal distribution to its first sigma
        while (dt<blinkper_nrm-blinkper_sgm || dt>blinkper_nrm+blinkper_sgm)
        {
            dt = NormRand::scalar(blinkper_nrm,blinkper_sgm);
        }
        t0=Time::now();

        int_mode = INTERACTION_MODE_IDLE;
        set_interaction_mode("idle");

        return true;
    }

    /************************************************************************/
    bool attach(RpcServer &source)
    {
        return this->yarp().attachAsServer(source);
    }

    /***************************************************************/
    bool close()
    {
        emotionsPort.close();
        rpcPort.close();
        return true;
    }

    /***************************************************************/
    double getPeriod() { return 0.01; }

    bool blink_start()
    {
        blinking=true;
        return true;
    }

    bool blink_stop()
    {
        blinking=false;
        return true;
    }

    string blink_status()
    {
        string res=blinking?"on":"off";
        res=res+"_"+get_interaction_mode();
        return res;
    }

    bool blink()
    {
        return doBlinkTimed();
        // return doSingleBlink();
    }

    bool dblink()
    {
        return doBlinkTimed() && doBlinkTimed();
        // return doSingleBlink() && doSingleBlink();
    }

    /***************************************************************/
    string save()
    {
        LockGuard lg(mutex);
        string path    = rf->getHomeContextPath().c_str();
        string inifile = path+"/"+rf->find("from").asString();
        yInfo("Saving calib configuration to %s",inifile.c_str());

        ofstream myfile;
        myfile.open(inifile.c_str(),ios::trunc);

        if (myfile.is_open())
        {
            myfile << "name  \t"  << name   << endl;
            myfile << "robot \t"  << robot  << endl;
            myfile << "min_dt\t"  << min_dt << endl;
            myfile << "max_dt\t"  << max_dt << endl;
            if (rf->check("autoStart"))
            {
                myfile << "autoStart" << endl;
            }
            myfile << "calib \t(" << eyelids_closed << "\t" << eyelids_open << ")\n";
        }
        myfile.close();
        return inifile;
    }

    /***************************************************************/
    string load()
    {
        LockGuard lg(mutex);
        rf->setVerbose(true);
        string fileName=rf->findFile(rf->find("from").asString().c_str());
        rf->setVerbose(false);
        if (fileName=="")
        {
            yWarning("[iCubBlinker::load] No filename has been found. Skipping..");
            return string("");
        }

        yInfo("[iCubBlinker::load] File loaded: %s", fileName.c_str());
        yWarning("[iCubBlinker::load] Only the calib values will be loaded.");
        Property data; data.fromConfigFile(fileName.c_str());
        Bottle b; b.read(data);
        Bottle calib=*(b.find("calib").asList());

        if (calib.size() > 0)
        {
            eyelids_closed = calib.get(0).asString();
            eyelids_open   = calib.get(1).asString();

            yInfo("[iCubBlinker::load] Eyelid calibs loaded: (%s %s)", eyelids_closed.c_str(), eyelids_open.c_str());

            return fileName;
        }

        eyelids_open   = "E99";
        eyelids_closed = "U00";

        set_calib_values();

        return string("");
    }

    bool set_interaction_mode(const std::string& val)
    {
        bool res = false;

        if (val == "idle")
        {
            res = setInteractionMode(INTERACTION_MODE_IDLE);
        }
        else if (val == "conversation")
        {
            res = setInteractionMode(INTERACTION_MODE_CONVERSATION);
        }

        yInfo("Setting interaction mode to %s",get_interaction_mode().c_str());

        return res;
    }

    bool  set_min_dt(const double val)
    {
        min_dt = val;
        return true;
    }

    bool  set_max_dt(const double val)
    {
        max_dt = val;
        return true;
    }

    double get_min_dt() { return min_dt; }
    double get_max_dt() { return max_dt; }

    /***************************************************************/
    bool setInteractionMode(InteractionMode _int_mode)
    {
        if (_int_mode==INTERACTION_MODE_IDLE)
        {
            return setInteractionMode_IDLE();
        }
        else if (_int_mode==INTERACTION_MODE_CONVERSATION)
        {
            return setInteractionMode_CONVERSATION();
        }
        else
        {
            int_mode = _int_mode;
            return true;
        }
    }

    /***************************************************************/
    string get_interaction_mode()
    {
        if (int_mode == INTERACTION_MODE_UNKNOWN)
        {
            return "interaction_mode_unknown";
        }
        else if (int_mode == INTERACTION_MODE_IDLE)
        {
            return "idle";
        }
        else if (int_mode == INTERACTION_MODE_CONVERSATION)
        {
            return "conversation";
        }
        else if (int_mode == INTERACTION_MODE_CALIBRATION_OPENING || 
                 int_mode == INTERACTION_MODE_CALIBRATION_CLOSURE)
        {
            return "calibration";
        }

        return string("");
    }

    /***************************************************************/
    bool calib()
    {
        yError("Not yet implemented!");
        return false;
    }

    /***************************************************************/
    bool updateModule()
    {
        LockGuard lg(mutex);

        if (Time::now()-t0>=dt)
        {
            if (blinking)
            {
                if (int_mode == INTERACTION_MODE_IDLE || int_mode == INTERACTION_MODE_CONVERSATION)
                {
                    doBlinkTimed();
                    if ((++doubleBlinkCnt)%5==0)
                    {
                        doBlinkTimed();
                        doubleBlinkCnt=0;
                    }
                }
                else
                {
                    doSingleBlink();
                    if ((++doubleBlinkCnt)%5==0)
                    {
                        doSingleBlink();
                        doubleBlinkCnt=0;
                    }
                }
            }

            dt = NormRand::scalar(blinkper_nrm,blinkper_sgm);
            // Cut the normal distribution to its first sigma
            while (dt<blinkper_nrm-blinkper_sgm || dt>blinkper_nrm+blinkper_sgm)
            {
                dt = NormRand::scalar(blinkper_nrm,blinkper_sgm);
            }

            t0=Time::now();
        }

        return true;
    }
};

/***************************************************************/
int main(int argc, char *argv[])
{
    ResourceFinder rf;
    rf.setDefaultContext("funnyThings");
    rf.setDefaultConfigFile("iCubBlinker.ini");
    rf.configure(argc,argv);

    if (rf.check("help"))
    {    
        printf("\n");
        yInfo("[ICUB BLINKER] Options:");
        yInfo("  --context    path:   where to find the called resource (default funnyThings).");
        yInfo("  --from       from:   the name of the .ini file (default iCubBlinker.ini).");
        yInfo("  --name       name:   the name of the module (default iCubBlinker).");
        yInfo("  --robot      robot:  the name of the robot. Default icub.");
        // yInfo("  --min_dt     double: the default minimum delta T between consecutive blinks. Default  3.0[s].");
        // yInfo("  --max_dt     double: the default maximum delta T between consecutive blinks. Default 10.0[s].");
        yInfo("  --autoStart  flag:   If the module should autostart the blinking behavior. Default no.");
        printf("\n");
        return 0;
    }

    Network yarp;
    if (!yarp.checkNetwork())
    {
        yError("YARP server not available!");
        return -1;
    }

    Blinker blinker;
    return blinker.runModule(rf);
}



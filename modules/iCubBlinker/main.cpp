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

#include <mutex>
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

string double2string(const double _a)
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

    string name;
    string robot;

    bool doubleBlink;
    string blinkingBehavior;
    string blinkingPeriod;

    Port emotionsPort;
    RpcServer rpcPort;

    mutex mtx;
    bool isBlinking;

    double dt;
    double t0;
    int doubleBlinkCnt;

    int sMin;
    int sMax;

    InteractionMode int_mode;
    double fixed_blinkper;

    double blinkper_nrm, blinkper_sgm;  // period of the blinking
    double closure_nrm,   closure_sgm;  // closure statistics
    double sustain_nrm,   sustain_sgm;  // sustain statistics
    double opening_nrm,   opening_sgm;  // opening statistics

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
    bool doBlink()
    {
        if (blinkingBehavior=="naturalistic")
        {
            return doBlinkNaturalistic();
        }
        else if (blinkingBehavior=="fast")
        {
            return doBlinkFast();
        }
        else
        {
            yError("Blinking behavior is neither naturalistic or fast!");
            return false;
        }
    }

    /***************************************************************/
    bool doBlinkFast()
    {
        bool res = true;
        yDebug("Sending raw value: %i",sMin);
        res = res && sendRawValue(("S" + int2string(sMin))); // close eyelids
        Time::delay(0.15);

        yDebug("Sending raw value: %i",sMax);
        res = res && sendRawValue(("S" + int2string(sMax))); // open  eyelids
        Time::delay(0.05);

        return res;
    }

    /***************************************************************/
    bool doBlinkNaturalistic()
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

        yDebug("Starting a naturalistic blink. T_cl %g \t T_su %g \t T_op %g Total %g",
                t_cl,t_su,t_op,t_cl+t_su+t_op);

        for (int i = 0; i < 11; i++)
        {
            int valueToSend = sMax-i*(sMax-sMin)/10;
            string rawvalue = "S" + int2string(valueToSend);
            yDebug("Sending raw value: %s %i",rawvalue.c_str(),100-i*10);
            sendRawValue(rawvalue);
            Time::delay(t_cl/10.0);
        }

        Time::delay(t_su);

        for (int i = 0; i < 11; i++)
        {
            int valueToSend = sMin+i*(sMax-sMin)/10;
            string rawvalue = "S" + int2string(valueToSend);
            yDebug("Sending raw value: %s %i",rawvalue.c_str(),i*10);
            sendRawValue(rawvalue);
            Time::delay(t_op/10.0);
        }

        return true;
    }

    /***************************************************************/
    bool set_calib_values()
    {
        yWarning("[iCubBlinker] Sending calib values does nothing currently!");

        return false;
    }

    /***************************************************************/
    bool setInteractionMode_IDLE()
    {
        Bottle idle_mode=(rf->findGroup("idle_mode"));

        if (idle_mode.size()>0)
        {
            bool res = retrieveInteractionMode_params(idle_mode);
            if (res)
            {
                int_mode = INTERACTION_MODE_IDLE;
            }
            return res;
        }
        else
        {
            yError("[iCubBlinker] no idle_mode group found in .ini file!");
            return false;
        }

        return true;
    }

    /***************************************************************/
    bool setInteractionMode_CONVERSATION()
    {
        Bottle conversation_mode=(rf->findGroup("conversation_mode"));

        if (conversation_mode.size()>0)
        {
            bool res = retrieveInteractionMode_params(conversation_mode);
            if (res)
            {
                int_mode = INTERACTION_MODE_CONVERSATION;
            }
            return res;
        }
        else
        {
            yError("[iCubBlinker] no conversation_mode group found in ini file!");
            return false;
        }

        return true;
    }

    /***************************************************************/
    bool retrieveInteractionMode_params(Bottle &int_mode)
    {
        // If the parameters are not found, it will default to the idle mode
        blinkper_nrm = int_mode.check("blinkper_nrm",Value(5.2)).asDouble();
        blinkper_sgm = int_mode.check("blinkper_sgm",Value(3.7)).asDouble();

        closure_nrm = int_mode.check("closure_nrm",Value(0.111)).asDouble();
        closure_sgm = int_mode.check("closure_sgm",Value(0.031)).asDouble();

        sustain_nrm = int_mode.check("sustain_nrm",Value(0.020)).asDouble();
        sustain_sgm = int_mode.check("sustain_sgm",Value(0.005)).asDouble();

        opening_nrm = int_mode.check("opening_nrm",Value(0.300)).asDouble();
        opening_sgm = int_mode.check("opening_sgm",Value(0.123)).asDouble();

        return true;
    }

    /***************************************************************/
    string InteractionMode_params_toString()
    {
        stringstream res;

        res << "[" << name << "] blinker period:\t[ nrm " << blinkper_nrm << "\tsgm " << blinkper_sgm << " ]" << endl;
        res << "[" << name << "] closure speed: \t[ nrm " << closure_nrm  << "\tsgm " << closure_sgm  << " ]" << endl;
        res << "[" << name << "] sustain speed: \t[ nrm " << sustain_nrm  << "\tsgm " << sustain_sgm  << " ]" << endl;
        res << "[" << name << "] opening speed: \t[ nrm " << opening_nrm  << "\tsgm " << opening_sgm  << " ]" << endl;

        return res.str();
    }

    /***************************************************************/
    bool computeNextBlinkPeriod()
    {
        if (blinkingPeriod=="fixed")
        {
            dt=fixed_blinkper;
            yInfo("[iCubBlinker] Next blink in %g [s]",dt);
            return true;
        }
        else if (blinkingPeriod=="gaussian")
        {
            dt=1e9;
            int i=0;

            // Cut the normal distribution to its first sigma
            while (dt<blinkper_nrm-blinkper_sgm || dt>blinkper_nrm+blinkper_sgm)
            {
                dt = NormRand::scalar(blinkper_nrm,blinkper_sgm);
                yDebug("[iCubBlinker] Computing next blink.. %g %g %g %i",dt,blinkper_nrm-blinkper_sgm,blinkper_nrm+blinkper_sgm,i); i++;
            }
            yInfo("[iCubBlinker] Next blink in %g [s]",dt);
            return true;
        }
        else
        {
            yError("blinkingPeriod was neither gaussian nor fixed!");
            return false;
        }
    }

public:
    /***************************************************************/
    bool configure(ResourceFinder &_mainRF)
    {
        rf = const_cast<ResourceFinder*>(&_mainRF);

        name =rf->check("name", Value("iCubBlinker")).asString().c_str();
        robot=rf->check("robot",Value("icub")).asString().c_str();
        blinkingBehavior=rf->check("blinkingBehavior",Value("fast")).asString().c_str();
        blinkingPeriod=rf->check("blinkingPeriod",Value("fixed")).asString().c_str();
        fixed_blinkper=rf->check("fixedBlinkPer",Value(5.0)).asDouble();

        isBlinking=rf->check("autoStart");

        emotionsPort.open(("/"+name+"/emotions/raw").c_str());
        if (rf->check("autoConnect"))
        {
            Network::connect(emotionsPort.getName().c_str(),"/"+robot+"/face/raw/in");
        }

        doubleBlink=rf->check("doubleBlink");

        rpcPort.open(("/"+name+"/rpc").c_str());
        attach(rpcPort);

        Bottle calib=(rf->findGroup("calibration"));

        if (calib.size() > 0)
        {
            sMin = calib.check("sMin",Value(00)).asInt();
            sMax = calib.check("sMax",Value(70)).asInt();

            yInfo("[iCubBlinker] Eyelid calibs loaded: (%i %i)", sMin, sMax);
        }
        else
        {
            sMin = 00;
            sMax = 70;
        }

        Rand::init();
        NormRand::init();
        doubleBlinkCnt=0;
        
        int_mode = INTERACTION_MODE_IDLE;
        set_interaction_mode("idle");

        computeNextBlinkPeriod();
        t0=Time::now();

        print_params();

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

    bool start()
    {
        yInfo("[iCubBlinker] start command received");
        isBlinking=true;
        return true;
    }

    bool stop()
    {
        yInfo("[iCubBlinker] stop  command received");
        isBlinking=false;
        return true;
    }

    string status()
    {
        string res=isBlinking?"on":"off";
        res=res+"_"+get_interaction_mode();
        return res;
    }

    bool blink()
    {
        t0=Time::now();
        return doBlink();
    }

    bool blink_fast()
    {
        t0=Time::now();
        return doBlinkFast();
    }

    bool blink_naturalistic()
    {
        t0=Time::now();
        return doBlinkNaturalistic();
    }

    bool dblink()
    {
        t0=Time::now();
        return doBlink() && doBlink();
    }

    /***************************************************************/
    string print_params()
    {
        stringstream res;

        res << endl;
        res << "[" << name << "] robot: " << robot << endl;
        res << "[" << name << "] blinkingBehavior: " << blinkingBehavior;
        res << "\tblinkingPeriod: " << blinkingPeriod << "\tFixed Blink period: " << fixed_blinkper << endl;
        res << "[" << name << "] isBlinking: " << (isBlinking?"true":"false") << "\tdoubleBlink: " << get_double_blink() << endl;
        res << "[" << name << "] calibration [sMin sMax]: [" << sMin << " " << sMax << "]" << endl;
        res << "[" << name << "] InteractionMode: " << get_interaction_mode() << endl;
        res << InteractionMode_params_toString();

        printf("%s\n", res.str().c_str());

        return res.str();
    }

    /***************************************************************/
    string save()
    {
        string path    = rf->getHomeContextPath().c_str();
        string inifile = path+"/"+rf->find("from").asString();
        yInfo("Saving calib configuration to %s",inifile.c_str());

        ofstream myfile;
        myfile.open(inifile.c_str(),ios::trunc);

        if (myfile.is_open())
        {
            myfile << "name  \t"  << name   << endl;
            myfile << "robot \t"  << robot  << endl;
            if (rf->check("autoStart"))
            {
                myfile << "autoStart" << endl;
            }
            myfile << "calib \t(" << sMin << "\t" << sMax << ")\n";
        }
        myfile.close();
        return inifile;
    }

    /***************************************************************/
    string load()
    {
        string fileName=rf->findFile(rf->find("from").asString().c_str());
        if (fileName=="")
        {
            yWarning("[iCubBlinker::load] No filename has been found. Skipping..");
            return string("");
        }

        yInfo("[iCubBlinker::load] File loaded: %s", fileName.c_str());
        yWarning("[iCubBlinker::load] Only the calib values will be loaded.");
        Property data; data.fromConfigFile(fileName.c_str());
        Bottle b; b.read(data);
        Bottle calib=(b.findGroup("calibration"));

        if (calib.size() > 0)
        {
            sMin = calib.check("sMin",Value(00)).asInt();
            sMax = calib.check("sMax",Value(70)).asInt();

            yInfo("[iCubBlinker::load] Eyelid calibs loaded: (%i %i)", sMin, sMax);

            return fileName;
        }

        // set_calib_values();

        return string("");
    }

    /***************************************************************/
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

        yInfo("[iCubBlinker] Interaction mode set to %s",get_interaction_mode().c_str());
        printf("%s\n",InteractionMode_params_toString().c_str());

        return res;
    }

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
    bool set_blinking_behavior(const std::string& val)
    {
        bool res=false;

        if (val=="naturalistic" || val=="fast")
        {
            blinkingBehavior=val;
            res=true;
        }
        else
        {
            yError("Invalid blinking behavior requested! %s",val.c_str());
        }

        yInfo("Blinking behavior set to %s",get_blinking_behavior().c_str());

        return res;
    }

    /***************************************************************/
    string get_blinking_behavior()
    {
        return blinkingBehavior;
    }

    /***************************************************************/
    bool set_blinking_period(const std::string& val)
    {
        bool res=false;

        if (val=="gaussian" || val=="fixed")
        {
            blinkingPeriod=val;
            res=true;
        }
        else
        {
            yError("Invalid blinking period requested! %s",val.c_str());
        }

        yInfo("Blinking period set to %s",get_blinking_period().c_str());

        return res;
    }

    /***************************************************************/
    string get_blinking_period()
    {
        if (blinkingPeriod=="gaussian")
        {
            return blinkingPeriod;
        }
        else 
        {
            return blinkingPeriod + " (" + double2string(fixed_blinkper) + " [s])";
        }
    }

    /***************************************************************/
    bool set_double_blink(const string &val)
    {
        if (val=="on")
        {
            doubleBlink=true;
        }
        else if (val=="off")
        {
            doubleBlink=false;
        }
        else
        {
            return false;
        }
        
        return true;
    }

    /***************************************************************/
    string get_double_blink()
    {
        return (doubleBlink?"on":"off");
    }

    /***************************************************************/
    bool updateModule()
    {
        lock_guard<mutex> lg(mtx);

        if (Time::now()-t0>=dt)
        {
            if (isBlinking)
            {
                doBlink();
                if (doubleBlink)
                {
                    if ((++doubleBlinkCnt)%5==0)
                    {
                        doBlink();
                        doubleBlinkCnt=0;
                    }
                }

                computeNextBlinkPeriod();
                t0=Time::now();
            }
        }

        return true;
    }
};

/***************************************************************/
int main(int argc, char *argv[])
{
    ResourceFinder rf;
    rf.setDefaultContext("funny-things");
    rf.setDefaultConfigFile("iCubBlinker.ini");
    rf.configure(argc,argv);

    if (rf.check("help"))
    {    
        printf("\n");
        yInfo("[ICUB BLINKER] Options:");
        yInfo("  --context           path:   where to find the called resource (default funnyThings).");
        yInfo("  --from              from:   the name of the .ini file (default iCubBlinker.ini).");
        yInfo("  --name              name:   the name of the module (default iCubBlinker).");
        yInfo("  --robot             robot:  the name of the robot. Default icub.");
        yInfo("  --autoStart         flag:   If the module should autostart the blinking behavior. Default no.");
        yInfo("  --autoConnect       flag:   If the module should autoconnect itself to the face expression port. Default no.");
        yInfo("  --blinkingBehavior  string: String that specifies the desired blinking behavior (either naturalistic or fast).");
        yInfo("  --blinkingPeriod    string: String that specifies the desired blinking period   (either gaussian or fixed).");
        yInfo("  --fixedBlinkPer     double: the blinking period in case of fixed blinkingPeriod (default 5.0).");
        yInfo("  --calibration::sMin int:    Manually set the minimum value for the blinking behavior (default 00).");
        yInfo("  --calibration::sMax int:    Manually set the maximum value for the blinking behavior (default 70).");
        printf("\n");
        return 0;
    }

    Network yarp;
    if (!yarp.checkNetwork())
    {
        yError("YARP server not available!");
        return 1;
    }

    Blinker blinker;
    return blinker.runModule(rf);
}



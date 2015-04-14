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

using namespace std;
using namespace yarp::os;
using namespace yarp::math;

enum InteractionMode
{ 
    INTERACTION_MODE_UNKNOWN=0, 
    INTERACTION_MODE_IDLE, INTERACTION_MODE_CONVERSATION
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
class Blinker: public RFModule
{
private:
    // Resource finder used to find for files and configurations:
    ResourceFinder* rf;

    string name,robot;

    Port emotionsPort;
    RpcServer rpcPort;

    Mutex mutex;
    bool blinking;
    double min_dt,max_dt,dt,t0;
    int doubleBlinkCnt;

    InteractionMode int_mode;

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
    bool blink()
    {
        bool res = true;

        res = res && sendRawValue("S00"); // close eyelids
        Time::delay(0.05);

        res = res && sendRawValue("S5A"); // open  eyelids
        Time::delay(0.05);

        return res;
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
        rf->setVerbose(true);
        string fileName=rf->findFile(rf->find("from").asString().c_str());
        rf->setVerbose(false);
        if (fileName=="")
        {
            yWarning("[vtRF::load] No filename has been found. Skipping..");
            return string("");
        }

        yInfo("[iCubBlinker::load] File loaded: %s", fileName.c_str());
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

        set_calib();

        return string("");
    }

    /***************************************************************/
    bool set_calib()
    {
        bool res = true;
        res = res && sendRawValue(eyelids_closed); // close eyelids
        res = res && sendRawValue(eyelids_open);   // open  eyelids

        return res;
    }

public:
    /***************************************************************/
    bool configure(ResourceFinder &_mainRF)
    {
        rf = const_cast<ResourceFinder*>(&_mainRF);

        name =rf->check("name", Value("iCubBlinker")).asString().c_str();
        robot=rf->check("robot",Value("icub")).asString().c_str();

        min_dt=rf->check("min_dt",Value(3.0)).asDouble();
        max_dt=rf->check("max_dt",Value(10.0)).asDouble();

        blinking=rf->check("autoStart");

        // string path = rf->getHomeContextPath().c_str();
        // path = path+"/";
        // if (rf->check("taxelsFile"))
        // {
        //     taxelsFile = rf->find("taxelsFile").asString();
        // }
        // else
        // {
        //     taxelsFile = "taxels"+modality+".ini";
        //     rf->setDefault("taxelsFile",taxelsFile.c_str());
        // }
        // yInfo("Storing file set to: %s", (path+taxelsFile).c_str());

        emotionsPort.open(("/"+name+"/emotions/raw").c_str());
        Network::connect(emotionsPort.getName().c_str(),"/"+robot+"/face/raw/in");

        rpcPort.open(("/"+name+"/rpc").c_str());
        attach(rpcPort);

        load();

        Rand::init();
        doubleBlinkCnt=0;
        dt=Rand::scalar(min_dt,max_dt);
        t0=Time::now();

        int_mode = INTERACTION_MODE_UNKNOWN;

        return true;
    }

    /***************************************************************/
    bool close()
    {
        emotionsPort.close();
        rpcPort.close();
        return true;
    }

    /***************************************************************/
    double getPeriod()
    {
        return 0.1;
    }

    /***************************************************************/
    double getMinDT()
    {
        return min_dt;
    }

    /***************************************************************/
    double getMaxDT()
    {
        return max_dt;
    }

    /***************************************************************/
    void setMinDT(const double _min_dt)
    {
        min_dt = _min_dt;
    }

    /***************************************************************/
    void setMaxDT(const double _max_dt)
    {
        max_dt = _max_dt;
    }

    /***************************************************************/
    bool setInteractionMode_IDLE()
    {
        // we should set:
        //   1. the frequency of multiple blinks
        //   2. the speed with which the icub closes its eyes
        //   3. the time the icub stays with the eyes closed
        //   4. the speed with which the icub opens its eyes
        //   
        
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
        //   

        int_mode = INTERACTION_MODE_CONVERSATION;

        return true;
    }

    /***************************************************************/
    string getInteractionMode()
    {
        if (int_mode == INTERACTION_MODE_UNKNOWN)
        {
            return "unknown";
        }
        else if (int_mode == INTERACTION_MODE_IDLE)
        {
            return "idle";
        }
        else if (int_mode == INTERACTION_MODE_CONVERSATION)
        {
            return "conversation";
        }
    }

    /***************************************************************/
    bool updateModule()
    {
        LockGuard lg(mutex);

        if (Time::now()-t0>=dt)
        {
            if (blinking)
            {
                blink();
                if ((++doubleBlinkCnt)%5==0)
                {
                    blink();
                    doubleBlinkCnt=0;
                }
            }

            dt=Rand::scalar(min_dt,max_dt);
            t0=Time::now();
        }

        return true;
    }

    /***************************************************************/
    bool respond(const Bottle &command, Bottle &reply)
    {
        LockGuard lg(mutex);
        int ack=Vocab::encode("ack");
        int nack=Vocab::encode("nack");

        if (command.size()>0)
        {
            string cmd=command.get(0).asString().c_str();

            if (cmd == "start")
            {
                blinking=true;
                reply.addVocab(ack);
            }
            else if (cmd == "stop")
            {
                blinking=false;
                reply.addVocab(ack);
            }
            else if (cmd == "status")
            {
                reply.addVocab(ack);
                reply.addString(blinking?"on":"off");
                reply.addString(getInteractionMode());
            }
            else if (cmd == "blink")
            {
                reply.addVocab(blink()?ack:nack);
            }
            else if (cmd == "dblink")
            {
                bool res = blink() && blink();
                reply.addVocab(res?ack:nack);
            }
            else if (cmd == "save")
            {
                string fileName = save();

                if (fileName=="")
                {
                    reply.addVocab(nack);
                }
                else
                {
                    reply.addVocab(ack);
                    reply.addString(fileName.c_str());
                }
            }
            else if (cmd == "load")
            {
                string fileName = load();

                if (fileName=="")
                {
                    reply.addVocab(nack);
                }
                else
                {
                    reply.addVocab(ack);
                    reply.addString(fileName.c_str());
                }
            }
            else if (cmd == "set")
            {
                reply.addString(command.get(1).asString());

                if (command.get(1).asString() == "min_dt")
                {
                    setMinDT(command.get(2).asDouble());
                    reply.addDouble(getMinDT());
                    reply.addVocab(ack);
                }
                else if (command.get(1).asString() == "max_dt")
                {
                    setMaxDT(command.get(2).asDouble());
                    reply.addDouble(getMaxDT());
                    reply.addVocab(ack);
                }
                else if (command.get(1).asString() == "interaction_mode")
                {
                    if (command.get(2).asString() == "idle")
                    {
                        reply.addVocab(setInteractionMode_IDLE()?ack:nack);
                    }
                    else if (command.get(2).asString() == "conversation")
                    {
                        reply.addVocab(setInteractionMode_CONVERSATION()?ack:nack);
                    }
                }
            }
            else if (cmd == "get")
            {
                if (command.get(1).asString() == "min_dt")
                {
                    reply.addDouble(getMinDT());
                    reply.addVocab(ack);
                }
                else if (command.get(1).asString() == "max_dt")
                {
                    reply.addDouble(getMaxDT());
                    reply.addVocab(ack);
                }
                else if (command.get(1).asString() == "interaction_mode")
                {
                    reply.addString(getInteractionMode());
                    reply.addVocab(ack);
                }
            }
            else if (cmd == "calib")
            {

            }
            else
            {
                return RFModule::respond(command,reply);
            }
            return true;
        }

        reply.addVocab(nack);
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
        yInfo("  --min_dt     double: the default minimum delta T between consecutive blinks. Default  3.0[s].");
        yInfo("  --max_dt     double: the default maximum delta T between consecutive blinks. Default 10.0[s].");
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



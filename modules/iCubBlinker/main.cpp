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
#include <iomanip>
#include <string>

#include <yarp/os/all.h>
#include <yarp/math/Rand.h>

using namespace std;
using namespace yarp::os;
using namespace yarp::math;

enum InteractionMode { 
    INTERACTION_MODE_UNKNOWN=0, 
    INTERACTION_MODE_IDLE, INTERACTION_MODE_CONVERSATION
};

/***************************************************************/
class Blinker: public RFModule
{
private:    
    Port emotionsPort;
    RpcServer rpcPort;

    Mutex mutex;
    bool blinking;
    double min_dt,max_dt,dt,t0;
    int doubleBlinkCnt;

    InteractionMode int_mode;

    /***************************************************************/
    bool blink()
    {
        if (emotionsPort.getOutputCount()>0)
        {
            // close eyelids
            Bottle cmd;
            cmd.addString("S00");
            emotionsPort.write(cmd);

            Time::delay(0.05);

            // open eyelids
            cmd.clear();
            cmd.addString("S5A");
            emotionsPort.write(cmd);

            Time::delay(0.05);

            return true;
        }
        else
            return false;
    }

public:
    /***************************************************************/
    bool configure(ResourceFinder &rf)
    {
        string name=rf.check("name",Value("iCubBlinker")).asString().c_str();
        min_dt=rf.check("min_dt",Value(3.0)).asDouble();
        max_dt=rf.check("max_dt",Value(10.0)).asDouble();
        blinking=rf.check("autoStart");
        string robot=rf.check("robot",Value("icub")).asString().c_str();

        emotionsPort.open(("/"+name+"/emotions/raw").c_str());
        Network::connect(emotionsPort.getName().c_str(),"/"+robot+"/face/raw/in");

        rpcPort.open(("/"+name+"/rpc").c_str());
        attach(rpcPort);

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
    Network yarp;
    if (!yarp.checkNetwork())
    {
        yError("YARP server not available!");
        return -1;
    }

    ResourceFinder rf;
    rf.configure(argc,argv);

    Blinker blinker;
    return blinker.runModule(rf);
}



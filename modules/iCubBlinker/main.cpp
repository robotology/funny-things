/* 
 * Copyright (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
 * Author: Ugo Pattacini
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

        emotionsPort.open(("/"+name+"/emotions/raw").c_str());
        Network::connect(emotionsPort.getName().c_str(),"/icub/face/raw/in");

        rpcPort.open(("/"+name+"/rpc").c_str());
        attach(rpcPort);

        Rand::init();
        doubleBlinkCnt=0;
        dt=Rand::scalar(min_dt,max_dt);
        t0=Time::now();

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

        string cmd=command.get(0).asString().c_str();
        if (cmd=="start")
        {
            blinking=true;
            reply.addVocab(ack);
        }
        else if (cmd=="stop")
        {
            blinking=false;
            reply.addVocab(ack);
        }
        else if (cmd=="get")
        {
            reply.addVocab(ack);
            reply.addString(blinking?"on":"off");
        }
        else if (cmd=="blink")
            reply.addVocab(blink()?ack:nack);
        else
            return RFModule::respond(command,reply);

        return true; 
    }
};


/***************************************************************/
int main(int argc, char *argv[])
{
    Network yarp;
    if (!yarp.checkNetwork())
    {
        cout<<"YARP server not available!"<<endl;
        return -1;
    }

    ResourceFinder rf;
    rf.configure(argc,argv);

    Blinker blinker;
    return blinker.runModule(rf);
}



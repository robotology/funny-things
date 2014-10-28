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
    Mutex mutex;
    RpcServer rpc;
    bool blinking;

public:
    /***************************************************************/
    bool configure(ResourceFinder &rf)
    {
        string name=rf.check("name",Value("blinker")).asString().c_str();
        blinking=rf.check("auto-start");

        rpc.open(("/"+name+"/rpc").c_str());
        attach(rpc);

        Rand::init();

        return true;
    }

    /***************************************************************/
    bool close()
    {
        rpc.close();
        return true;
    }

    /***************************************************************/
    double getPeriod()
    {
        return 1.0;
    }

    /***************************************************************/
    bool updateModule()
    {
        LockGuard lg(mutex);
        return true;
    }

    /***************************************************************/
    bool respond(const Bottle &command, Bottle &reply)
    {
        LockGuard lg(mutex);
        int ack=Vocab::encode("ack");

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



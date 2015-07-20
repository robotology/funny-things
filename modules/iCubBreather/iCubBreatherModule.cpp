/* 
 * Copyright (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
 * Author: Alessandro Roncone & Ugo Pattacini
 * email:  alessandro.roncone@iit.it
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
\defgroup icub_iCubBreather iCubBreather
A module for implementing the IMU IDENTIFIER on the iCub.

Date first release: 07/07/2014

CopyPolicy: Released under the terms of the GNU GPL v2.0.

\section intro_sec Description
This is a module for implementing the IMU IDENTIFIER on the iCub.
It uses a set of waypoints in order to move the iCub head to a specified position with a specified velocity.
In the meanwhile, it reads both references at the PID level, and the gyro output from the inertial, sending them out 
through the IMU:o port for later log and use.

\section lib_sec Libraries 
YARP

\section parameters_sec Parameters

--context    \e path
- Where to find the called resource.

--from       \e from
- The name of the .ini file with the configuration parameters.

--name       \e name
- The name of the module (default iCubBreather).

--robot      \e rob
- The name of the robot (either "icub" or "icub"). Default "icub".
  If you are guessing: Yes, the test HAS to be performed on the real robot!

--rate       \e rate
- The period used by the thread. Default 100ms.

--verbosity  \e verb
- Verbosity level (default 1). The higher is the verbosity, the more
  information is printed out.

\section portsc_sec Ports Created
- <i> /<name>/inertial:i </i> it reads values from the inertial sensor

- <i> /<name>/IMU:o </i> it prints out useful data in order to track both the pid controllers and the inertial sensor

\section in_files_sec Input Data Files
- <i> <name>.ini </i> it is a (mandatory) file from which the module can retrieve the waypoints used in the experiment.

\section out_data_sec Output Data Files
 
\section tested_os_sec Tested OS
Linux (Ubuntu 14.04, Debian Wheezy).

\author Alessandro Roncone
*/ 

#include <yarp/os/RFModule.h>
#include <yarp/os/Network.h>
#include <yarp/os/RateThread.h>
#include <yarp/os/RpcClient.h>

#include <yarp/sig/Vector.h>
#include <yarp/sig/Matrix.h>

#include <yarp/math/Math.h>

#include <iostream>
#include <string.h> 

#include "iCubBreatherThread.h"

using namespace yarp;
using namespace yarp::os;
using namespace yarp::sig;
using namespace yarp::math;

using namespace std;

/**
* \ingroup iCubBreatherModule
*
* The module that achieves the iCubBreather task.
*  
*/
class iCubBreather: public RFModule
{
    private:
        iCubBreatherThread *iCubBreatherThrd;
        RpcServer           rpcSrvr;

    public:
        iCubBreather()
        {
            iCubBreatherThrd=0;
        }

        bool respond(const Bottle &command, Bottle &reply)
        {
            int ack =Vocab::encode("ack");
            int nack=Vocab::encode("nack");

            if (command.size()>0)
            {
                switch (command.get(0).asVocab())
                {
                    case VOCAB4('s','t','a','r'):
                    {
                        int res=Vocab::encode("started");
                        if (iCubBreatherThrd -> startBreathing())
                        {
                            reply.addVocab(ack);
                        }
                        else
                            reply.addVocab(nack);
                        
                        reply.addVocab(res);
                        return true;
                    }
                    case VOCAB4('s','t','o','p'):
                    {
                        int res=Vocab::encode("stopped");
                        if (iCubBreatherThrd -> stopBreathing())
                        {
                            reply.addVocab(ack);
                        }
                        else
                            reply.addVocab(nack);
                        
                        reply.addVocab(res);
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

        bool configure(ResourceFinder &rf)
        {
            string name         = "iCubBreather";
            string robot        = "icub";
            string part         = "left_arm";
            int    verbosity    =      0;    // verbosity
            int    rate         =   2000;    // rate of the iCubBreatherThread
            int    numWaypoints =      1;
            bool   autoStart    =  false;
            double noiseStd     =    0.5;
            double refSpeeds    =   10.0;

            //******************* NAME ******************
                if (rf.check("name"))
                {
                    name = rf.find("name").asString();
                    yInfo("*** Module name set to %s",name.c_str());  
                }
                else yInfo("*** Module name set to default, i.e. %s",name.c_str());
                setName(name.c_str());

            //****************** rate ******************
                if (rf.check("rate"))
                {
                    rate = rf.find("rate").asInt();
                    yInfo(("*** "+name+": thread working at %i ms").c_str(), rate);
                }
                else yInfo(("*** "+name+": could not find rate in the config file; using %i ms as default").c_str(), rate);

            //******************* VERBOSE ******************
                if (rf.check("verbosity"))
                {
                    verbosity = rf.find("verbosity").asInt();
                    yInfo(("*** "+name+": verbosity set to %i").c_str(),verbosity);
                }
                else yInfo(("*** "+name+": could not find verbosity option in the config file; using %i as default").c_str(),verbosity);

            //******************* NOISESTD ******************
                if (rf.check("noiseStd"))
                {
                    noiseStd = rf.find("noiseStd").asDouble();
                    yInfo(("*** "+name+": noiseStd set to %g").c_str(),noiseStd);
                }
                else yInfo(("*** "+name+": could not find noiseStd option in the config file; using %g as default").c_str(),noiseStd);

            //******************* REFPEEDS ******************
                if (rf.check("refSpeeds"))
                {
                    refSpeeds = rf.find("refSpeeds").asDouble();
                    yInfo(("*** "+name+": refSpeeds set to %g").c_str(),refSpeeds);
                }
                else yInfo(("*** "+name+": could not find refSpeeds option in the config file; using %g as default").c_str(),refSpeeds);

            //******************* ROBOT ******************
                if (rf.check("robot"))
                {
                    robot = rf.find("robot").asString();
                    yInfo(("*** "+name+": robot is %s").c_str(),robot.c_str());
                }
                else yInfo(("*** "+name+": could not find robot option in the config file; using %s as default").c_str(),robot.c_str());

            //******************* PART *******************
                if (rf.check("part"))
                {
                    part = rf.find("part").asString();
                    yInfo(("*** "+name+": part is %s").c_str(),part.c_str());
                }
                else yInfo(("*** "+name+": could not find part option in the config file; using %s as default").c_str(),part.c_str());

            //************* AUTOSTART *******************
                if (rf.check("autoStart"))
                {
                    autoStart = true;
                }

            //****************** THREAD ******************
                iCubBreatherThrd = new iCubBreatherThread(rate, name, robot, part, autoStart,
                                                          noiseStd, refSpeeds, verbosity, rf);

                iCubBreatherThrd -> start();
                bool strt = 1;
                if (!strt)
                {
                    delete iCubBreatherThrd;
                    iCubBreatherThrd = 0;
                    yError(" iCubBreatherThread wasn't instantiated!!");
                    return false;
                }
                yInfo("ICUB BREATHER: iCubBreatherThread istantiated..");

            //************************ RPC ***********************
                rpcSrvr.open(("/"+name+"/rpc:i").c_str());
                attach(rpcSrvr);

            return true;
        }

        bool close()
        {
            yInfo("ICUB BREATHER: Stopping threads..");
            if (iCubBreatherThrd)
            {
                iCubBreatherThrd->stop();
                delete iCubBreatherThrd;
                iCubBreatherThrd=0;
            }

            return true;
        }

        double getPeriod()  { return 1.0; }
        bool updateModule() { return true; }
};

/**
* Main function.
*/
int main(int argc, char * argv[])
{
    ResourceFinder rf;
    rf.setVerbose(false);
    rf.setDefaultContext("funny-things");
    rf.setDefaultConfigFile("iCubBreather.ini");
    rf.configure(argc,argv);

    if (rf.check("help"))
    {    
        cout << endl << "IMU IDENTIFIER module" << endl;
        cout << endl << "Options:" << endl;
        cout << "   --context      path:   where to find the called resource. Default gazeStabilization." << endl;
        cout << "   --from         from:   the name of the .ini file. Default iCubBreather.ini." << endl;
        cout << "   --name         name:   the name of the module. Default iCubBreather." << endl;
        cout << "   --robot        robot:  the name of the robot. Default icub." << endl;
        cout << "   --rate         rate:   the period used by the thread. Default 500ms." << endl;
        cout << "   --noiseStd     double: standard deviation of the noise. Default 1.0." << endl;
        cout << "   --refSpeeds    double: The reference speeds at the joints. Default 5.0." << endl;
        cout << "   --verbosity    int:    verbosity level. Default 0." << endl;
        cout << "   --autoStart    flag:   if to autostart the module or not. Default no." << endl;
        cout << endl;
        return 0;
    }

    Network yarp;
    if (!yarp.checkNetwork())
    {
        yInfo("No Network!!!\n");
        return 1;
    }

    iCubBreather icubBrthr;
    return icubBrthr.runModule(rf);
}
// empty line to make gcc happy

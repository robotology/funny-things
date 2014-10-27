/* 
 * Copyright (C) 2010 RobotCub Consortium, European Commission FP6 Project IST-004370
 * Author: Alessandro Roncone
 * email:  alessandro.roncone@iit.it
 * website: www.robotcub.org
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
 * This thread detects a touched taxel on the skin (through readings from the
 * skinContactList port), and it moves the "controlateral" limb toward
 * the affected taxel.
*/

#include <yarp/os/all.h>

#include <yarp/sig/Vector.h>

#include <yarp/dev/PolyDriver.h>
#include <yarp/dev/Drivers.h>
#include <yarp/dev/all.h>

#include <yarp/math/Rand.h> 

#include <iostream>
#include <string>
#include <stdarg.h>
#include <sstream>
#include <vector>

using namespace yarp::os;
using namespace yarp::sig;
using namespace yarp::dev;

using namespace std;

class iCubBreatherThread: public RateThread
{
protected:
    /***************************************************************************/
    // EXTERNAL VARIABLES: change them from command line or through .ini file
    int verbosity;      // Flag that manages verbosity
    string name;        // Name of the module (to change port names accordingly)  
    string robot;       // Name of the robot (to address both icub and icubSim)
    string part;        // Arm to control (either "right_arm" or "left_arm")
    std::vector <double> noiseStDvtns;
    yarp::os::Bottle noiseStdBottle;
    double refSpeeds;
    double noiseStd;

    // Classical interfaces
    PolyDriver          dd;   // head device driver
    IPositionControl2  *ipos;
    IEncoders          *iencs;
    IControlMode2      *imod;
    Vector             *encs;
    Vector              encs_0;
    int                 jnts;

    bool isRunning;
    bool onStart;

    /**
     * Changes the control modes of the torso to either position or velocity
     * @param  _s mode to set. It can be either "position" or "velocity"
     * @return    true/false if success/failure
     */
    bool setCtrlModes(const string &_s);

    /**
     * Check the state of each joint to be controlled
     * @param  jointsToSet vector of integers that defines the joints to be set
     * @param  _s mode to set. It can be either "position" or "velocity"
     * @return             true/false if success/failure
     */
    bool areJointsHealthyAndSet(VectorOf<int> &jointsToSet,const string &_s);

    /**
     * goes into home configuration (i.e. 0 0 0)
     * @return    true/false if success/failure
     */
    bool goHome();

    bool goToTarget(const Vector &nT);

    Vector computeNewTarget();

    /**
    * Prints a message according to the verbosity level:
    * @param l is the level of verbosity: if level > verbosity, something is printed
    * @param f is the text. Please use c standard (like printf)
    */
    int printMessage(const int l, const char *f, ...) const;

public:
    // CONSTRUCTOR
    iCubBreatherThread(int _rate, string _name, string _robot,
                       string _part, bool _autoStart, double _noiseStd, double _refSpeeds, int _v, const ResourceFinder &_rf);
    // INIT
    virtual bool threadInit();
    // RUN
    virtual void run();
    // RELEASE
    virtual void threadRelease();
    // RESTART THE CYCLE
    bool startBreathing();
    bool stopBreathing();
};

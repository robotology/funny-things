#include "iCubBreatherThread.h"

iCubBreatherThread::iCubBreatherThread(int _rate, string _name, string _robot, string _part, bool _autoStart,
                                       double _noiseStd, double _refSpeed, int _v, const ResourceFinder &_rf) :
                                       RateThread(_rate), name(_name), robot(_robot),
                                       verbosity(_v), part(_part), noiseStd(_noiseStd), refSpeed(_refSpeed)
{
    if (_autoStart)
        isRunning = true;
    else
        isRunning = false;
    onStart   = true;

    ResourceFinder &rf = const_cast<ResourceFinder&>(_rf);
    groupPartBottle = rf.findGroup(part.c_str());
}

bool iCubBreatherThread::threadInit()
{
    bool ok = 1;
    Property Opt;
    Opt.put("robot",  robot.c_str());
    Opt.put("part",   robot.c_str());
    Opt.put("device", "remote_controlboard");
    Opt.put("remote",("/"+robot+"/"+part).c_str());
    Opt.put("local", ("/"+name +"/"+part).c_str());

    if (!dd.open(Opt))
    {
        printMessage(0,"ERROR: could not open %s PolyDriver!\n",part.c_str());
        return false;
    }

    if (dd.isValid())
    {
        ok = ok && dd.view(ipos);
        ok = ok && dd.view(iencs);
        ok = ok && dd.view(imod);
    }

    if (!ok)
    {
        printMessage(0,"\nERROR: Problems acquiring %s interfaces!!!!\n",part.c_str());
        return false;
    }

    iencs -> getAxes(&jnts);
    encs_0.resize(jnts,0.0);

    // Find the standard deviations and the ref speeds
    if (!groupPartBottle.isNull())
    {
        Bottle *bns = groupPartBottle.find("noiseStds").asList();
        Bottle *brf = groupPartBottle.find("refSpeeds").asList();

        for (int i = 0; i < jnts; i++)
        {
            noiseStDvtns.push_back(bns->get(i).asDouble());
            refSpeeds.push_back(brf->get(i).asDouble());
        }
    }
    else
    {
        for (int i = 0; i < jnts; i++)
        {
            noiseStDvtns.push_back(noiseStd);
            refSpeeds.push_back(refSpeed);
        }
    }

    if (verbosity >= 1)
    {
        printMessage(1,"Noise std deviations: ");
        for (int i = 0; i < noiseStDvtns.size(); i++)
        {
            printf("%g\t",noiseStDvtns[i]);
        }
        printf("\n");

        printMessage(1,"Ref speeds          : ");
        for (int i = 0; i < refSpeeds.size(); i++)
        {
            printf("%g\t",refSpeeds[i]);
        }
        printf("\n");
    }

 

    // Set the ref speeds
    Vector tmp(jnts,0.0);
    for (int i = 0; i < jnts; i++)
    {
        tmp[i] = refSpeeds[i];
    }
    ipos->setRefSpeeds(tmp.data());

    yarp::math::Rand::init();
    // yarp::os::Random::seed(int(yarp::os::Time::now()));

    return true;
}

void iCubBreatherThread::run()
{
    if (onStart)
    {
        // This is there only for avoiding some printing issues. Remove it if you want
        Time::delay(0.1);

        if (!iencs->getEncoders(encs_0.data()))
        {
            printMessage(0,"ERROR: Error reading encoders, check connectivity with the robot!\n");
        }
        else
        {
            printMessage(0,"Home position %s\n",encs_0.toString(3,3).c_str());
            onStart = false;
        }
    }

    LockGuard lg(mutex);
    if (isRunning)
    {
        Vector newTarget = computeNewTarget();
        printMessage(0,"New target: %s\n",newTarget.toString(3,3).c_str());
        goToTarget(newTarget);
    }
}

Vector iCubBreatherThread::computeNewTarget()
{
    // Let's put the simplest stuff and make it complex afterwards
    Vector noise(jnts,0.0);
    for (int i = 0; i < jnts; i++)
    {
        noise[i] = yarp::os::Random::normal(0,noiseStDvtns[i]);
    }

    Vector result(jnts,0.0);

    for (int i = 0; i < jnts; i++)
    {
        result[i] = encs_0[i] + noise[i];
    }
    
    return result;
}

bool iCubBreatherThread::goToTarget(const Vector &nT)
{
    VectorOf<int> jointsToSet;
    if (!areJointsHealthyAndSet(jointsToSet,"position"))
    {
        stopBreathing();
        printMessage(0,"ERROR: joints are not healthy!");
        return false;
    }
    else
    {
        if (setCtrlModes("position"))
        {
            return ipos -> positionMove(nT.data());
        }
        else
        {
            printMessage(0,"ERROR: setCtrlModes returned false!\n");
            return false;
        }
    }
    return true;
}

bool iCubBreatherThread::areJointsHealthyAndSet(VectorOf<int> &jointsToSet,const string &_s)
{
    VectorOf<int> modes(jnts);
    imod->getControlModes(modes.getFirst());

    for (size_t i=0; i<modes.size(); i++)
    {
        if ((modes[i]==VOCAB_CM_HW_FAULT) || (modes[i]==VOCAB_CM_IDLE))
            return false;

        if (_s=="velocity")
        {
            if (modes[i]!=VOCAB_CM_MIXED || modes[i]!=VOCAB_CM_VELOCITY)
                jointsToSet.push_back(i);
        }
        else if (_s=="position")
        {
            if (modes[i]!=VOCAB_CM_MIXED || modes[i]!=VOCAB_CM_POSITION)
                jointsToSet.push_back(i);
        }

    }

    return true;
}

bool iCubBreatherThread::setCtrlModes(const string &_s)
{
    printMessage(1,"Setting %s mode for %s joints..\n",_s.c_str(),part.c_str());

    if (_s!="position" && _s!="velocity")
        return false;

    VectorOf<int> modes;

    if (_s=="position")
    {
        for (size_t i = 0; i < jnts; i++)
        {
            modes.push_back(VOCAB_CM_POSITION);
        }
    }
    else if (_s=="velocity")
    {
        for (size_t i = 0; i < jnts; i++)
        {
            modes.push_back(VOCAB_CM_VELOCITY);
        }
    }

    imod -> setControlModes(modes.getFirst());

    Time::delay(0.1);

    return true;
}

bool iCubBreatherThread::goHome()
{
    return goToTarget(encs_0);
}


bool iCubBreatherThread::startBreathing()
{
    LockGuard lg(mutex);
    onStart = true;
    isRunning = true;
    return true;
}

bool iCubBreatherThread::stopBreathing()
{
    LockGuard lg(mutex);
    isRunning = false;
    return true;
}

int iCubBreatherThread::printMessage(const int l, const char *f, ...) const
{
    if (verbosity>=l)
    {
        fprintf(stdout,"*** %s: ",name.c_str());

        va_list ap;
        va_start(ap,f);
        int ret=vfprintf(stdout,f,ap);
        va_end(ap);

        return ret;
    }
    else
        return -1;
}

void iCubBreatherThread::threadRelease()
{
    printMessage(0,"Putting %s in home position..\n",part.c_str());
        goHome();

    printMessage(0,"Closing controllers..\n");
        dd.close();
}

// empty line to make gcc happy

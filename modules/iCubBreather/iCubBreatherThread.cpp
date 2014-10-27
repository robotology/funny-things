#include "iCubBreatherThread.h"

iCubBreatherThread::iCubBreatherThread(int _rate, string _name, string _robot, string _part, int _v) :
                                           RateThread(_rate), name(_name), robot(_robot),
                                           verbosity(_v), part(_part)
{
    isRunning = false;
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
        printMessage(0,"ERROR: could not open head PolyDriver!\n");
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
    encs   = new Vector(jnts,0.0);
    encs_0 = new Vector(jnts,0.0);

    return true;
}

void iCubBreatherThread::run()
{
    if (isRunning)
    {
        /* code */
    }
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
    setCtrlModes("position");
    ipos -> positionMove((*encs_0).data());

    return true;
}


bool iCubBreatherThread::startBreathing()
{
    isRunning = true;
    return true;
}

bool iCubBreatherThread::stopBreathing()
{
    isRunning = false;
    return true;
}

int iCubBreatherThread::printMessage(const int l, const char *f, ...) const
{
    if (verbosity>=l)
    {
        fprintf(stdout,"*** %s:  ",name.c_str());

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
        delete encs;
        delete encs_0;
        encs   = 0;
        encs_0 = 0;
}

// empty line to make gcc happy

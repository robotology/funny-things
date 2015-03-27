#include "mainwindow.h"
#include <QApplication>

using namespace yarp::os;

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    yarp::os::Network yarp;
    ResourceFinder rf;

    rf.setVerbose( true );
    rf.setDefaultConfigFile( "config.ini" );        //overridden by --from parameter
    rf.setDefaultContext( "iCubBarMenu" );        //overridden by --context parameter
    rf.configure( argc, argv );

    MainWindow w(rf);
    w.show();

    return a.exec();
}

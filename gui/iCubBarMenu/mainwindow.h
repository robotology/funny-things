#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <yarp/os/Network.h>
#include <yarp/os/ResourceFinder.h>
#include <yarp/os/Bottle.h>
#include <yarp/os/Module.h>
#include <yarp/os/Value.h>
#include <yarp/os/BufferedPort.h>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow, public yarp::os::ResourceFinder, public yarp::os::Module
{
    Q_OBJECT

public:
    explicit MainWindow(yarp::os::ResourceFinder &rf, QWidget *parent = 0);
    ~MainWindow();

private:
    Ui::MainWindow                                  *ui;
    QString                                         moduleName;
    yarp::os::BufferedPort<yarp::os::Bottle>        outPort;

private slots:
    void onMakeButton();
    void onStopButton();
};

#endif // MAINWINDOW_H

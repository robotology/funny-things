#include "mainwindow.h"
#include "ui_mainwindow.h"

using namespace yarp::os;

MainWindow::MainWindow(ResourceFinder &rf, QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QPixmap pix("/usr/local/src/robot/icub-contrib-iit/funny-things/gui/iCubBarMenu/data/image.png");
    ui->labelImg->setPixmap(pix);

    moduleName =  QString("%1").arg(rf.check("name", Value("iCubBarMenu"), "module name (string)").asString().c_str());

    QString port = QString("/%1/events:o").arg(moduleName);
    outPort.open( port.toLatin1().data() );

    connect(ui->makeButton,SIGNAL(clicked()),this,SLOT(onMakeButton()));
    connect(ui->stopButton,SIGNAL(clicked()),this,SLOT(onStopButton()));
}

void MainWindow::onMakeButton()
{
    QString texts;
    texts = ui->listWidget->currentItem()->text();
    //texts.append(item->text());

    fprintf(stdout, "Make make make\n");
    Bottle& output = outPort.prepare();

    std::string tmp = texts.toLatin1().data();

    output.clear();
    output.addString("make");
    output.addString(tmp.c_str());
    fprintf(stdout, "writing %s \n", output.toString().c_str());
    outPort.write();
}

void MainWindow::onStopButton()
{
    Bottle& output = outPort.prepare();
    output.clear();
    output.addString("stop");
    //output.addString(texts.toLatin1().data());
    fprintf(stdout, "writing %s \n", output.toString().c_str());
    outPort.write();
}

MainWindow::~MainWindow()
{
    fprintf(stdout, "Start cleaning up\n");
    outPort.interrupt();
    outPort.close();
    fprintf(stdout, "Done cleaning up\n");
    delete ui;
}

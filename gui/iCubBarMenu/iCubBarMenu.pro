#-------------------------------------------------
#
# Project created by QtCreator 2015-03-26T14:24:46
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = iCubBarMenu
TEMPLATE = app

INCLUDEPATH += /usr/local/src/robot/yarp/src/libYARP_OS/include/
INCLUDEPATH += /usr/local/src/robot/yarp/build-x86_64/generated_include/
#INCLUDEPATH += </Users/vtikha/Dev/Libs/yarp/src/libYARP_dev/include>
#INCLUDEPATH += </Users/vtikha/Dev/Libs/yarp/src/libYARP_sig/include>
#INCLUDEPATH += </Users/vtikha/Dev/Libs/yarp/src/libYARP_math/include>

LIBS += -L/usr/local/src/robot/yarp/build-x86_64/lib -lYARP_OS -lYARP_dev -lYARP_init -lYARP_sig

SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

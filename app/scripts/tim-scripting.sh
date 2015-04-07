#!/bin/bash

################################################################################
# FUNCTIONS:                                                                   #
################################################################################
init() {
    echo "set track 1" | yarp rpc /iKinGazeCtrl/rpc
}

fini() {
    echo "set track 0" | yarp rpc /iKinGazeCtrl/rpc
}

speak() {
    echo "\"$1\"" | yarp write ... /iSpeak_ita
}

blink() {
    echo "blink" | yarp rpc /iCubBlinker/rpc
    sleep 0.5
}

look_at() {
    echo "$1 $2 $3" | yarp write ... /iKinGazeCtrl/xd:i
}

take_pen() {
    echo "ctpq time 3.0 off 7 pos (27.0 47.0 22.0 123.0 66.0 100.0 35.0 90.0 240.0)" | yarp rpc /ctpservice/right_arm/rpc  
}

home() {
    look_at -0.5 0.0 0.34
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.0 off 0 pos (0.0 34.0 4.0 69.0 9.0 0.0 -1.0 54.0 30.0 9.0 49.0 33.0 49.0 30.0 26.0 73.0)" | yarp rpc /ctpservice/left_arm/rpc  
    echo "ctpq time 1.0 off 0 pos (-6.0 42.0 17.0 83.0 -10.0 0.0 26.0 27.0 47.0 22.0 123.0 66.0 100.0 35.0 90.0 240.0)" | yarp rpc /ctpservice/right_arm/rpc  
    sleep 2.0
}

retract_left() {
    echo "ctpq time 0.8 off 0 pos (2.0 45.0 20.0 104.0 -3.0 0.0 -1.0 54.0 30.0 9.0 49.0 33.0 49.0 30.0 26.0 73.0)" | yarp rpc /ctpservice/left_arm/rpc  
}

draw_roof() {
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    look_at -0.25 0.0 -0.05
    echo "-0.33 0.0 0.0 0.264198 0.779568 -0.567867 2.351021" | yarp write ... /armCtrl/right_arm/xd:i
    sleep 2.0
    echo "-0.33 0.0 -0.05 0.264198 0.779568 -0.567867 2.351021" | yarp write ... /armCtrl/right_arm/xd:i
    sleep 2.0
    look_at -0.35 0.1 -0.05
    echo "-0.43 0.1 -0.05 0.264198 0.779568 -0.567867 2.351021" | yarp write ... /armCtrl/right_arm/xd:i
    sleep 2.0
    look_at -0.25 0.2 -0.05
    echo "-0.33 0.2 -0.05 0.264198 0.779568 -0.567867 2.351021" | yarp write ... /armCtrl/right_arm/xd:i
    sleep 2.0
    echo "-0.33 0.2 0.0 0.264198 0.779568 -0.567867 2.351021" | yarp write ... /armCtrl/right_arm/xd:i
    sleep 2.5
}

point() {
    look_at -0.5 0.0 0.34
    echo "set mou hap" | yarp rpc /icub/face/emotions/in
    sleep 1.0
    look_at -0.5 0.14 -0.05
    sleep 1.0
    echo "ctpq time 1.0 off 0 pos (12.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.0 off 0 pos (-6.0 22.0 33.0 66.0 75.0 0.0 6.0 54.0 30.0 46.0 100.0 0.0 0.0 60.0 130.0 220.0)" | yarp rpc /ctpservice/left_arm/rpc  
    sleep 2.0
    look_at -0.5 0.0 0.34
    sleep 2.0
}

run_all() {
    init
    home
    retract_left
    draw_roof
    home
    point
    home
    fini
}

################################################################################
# "MAIN" FUNCTION:                                                             #
################################################################################
if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    exit 1
fi

$1 $2 $3 $4

exit 0

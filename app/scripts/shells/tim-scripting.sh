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
    look_at -0.9 0.0 0.34
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.5 off 0 pos (0.0 34.0 4.0 69.0 9.0 0.0 -1.0 54.0 30.0 9.0 49.0 33.0 49.0 30.0 26.0 73.0)" | yarp rpc /ctpservice/left_arm/rpc  
    echo "ctpq time 1.5 off 0 pos (-6.0 42.0 17.0 83.0 -10.0 0.0 26.0 27.0 47.0 22.0 123.0 66.0 100.0 35.0 90.0 240.0)" | yarp rpc /ctpservice/right_arm/rpc  
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
    echo "-0.33 0.0 -0.1 0.264198 0.779568 -0.567867 2.351021" | yarp write ... /armCtrl/right_arm/xd:i
    sleep 1.8
    echo "-0.38 0.05 -0.11 0.264198 0.779568 -0.567867 2.351021" | yarp write ... /armCtrl/right_arm/xd:i
    sleep 1.0
    look_at -0.35 0.1 -0.1
    echo "-0.43 0.1 -0.09 0.264198 0.779568 -0.567867 2.351021" | yarp write ... /armCtrl/right_arm/xd:i
    sleep 2.0
    look_at -0.25 0.2 -0.07
    echo "-0.345 0.17 -0.09 0.264198 0.779568 -0.567867 2.351021" | yarp write ... /armCtrl/right_arm/xd:i
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

look_you_old() {
    echo "set track 0" | yarp rpc /iKinGazeCtrl/rpc
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    echo "set reb neu" | yarp rpc /icub/face/emotions/in
    echo "set leb neu" | yarp rpc /icub/face/emotions/in
    echo "ctpq time 0.2 off 7 pos (38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc  
    echo "ctpq time 1.5 off 0 pos (-46.0 16.0 25.0 100.0 -44.0 0.0 0.0 38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc  
    sleep 1.5
    echo "ctpq time 0.7 off 0 pos (-13.0 -1.0 0.0 19.0 0.0 9.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.5
    echo "set track 1" | yarp rpc /iKinGazeCtrl/rpc
    echo "set all ang" | yarp rpc /icub/face/emotions/in
    echo "ctpq time 1.0 off 0 pos (-77.0 16.0 10.0 47.0 82.0 -23.0 7.0 38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc  
    sleep 3.0
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}

look_you() {
    echo "ctpq time 1.2 off 0 pos (-50.0 0.0 18.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 1.4
    #echo "set track 0" | yarp rpc /iKinGazeCtrl/rpc
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    echo "set reb neu" | yarp rpc /icub/face/emotions/in
    echo "set leb neu" | yarp rpc /icub/face/emotions/in
    echo "ctpq time 0.2 off 7 pos (38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc  
    echo "ctpq time 1.0 off 0 pos (-24.0 24.0 -9.0 106.0 -43.0 16.0 -10.0 38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc  
    sleep 1.0
    look_at -0.15 -0.7 0.12
    sleep 0.5
    #echo "set track 1" | yarp rpc /iKinGazeCtrl/rpc
    echo "set all ang" | yarp rpc /icub/face/emotions/in
    echo "ctpq time 1.0 off 0 pos (-61.0 37.0 -16.0 52.0 87.0 -28.0 11.0 38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc  
    sleep 1.5
    echo "set all hap" | yarp rpc /icub/face/emotions/in
    sleep 1.0
    echo "ctpq time 1.5 off 0 pos (0.0 34.0 4.0 69.0 9.0 0.0 -1.0 54.0 30.0 9.0 49.0 33.0 49.0 30.0 26.0 73.0)" | yarp rpc /ctpservice/left_arm/rpc  
    sleep 1.6
}

home_seated_left() {
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    echo "ctpq time 1.0 off 0 pos (-9.0 0.0 -36.0 3.0 -1.0 12.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1.5 off 0 pos (-37.0 28.0 33.0 51.0 1.0 5.0 25.0 30.0 29.0 8.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0  
}

greet_left_thumb_up() {
    echo "ctpq time 1.0 off 0 pos (-75.0 17.0 19.0 45.0 7.0 17.0 22.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 300.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "set all hap" | yarp rpc /icub/face/emotions/in
    sleep 3.0
}

greet_seated_left() {
    #echo "ctpq time 1.0 off 0 pos (11.0 0.0 11.0 15.0 -1.0 8.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1.3 off 0 pos (-65.0 51.0 -3.0 99.0 37.0 9.0 11.0 30.0 29.0 8.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-65.0 51.0 -2.0 71.0 32.0 -12.0 -8.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-65.0 51.0 -2.0 105.0 36.0 5.0 8.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-65.0 51.0 -2.0 71.0 32.0 -12.0 -8.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-65.0 51.0 -2.0 105.0 36.0 5.0 8.0)" | yarp rpc /ctpservice/left_arm/rpc

    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 28.0 69.0 34.0 60.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 10.0 38.0 23.0 48.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 28.0 69.0 34.0 60.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 10.0 38.0 23.0 48.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 28.0 69.0 34.0 60.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 10.0 38.0 23.0 48.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 28.0 69.0 34.0 60.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 10.0 38.0 23.0 48.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 28.0 69.0 34.0 60.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 8 pos (44.0 11.0 52.0 10.0 38.0 23.0 48.0 185.0)" | yarp rpc /ctpservice/right_arm/rpc

    sleep 1.0
    #echo "ctpq time 1.0 off 0 pos (9.0 0.0 10.0 14.0 -1.0 8.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.0
    #echo "ctpq time 1.0 off 0 pos (12.0 0.0 11.0 16.0 -1.0 8.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.0
}

handshake_seated() {
    echo "ctpq time 1.0 off 0 pos (20.0 0.0 26.0 7.0 -1.0 8.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.0
    echo "ctpq time 1.3 off 0 pos (-71.0 62.0 2.0 87.0 -9.0 10.0 30.0 63.0 20.0 14.0 80.0 10.0 50.0 3.0 108.0 105.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5
    echo "ctpq time 1.0 off 0 pos (20.0 18.0 26.0 7.0 -1.0 8.0)" | yarp rpc /ctpservice/head/rpc
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}

camera_final() {
    echo "ctpq time 1.0 off 0 pos (20.0 18.0 26.0 11.0 -15.0 8.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.0
    echo "ctpq time 1.3 off 0 pos (-58.0 58.0 0.0 81.0 3.0 3.0 46.0 60.0 20.0 14.0 80.0 10.0 50.0 3.0 108.0 105.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}

camera_final2() {
    echo "ctpq time 1.0 off 0 pos (-3.0 18.0 26.0 4.0 -15.0 8.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.0
    echo "ctpq time 1.3 off 0 pos (-58.0 58.0 0.0 81.0 3.0 3.0 46.0 60.0 20.0 14.0 80.0 10.0 50.0 3.0 108.0 105.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}

lower_hand() {
    echo "ctpq time 2.0 off 0 pos (-37.0 28.0 33.0 51.0 1.0 5.0 25.0 30.0 29.0 8.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

look_camera() {
    echo "ctpq time 1.0 off 0 pos (-23.0 0.0 -35.0 -6.0 26.0 12.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.2
    echo "set leb sur" | yarp rpc /icub/face/emotions/in
    echo "set reb sur" | yarp rpc /icub/face/emotions/in
    echo "set mou hap" | yarp rpc /icub/face/emotions/in
}

greet() {
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.0
    speak "ciao a tutti"
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 0.5
}

home_pif() {
    look_at -0.5 0.0 0.34
    echo "ctpq time 1.5 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 50.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 3.0
}

handshake() {
    look_at -0.5 0.0 0.5
    echo "ctpq time 1.5 off 0 pos (-23.0 0.0 -10.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.5 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    speak "italia? 1"
    echo "ctpq time 0.4 off 0 pos (-44.0 26.0 17.0 54.0 -4.0 -39.0 25.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-44.0 26.0 17.0 54.0 -4.0 -39.0 25.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-44.0 26.0 17.0 54.0 -4.0 -39.0 25.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
}

head() {
    echo "$1" | yarp rpc /iCubBreatherH/rpc:i
}

interview_0() {
    echo "ctpq time 1.0 off 0 pos (-9.0 -7.0 -41.0 3.0 20.0 )" | yarp rpc /ctpservice/head/rpc
    sleep 1.4
    head "start"
}

interview_1() {
    echo "set all hap" | yarp rpc /icub/face/emotions/in
    speak "ciao, io sono aicab"
    greet_seated_left
    home_seated_left
}

interview_2() {
    echo "set mou hap" | yarp rpc /icub/face/emotions/in
    greet_left_thumb_up
    home_seated_left
}

interview_3() {
    echo "set leb sur" | yarp rpc /icub/face/emotions/in
    echo "set reb neu" | yarp rpc /icub/face/emotions/in
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    speak "da nessuna parte. ce l'hai dietro la schiena"
}

interview_4() {
    speak "no, pif, l'astronave"
    echo "set all hap" | yarp rpc /icub/face/emotions/in
    head "stop"
}

run_all() {
    init
    home
    retract_left
    draw_roof
    home
    point
    home
    look_you
    home
    fini
}

step_0() {
    retract_left
    draw_roof
    home
}

step_1() {
    init
    home
    retract_left
    draw_roof
    sleep 1.0
    look_at -0.15 -0.7 0.18
    sleep 1.3
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}

step_2() {
    echo "ctpq time 1.0 off 0 pos (-13.0 0.0 21.0)" | yarp rpc /ctpservice/torso/rpc
    look_at -0.15 -0.7 0.18
    sleep 1.3
}

step_3() {
    look_you
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

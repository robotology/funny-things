#!/bin/bash

################################################################################
# FUNCTIONS:                                                                   #
################################################################################
init() {
    echo "set track 1" | yarp rpc /iKinGazeCtrl/rpc
    home_gaze

    echo "ctpq time 1.5 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.5 off 0 pos (10.0 41.0 20.0 44.0 27.0 -36.0 -15.0 30.0 0.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-4.0 31.0 22.0 37.0 40.0 -31.0 -19.0 50.0 0.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
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

home_gaze() {
    look_at -0.5 0.0 0.34
}

reach_glass() {
    look_at -0.4 -0.3 -0.1
    echo "ctpq time 1.5 off 0 pos (4.0 48.0 5.0 79.0 -45.0 -20.0 -19.0 50.0 0.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 0.5
    echo "ctpq time 2.7 off 0 pos (-9.0 0.0 17.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.0 off 0 pos (10.0 50.0 15.0 63.0 -12.0 -36.0 -15.0 38.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.3 off 0 pos (-40.0 17.0 -18.0 33.0 18.0 0.0 -20.0 38.0 90.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-40.0 17.0 -18.0 33.0 18.0 0.0 -20.0 38.0 90.0 14.0 66.0 35.0 77.0 20.0 86.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-40.0 17.0 -18.0 33.0 18.0 0.0 -20.0 38.0 90.0 14.0 66.0 35.0 77.0 20.0 86.0 120.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 7.0
}

reach_sugar() {
    look_at -0.35 0.25 -0.1
    echo "ctpq time 2.0 off 0 pos (-12.0 26.0 1.0 71.0 -28.0 0.0 -18.0 50.0 90.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-12.0 26.0 1.0 71.0 -28.0 0.0 -18.0 50.0 90.0 20.0 30.0 50.0 85.0 45.0 85.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-12.0 26.0 1.0 71.0 -28.0 0.0 -18.0 50.0 90.0 20.0 30.0 50.0 85.0 45.0 85.0 120.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 6.0
}

reach_in_hands() {
    look_at -0.35 0.15 -0.1
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 2.0 off 0 pos (1.0 44.0 -3.0 83.0 -32.0 0.0 -18.0 50.0 90.0 20.0 30.0 50.0 85.0 45.0 85.0 120.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-22.0 34.0 21.0 63.0 -19.0 0.0 -20.0 38.0 90.0 14.0 66.0 35.0 77.0 20.0 86.0 120.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
}

pour_sugar() {
    look_at -0.35 0.0 -0.1
    echo "ctpq time 1.0 off 0 pos (-25.0 29.0 61.0 56.0 -30.0 0.0 -20.0 38.0 90.0 14.0 66.0 35.0 77.0 20.0 86.0 120.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.1
    echo "ctpq time 2.0 off 0 pos (-30.0 33.0 21.0 67.0 23.0 0.0 -18.0 50.0 90.0 20.0 30.0 50.0 85.0 45.0 85.0 120.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-30.0 25.0 37.0 91.0 90.0 0.0 -18.0 50.0 90.0 20.0 30.0 50.0 85.0 45.0 85.0 120.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 4.0
    echo "ctpq time 1.0 off 0 pos (-30.0 33.0 21.0 67.0 23.0 0.0 -18.0 50.0 90.0 20.0 30.0 50.0 85.0 45.0 85.0 120.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.1
    look_at -0.4 0.25 -0.1
    echo "ctpq time 2.0 off 0 pos (-10.0 0.0 16.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 2.0 off 0 pos (-27.0 37.0 -28.0 35.0 -17.0 -2.0 -20.0 50.0 90.0 20.0 30.0 50.0 85.0 45.0 85.0 120.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-22.0 33.0 21.0 97.0 -33.0 0.0 5.0 38.0 90.0 14.0 66.0 35.0 77.0 20.0 86.0 120.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    echo "ctpq time 1.0 off 0 pos (-27.0 37.0 -28.0 35.0 -17.0 -2.0 -20.0 50.0 90.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    echo "ctpq time 2.0 off 0 pos (-10.0 0.0 8.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 2.0 off 0 pos (7.0 52.0 -26.0 68.0 -32.0 -2.0 -20.0 50.0 90.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0

    look_at -0.35 0.15 -0.1
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 2.0 off 0 pos (10.0 45.0 25.0 98.0 -30.0 0.0 -18.0 50.0 00.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-22.0 34.0 21.0 63.0 -19.0 0.0 -20.0 38.0 90.0 14.0 66.0 35.0 77.0 20.0 86.0 120.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
}

push_liquid() {
    look_at -0.3 -0.45 -0.1
    echo "ctpq time 2.0 off 0 pos (-31.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 2.0 off 0 pos (10.0 60.0 29.0 86.0 -45.0 0.0 -20.0 38.0 90.0 14.0 66.0 35.0 77.0 20.0 86.0 120.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.5
    echo "-0.135 -0.360 -0.005 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 4.0
    echo "-0.120 -0.300 -0.015 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 1.0
    echo "-0.090 -0.300 -0.010 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 1.5
}

pour_syrup() {
    look_at -0.45 -0.250 0.0
    echo "-0.220 -0.250 0.036 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 2.0
    echo "-0.310 -0.250 0.036 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 3.0
    echo "-0.220 -0.250 0.036 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 3.0
    speak "un altro po', perche no?"
    echo "-0.310 -0.250 0.036 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 3.0
    echo "-0.220 -0.250 0.036 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 2.0
}

reach_mixer() {
    look_at -0.45 0.0 0.0
    echo "-0.250 -0.110 -0.020 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 2.0
    echo "-0.310 -0.110 -0.020 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 2.0
    echo "-0.310 -0.110  0.090 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 2.0
}

push_button() {
    look_at -0.1 0.4 -0.2
    echo "ctpq time 1.0 off 0 pos (10.0 38.0 -20.0 100.0 49.0 0.0 -18.0 50.0 00.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time 1.0 off 0 pos (10.0 41.0 -31.0 61.0 43.0 0.0 -18.0 50.0 00.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    look_at -0.45 0.0 0.0
    echo "ctpq time 1.0 off 0 pos (10.0 31.0 -21.0 46.0 54.0 -21.0 3.0 50.0 00.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 4.0
    echo "ctpq time 1.0 off 0 pos (10.0 41.0 -31.0 61.0 43.0 0.0 -18.0 50.0 00.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time 1.0 off 0 pos (10.0 38.0 -20.0 100.0 49.0 0.0 -18.0 50.0 00.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time 1.0 off 0 pos (10.0 45.0 25.0 98.0 -30.0 0.0 -18.0 50.0 00.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
}

give_drink() {
    echo "-0.310 -0.110 -0.020 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 2.0
    echo "-0.220 -0.050 -0.010 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 2.0
    look_at -0.3 0.3 0.45
    echo "-0.250  0.100  0.20 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 3.0
    echo "ctpq time 1.0 off 0 pos (-77.0 23.0 80.0 89.0 -74.0 -90.0 3.0 10.0 90.0 10.0 10.0 10.0 10.0 10.0 10.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
}

return_home() {
    echo "-0.250  0.100  0.070 -0.155917 0.702537 -0.694357 2.598576" | yarp write ... /armCtrl/left_arm/xd:i
    sleep 3.0
    echo "ctpq time 1.5 off 0 pos (10.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 1.5
    init
}

run_all() {
    reach_glass
    reach_sugar
    reach_in_hands
    pour_sugar
    push_liquid
    pour_syrup
    reach_mixer
    push_button
    give_drink
    return_home
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

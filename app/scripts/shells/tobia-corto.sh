
 #!/bin/bash

#######################################################################################
# HELP
#######################################################################################
usage() {
cat << EOF

***************************************************************************************
TOBIA VIDEO SCRIPTING
Authors:
- Valentina Vasco   <valentina.vasco@iit.it>
- Ettore Landini    <ettore.landini@iit.it>

This script scripts through the commands available for the shooting of Tobia movie

USAGE:
        $0 options

WITH AVAILABLE OPTIONS:
        scene_1
        scene_8 TEYES TARM ARM
        scene_14 TARM ARM
        scene_17 TEYES
        scene_22 TARM ARM

EXAMPLE: 
        ./tobia-corto.sh scene_1
        ./tobia-corto.sh scene_8 0.75 3.0 left_arm
        ./tobia-corto.sh scene_14 0.7 left_arm
        ./tobia-corto.sh scene_17 0.5
        ./tobia-corto.sh scene_22 2.0 left_arm
  
        
***************************************************************************************
EOF
}

#######################################################################################
# HELPER FUNCTIONS
#######################################################################################
close_eyes() {
    echo "S00" | yarp write ... /icub/face/raw/in
}

open_eyes() {
    echo "S70" | yarp write ... /icub/face/raw/in
}

squint() {
    echo "S30" | yarp write ... /icub/face/raw/in
}

point() {
    echo "ctpq time $1 off 0 pos (-22.0 130.0 9.5 77.0 -22.0 -5.5 -6.0 54.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/$2/rpc
}

point_glass() {
    echo "ctpq time $1 off 0 pos (-6.0 22.0 33.0 66.0 75.0 0.0 6.0 54.0 30.0 46.0 100.0 0.0 0.0 60.0 130.0 220.0)" | yarp rpc /ctpservice/$2/rpc
}

point_breast() {
    echo "ctpq time $1 off 0 pos (-35.5 43.5 52.5 105.0 -52.5 -5.4 -6.0 54.0 55.0 37.0 2.0 0.0 3.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$2/rpc
}

point_forehead() {
    echo "ctpq time $1 off 0 pos (-25.0 127.0 -3.0 105.0 -22.0 28.0 -6.0 21.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/$2/rpc
}

point_face() {
    echo "ctpq time $1 off 0 pos (-25.0 90.0 3.5 105.0 -22.0 28.0 -6.0 21.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/$2/rpc
}

nod() {
    echo "ctpq time 0.5 off 0 pos (10.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (-10.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (10.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (-10.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (10.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (-10.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (0.0)"   | yarp rpc /ctpservice/head/rpc
}

clean() {
    echo "ctpq time 0.5 off 0 pos (-6.0 22.0 33.0 66.0 75.0 0.0 15.0 54.0 30.0 46.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time 0.5 off 0 pos (-6.0 22.0 33.0 66.0 75.0 0.0 -15.0 54.0 30.0 46.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time 0.5 off 0 pos (-6.0 22.0 33.0 66.0 75.0 0.0 15.0 54.0 30.0 46.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time 0.5 off 0 pos (-6.0 22.0 33.0 66.0 75.0 0.0 -15.0 54.0 30.0 46.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time 0.5 off 0 pos (-6.0 22.0 33.0 66.0 75.0 0.0 15.0 54.0 30.0 46.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time 0.5 off 0 pos (-6.0 22.0 33.0 66.0 75.0 0.0 -15.0 54.0 30.0 46.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
}

gaze() {
    echo "$1" | yarp write ... /gaze
}

generic_gaze() {
    gaze "set-delta 10 10 1" 
    gaze "look-around 0.0 0.0 5.0"
}

gaze_left() {
    gaze "look -20.0 0.0 5.0"
}

gaze_right() {
    gaze "look 20.0 0.0 5.0"
}

gaze_down() {
    gaze "look 0.0 -20.0 5.0"
}

gaze_up() {
    gaze "look 0.0 20.0 5.0"
}

follow_only_eyes() {
    gaze "look -20.0 0.0 5.0"
}

set_speed_eyes() {
    echo "set Teyes $1" | yarp rpc /iKinGazeCtrl/rpc
}

take_pen() {
    echo "ctpq time 3.0 off 7 pos (27.0 47.0 22.0 123.0 66.0 100.0 35.0 90.0 240.0)" | yarp rpc /ctpservice/$1/rpc  
}

greet() {
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/$2/rpc
    sleep 1.0
    echo "ctpq time $1 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/$2/rpc
    sleep 0.5
}

sad() {
    echo "set mou sad" | yarp rpc /icub/face/emotions/in
    echo "set leb sad" | yarp rpc /icub/face/emotions/in
    echo "set reb sad" | yarp rpc /icub/face/emotions/in
}

home_gaze() {
    gaze "look 0.0 0.0 5.0"
}

home_arm() {
    echo "ctpq time $1 off 0 pos (-12.0 24.0 23.0 64.0 -7.0 -5.0 10.0 54.0 -6.0 37.0 2.0 0.0 3.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$2/rpc
}

home_all() {
    # This is with the arms over the table
    home_arm 2.0 left_arm
    home_arm 2.0 right_arm

    home_gaze
}

#######################################################################################
# SUB-SCENES FUNCTIONS
#######################################################################################
perform_1_1() {
    close_eyes
    sleep 2.0
    open_eyes  
    sleep 2.0
    squint
    sleep 2.0
    open_eyes
}

perform_1_2() {
    generic_gaze
}

perform_8_3() {
    TEYES=$1
    echo "8.3"
    set_speed_eyes $TEYES
    follow_only_eyes 
}

perform_8_4() {
    TIME=$1
    ARM=$2
    echo "PARAMS: $TIME $ARM"
    echo "8.4 $TIME $ARM"
    point $TIME $ARM
}

perform_8_5() {
    TIME=$1
    ARM=$2
    echo "8.5"
    point_breast $TIME $ARM
    gaze "look -0.5 -10.0 0.34"
}

perform_8_6() {
    echo "8.6"
    point_forehead $TIME $ARM
}

perform_8_7() {
    echo "8.7"
    nod
}

perform_8_8() {
    TIME=$1
    ARM=$2
    echo "8.8"
    point_glass $TIME $ARM
    clean $ARM  
}

perform_14_15() {
    TARM=$1
    ARM=$2
    echo "14.15"
    greet $TARM $ARM
}

perform_17_20() {
    TEYES=$1
    echo "17.20"
    set_speed_eyes $TEYES
    gaze_right
    sleep 3.0
    gaze_left
    sleep 3.0
    gaze_up
    sleep 3.0
    gaze_down
    sleep 3.0
    close_eyes
    home_gaze
    sleep 3.0
    open_eyes
    sleep 3.0
    squint
    sleep 3.0
}

perform_22_25() {
    echo "22_25"
    gaze "look 0.0 4.0 5.0"
    sleep 10.0
    generic_gaze
}

perform_22_26() {
    TARM=$1
    ARM=$2
    echo "22_26"
    point_face $TARM $ARM
}

#######################################################################################
# SCENES FUNCTIONS
#######################################################################################
scene_1() {
    echo "clear pitch" | yarp rpc /iKinGazeCtrl/rpc
    echo "clear yaw" | yarp rpc /iKinGazeCtrl/rpc
    home_gaze  

    echo "Scena 1"
    perform_1_1
    sleep 2.0
    perform_1_2

    sleep 10.0
    home_gaze
}

scene_8() {
    TEYES=$1
    TARM=$2
    ARM=$3
    
    echo "bind pitch 0.0 1.0" | yarp rpc /iKinGazeCtrl/rpc
    echo "bind yaw 0.0 1.0" | yarp rpc /iKinGazeCtrl/rpc
    home_all

    echo "Scena 8 with $ARM"

    #params: Teyes
    perform_8_3 $TEYES
    sleep 5.0

    #params: left_arm | right_arm
    perform_8_4 $TARM $ARM
    sleep 5.0

    #params: left_arm | right_arm
    perform_8_5 $TARM $ARM
    sleep 5.0
 
    #params: left_arm | right_arm
    perform_8_6 $TARM $ARM 
    sleep 5.0

    perform_8_7    
    sleep 5.0

    #params: left_arm | right_arm
    perform_8_8 $TARM $ARM
    sleep 5.0

    home_all
}

scene_11() {
    echo "Scena 11"
    take_pen $1
}

scene_12() {
    echo "Scena 12"
}

scene_13() {
    echo "Scena 13"
}

scene_14() {
    TARM=$1
    ARM=$2
    
    echo "Scena 14"
    perform_14_15 $TARM $ARM

    home_all
}

scene_15() {
    echo "Scena 15"
}

scene_17() {
    TEYES=$1    

    echo "bind pitch 0.0 1.0" | yarp rpc /iKinGazeCtrl/rpc
    echo "bind yaw 0.0 1.0" | yarp rpc /iKinGazeCtrl/rpc
    echo "set Teyes 0.5" | yarp rpc /iKinGazeCtrl/rpc

    echo "Scena 17"
    perform_17_20 $TEYES

    home_gaze
    open_eyes
}

scene_19() {
    echo "Scena 19"
}

scene_20() {
    echo "Scena 20"
}

scene_22() {
    TARM=$1
    ARM=$2

    echo "clear pitch" | yarp rpc /iKinGazeCtrl/rpc
    echo "clear yaw" | yarp rpc /iKinGazeCtrl/rpc
    home_gaze

    echo "Scena 22"

    perform_22_25
    sleep 5.0

    perform_22_26 $TARM $ARM
    sleep 5.0
    
    home_all
}

#######################################################################################
# "MAIN" FUNCTION:                                                                    #
#######################################################################################
echo "********************************************************************************"
echo ""

$1 $2 $3 $4

if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi

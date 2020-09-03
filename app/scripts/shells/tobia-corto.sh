
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
    echo "S40" | yarp write ... /icub/face/raw/in
}

open_eyes() {
    echo "S70" | yarp write ... /icub/face/raw/in
}

squint() {
    echo "S45" | yarp write ... /icub/face/raw/in
}

point() {
    echo "ctpq time $1 off 0 pos (-31.0 106.0 5.0 80.0 -21.5 -5.5 -6.0 18.0 21.5 25.0 69.5 8.0 22.0 65.5 129.0 172.5)" | yarp rpc /ctpservice/$2/rpc
}

point_glass() {
    echo "ctpq time $1 off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 10.0 18.0 21.5 25.0 69.5 8.0 22.0 65.5 129.0 172.5)" | yarp rpc /ctpservice/$2/rpc
}

point_breast() {
    echo "ctpq time $1 off 0 pos (-31.5 43.5 49.5 103.0 -42.0 22.0 -14.5 0.0 10.0 20.0 95.0 3.0 27.0 3.0 27.0 17.5)" | yarp rpc /ctpservice/$2/rpc
}

point_forehead() {
    echo "ctpq time $1 off 0 pos (-65.5 40.0 12.5 105.0 -31.5 24.0 -8.0 18.0 21.5 25.0 69.5 8.0 30.0 65.5 129.0 172.5)" | yarp rpc /ctpservice/$2/rpc
}

point_face() {
    echo "ctpq time $1 off 0 pos (-43.2 35.0 10.5 105.0 -37.2 24.0 -6.7 18.0 21.5 25.0 69.5 8.0 54.4 65.5 129.0 172.5)" | yarp rpc /ctpservice/$2/rpc
}

nod() {
    TIME=0.25
    RANGE=6.0
    echo "ctpq time $TIME off 0 pos ($RANGE)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos (-$RANGE)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos ($RANGE)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos (-$RANGE)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos ($RANGE)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos (-$RANGE)" | yarp rpc /ctpservice/head/rpc
}

clean() {
    RANGE=15
    TIME=0.3
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 $RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 -$RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 $RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 -$RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 $RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 -$RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 $RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 -$RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 $RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 -$RANGE 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 0 pos (-50.0 22.0 33.0 50.0 40.0 15.5 0.0 28.0 10.0 6.0 10.0 0.0 0.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$1/rpc
}

look_down() {
    echo "ctpq time 1.0 off 0 pos (-27.5 0.0 0.0 -20.5 0.0 5.0)"  | yarp rpc /ctpservice/head/rpc
}

gaze() {
    echo "$1" | yarp write ... /gaze
}

gaze_with_neck() {
    echo "clear pitch" | yarp rpc /iKinGazeCtrl/rpc
    echo "clear yaw" | yarp rpc /iKinGazeCtrl/rpc
    gaze "$1"
}

gaze_only_eyes() {
    echo "bind pitch 0.0 1.0" | yarp rpc /iKinGazeCtrl/rpc
    echo "bind yaw 0.0 1.0" | yarp rpc /iKinGazeCtrl/rpc
    gaze "$1"
}

generic_gaze() {
    gaze_with_neck "set-delta 30 10 1" 
    gaze_with_neck "look-around 0.0 0.0 5.0"
}

gaze_only_eyes_left() {

    gaze_only_eyes "look -20.0 0.0 5.0"
}

gaze_only_eyes_right() {
    gaze_only_eyes "look 20.0 0.0 5.0"
}

gaze_only_eyes_down() {
    gaze_only_eyes "look 0.0 -20.0 5.0"
}

gaze_only_eyes_up() {
    gaze_only_eyes "look 0.0 20.0 5.0"
}

follow_only_eyes() {
    gaze_only_eyes "look -20.0 0.0 5.0"
}

set_speed_eyes() {
    echo "set Teyes $1" | yarp rpc /iKinGazeCtrl/rpc
}

take_pen() {
    echo "ctpq time 3.0 off 7 pos (27.0 47.0 22.0 123.0 66.0 100.0 35.0 90.0 240.0)" | yarp rpc /ctpservice/$1/rpc  
}

greet() {
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -10.0 0.0 20.0 11.0 1.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -10.0 10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -10.0 -10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -10.0 10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -10.0 -10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -10.0 10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -10.0 -10.0)" | yarp rpc /ctpservice/$2/rpc
}

sad() {
    echo "set mou sad" | yarp rpc /icub/face/emotions/in
    echo "set leb sad" | yarp rpc /icub/face/emotions/in
    echo "set reb sad" | yarp rpc /icub/face/emotions/in
}

curious() {
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    echo "set leb shy" | yarp rpc /icub/face/emotions/in
    echo "set reb shy" | yarp rpc /icub/face/emotions/in
}

neutral() {
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    echo "set leb neu" | yarp rpc /icub/face/emotions/in
    echo "set reb neu" | yarp rpc /icub/face/emotions/in
}

happy() {
    echo "set mou hap" | yarp rpc /icub/face/emotions/in
    echo "set leb hap" | yarp rpc /icub/face/emotions/in
    echo "set reb hap" | yarp rpc /icub/face/emotions/in
}

caress() {
    RANGE=13.5
    TIME=1.5
    echo "ctpq time 1.5 off 0 pos (-78.0 33.7 -4.0 46.5 21.6 15.7 $RANGE 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$1/rpc
    sleep 2.0
    echo "ctpq time $TIME off 6 pos (-$RANGE 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 6 pos ($RANGE 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 6 pos (-$RANGE 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$1/rpc
}

home_head() {
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 0.0 0.0 0.0 5.0)"  | yarp rpc /ctpservice/head/rpc
}

home_arm() {
    echo "ctpq time $1 off 0 pos (-29.5 30.0 0.0 44.5 0.0 0.0 0.0 15.0 44.5 0.0 2.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/$2/rpc
}

home_all() {
    # This is with the arms over the table
    home_arm 2.0 left_arm
    home_arm 2.0 right_arm
    home_head
    neutral
    open_eyes
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
    curious
}

perform_8_3() {
    TEYES=${1:-0.75}
    echo "8.3"
    set_speed_eyes $TEYES
    follow_only_eyes 
}

perform_8_4() {
    echo "8.4"
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    point $TARM $ARM
    gaze_with_neck "look -20.0 15.0 5.0"
}

perform_8_5() {
    echo "8.5"
    TARM=${1:-1.5}
    ARM=${2:-left_arm}
    point_breast $TARM $ARM
    look_down
    sad
}

perform_8_6() {
    echo "8.6"
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    gaze_with_neck "look -10.0 -10.0 5.0"
    point_forehead 3.0 left_arm
    happy
}

perform_8_7() {
    echo "8.7"
    nod
}

perform_8_8() {
    echo "8.8"
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    generic_gaze
    sleep 10.0
    gaze_with_neck "idle"
    gaze_with_neck "look -10.0 -25.0 5.0"
    point_glass $TARM $ARM
    sleep 7.0
    clean left_arm 
}

perform_14_15() {
    echo "14.15"
    TARM=${1:-0.3}
    ARM=${2:-left_arm}
    look_down
    greet $TARM $ARM
}

perform_17_22() {
    echo "17.20"
    TEYES=${1:-0.75}
    set_speed_eyes $TEYES
    gaze_only_eyes_right
    sleep 3.0
    gaze_only_eyes_left
    sleep 3.0
    gaze_only_eyes_up
    sleep 3.0
    gaze_only_eyes_down
    sleep 3.0
    close_eyes
    home_head
    sleep 3.0
    open_eyes
    sleep 3.0
    squint
    sleep 3.0
}

perform_22_25() {
    echo "22_25"
    gaze_with_neck "look 0.0 4.0 5.0"
    sleep 10.0
    generic_gaze
}

perform_22_29() {
    echo "22_29"
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    gaze_with_neck "look -10.0 10.0 5.0"
    point_face $TARM $ARM
}

perform_22_30() {
    echo "22_30"
    ARM=${1:-left_arm}
    sad
    gaze_with_neck "look -10.0 10.0 5.0"
    caress $ARM
}

#######################################################################################
# SCENES FUNCTIONS
#######################################################################################
scene_1() {
    home_head  

    echo "Scena 1"
    perform_1_1
    sleep 2.0
    perform_1_2

    sleep 10.0
    home_head
}

scene_8() {
    TEYES=$1
    TARM=$2
    ARM=$3
    
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

    echo "Scena 17"
    perform_17_22 $TEYES

    home_head
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

    home_head

    echo "Scena 22"

    perform_22_29
    sleep 5.0

    perform_22_30 $TARM $ARM
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

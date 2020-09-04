
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
    #echo "ctpq time $1 off 0 pos (-31.0 106.0 5.0 80.0 -21.5 -5.5 -6.0 18.0 21.5 25.0 69.5 8.0 22.0 65.5 129.0 172.5)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $1 off 0 pos (-91.0 36.0 13.0 46.0 -21.5 -5.5 -6.0 18.0 21.5 25.0 69.5 8.0 22.0 65.5 129.0 172.5)" | yarp rpc /ctpservice/$2/rpc
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

point_straight() {
	echo "ctpq time $1 off 0 pos ($2 $3 3.5 20.0 $4 28.0 -6.0 57.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/$5/rpc
}

nod() {
    START=$1
    TIME=$2
    let END=$START-8
    
    echo "ctpq time $TIME off 0 pos ($END)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos ($START)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos ($END)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos ($START)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos ($END)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $TIME off 0 pos ($START)" | yarp rpc /ctpservice/head/rpc
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

gaze_bind() {
    let BINDMAX=$2+1
    echo "bind $1 $2 $BINDMAX" | yarp rpc /iKinGazeCtrl/rpc
}

gaze_only_eyes() {
    gaze_bind pitch 0.0
    gaze_bind yaw 0.0
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

set_speed_neck() {
    echo "set Tneck $1" | yarp rpc /iKinGazeCtrl/rpc
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

cover_eye() {
	echo "ctpq time $1 off 0 pos (-67.19 19 25.74 95 -60 0 0 59 20 20 20 10 10 10 10 10)" | yarp rpc /ctpservice/$2/rpc
}

uncover_eye(){
	echo "ctpq time $1 off 0 pos (-40 35 16 95 -60 0 0 59 20 20 20 10 10 10 10 10)" | yarp rpc /ctpservice/$2/rpc
}

peek_a_boo(){
        TARM=$1
        THIDE=$2
	gaze "idle"
	cover_eye $TARM left_arm
	sleep $TARM
	cover_eye $TARM right_arm
	sleep $TARM
	close_eyes
	sleep $THIDE
	let TUNCOVER=$TARM*2
	echo $TUNCOVER
	uncover_eye $TUNCOVER left_arm
	uncover_eye $TUNCOVER right_arm
	sleep $TARM
	open_eyes
}

emotion() {
    echo "set mou $1" | yarp rpc /icub/face/emotions/in
    echo "set leb $1" | yarp rpc /icub/face/emotions/in
    echo "set reb $1" | yarp rpc /icub/face/emotions/in
}

happy() {
	emotion "hap"
}

neutral() {
	emotion "neu"
}

sad() {
	emotion "sad"
}

curious() {
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    echo "set leb shy" | yarp rpc /icub/face/emotions/in
    echo "set reb shy" | yarp rpc /icub/face/emotions/in
}

arm_sleeve() {
	echo "ctpq time $1 off 0 pos (-48.48 25.71 3.5 29.99 39.6 6.37 -2.65 59.65 69.97 70.87 19.98 10.4 10.02 10.37 9.07 5.3)" | yarp rpc /ctpservice/$2/rpc
}

fix_point(){
	echo "ctpq time $1 off 0 pos ($2 $3 $4 $5 $6 $7)"  | yarp rpc /ctpservice/head/rpc
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
    home_arm 3.0 left_arm
    home_arm 3.0 right_arm
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
    set_speed_eyes $TEYES
    follow_only_eyes 
}

perform_8_4() {
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    point $TARM $ARM
    gaze_with_neck "look -20.0 15.0 5.0"
}

perform_8_5() {
    TARM=${1:-1.5}
    ARM=${2:-left_arm}
    point_breast $TARM $ARM
    #look_down
    gaze_only_eyes_down
    sad
}

perform_8_6() {
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    gaze_with_neck "look -10.0 -10.0 5.0"
    point_forehead $TARM $ARM
    happy
}

perform_8_7() {
    START=${1:-0}
    TIME=${2:-0.6}
    nod $START $TIME
}

perform_8_8() {
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

perform_12_12() {
    AZI=${1:-20.0}
    EL=${2:-10.0}
    gaze_with_neck "look $AZI $EL 5"
}

perform_13_13() {
    EYESDIR=${1:-1}
    SEYE=${2:-2.0}
    SNECK=${3:-2.0}
    TARM=${4:-3.0}
    T1=${5:-5.0}
    T2=${6:-6.0}
    let EYESYAW=22*$EYESDIR
    
    set_speed_eyes $SEYE
    set_speed_neck $SNECK
    gaze_with_neck "look 0.0 10.0 5.0"
    sleep $T1
    arm_sleeve $TARM left_arm
    arm_sleeve $TARM right_arm
    sleep $T2
    set_speed_eyes 0.25
    set_speed_neck 0.75   
    fix_point 2.0 -28.8956 -3.23077 $EYESYAW -17.978 -0.346534 9.00014	
}

perform_14_15() {
    TARM=${1:-0.3}
    ARM=${2:-left_arm}
    look_down
    greet $TARM $ARM
}

perform_15_16() {
    AZI=${1:-20.0}
    EL=${2:-10.0}
    set_speed_eyes 0.75
    set_speed_neck 0.75
    gaze_with_neck "look $AZI $EL 5.0"
    sleep 4.0
    gaze_bind pitch $EL
    gaze_bind yaw $AZI
    gaze "set-delta 10 5 0" 
    gaze "look-around $AZI $EL 5.0"
}

perform_15_17() {
    TARM=${1:-3}
    THIDE=${2:-2.0}
    peek_a_boo $TARM $THIDE
}

perform_17_22() {
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

perform_20_24() {
    AZI=${1:-20.0}
    EL=${2:-10.0}
    gaze_with_neck "look $AZI $EL 5"
}

perform_20_25() {
    AZI=${1:-20.0}
    EL=${2:--20.0}
    gaze_with_neck "look $AZI $EL 5"
    sad
}

perform_22_25() {
    gaze_with_neck "look 0.0 4.0 5.0"
    sleep 10.0
    generic_gaze
}

perform_22_26() {
    AZI=${1:-20.0}
    EL=${2:-10.0}
    gaze_with_neck "look $AZI $EL 5"
}

perform_22_29() {
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    gaze_with_neck "look -10.0 10.0 5.0"
    point_face $TARM $ARM
}

perform_22_30() {
    ARM=${1:-left_arm}
    sad
    gaze_with_neck "look -10.0 10.0 5.0"
    caress $ARM
}

#######################################################################################
# "MAIN" FUNCTION:                                                                    #
#######################################################################################
echo "********************************************************************************"
echo ""

$1 $2 $3 $4 $5 $6 $7 $8

if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi

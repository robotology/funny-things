
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
  
        
***************************************************************************************
EOF
}

#######################################################################################
# GLOBAL VARIABLES
#######################################################################################
DRAW_TIME=1.5

#######################################################################################
# HELPER FUNCTIONS
#######################################################################################
speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}

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
    echo "ctpq time $1 off 0 pos (-43.2 24.0 10.5 105.0 -46.0 24.0 -6.7 18.0 21.5 25.0 69.5 8.0 54.4 65.5 129.0 172.5)" | yarp rpc /ctpservice/$2/rpc
}

point_straight() {
    echo "ctpq time $1 off 0 pos ($2 $3 3.5 20.0 $4 28.0 -6.0 57.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/$5/rpc
}

nod() {
    START=$1
    TIME=$2
    TUNCOVER=$(bc <<< "$START - 8")
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

generic_gaze() {
    gaze "set-delta 30 10 1" 
    gaze "look-around 0.0 0.0 5.0"
}

fix_only_eyes_left() {
    echo "ctpq time 1.0 off 3 pos (0.0 -20.0 5.0)"  | yarp rpc /ctpservice/head/rpc
}

fix_only_eyes_right() {
    echo "ctpq time 1.0 off 3 pos (0.0 20.0 5)"  | yarp rpc /ctpservice/head/rpc
}

fix_only_eyes_down() {
    echo "ctpq time 1.0 off 3 pos (-20.0 0.0 5)"  | yarp rpc /ctpservice/head/rpc
}

fix_only_eyes_up() {
    echo "ctpq time 1.0 off 3 pos (20.0 0.0 5)"  | yarp rpc /ctpservice/head/rpc
}

fix_only_eyes() {
    AZI=$(bc <<< "20*$1")
    echo "ctpq time 1.0 off 3 pos ($AZI 0.0 5)"  | yarp rpc /ctpservice/head/rpc
}

follow_only_eyes() {
    AZI=$(bc <<< "20*$1")
    gaze_only_eyes "look $AZI 0.0 5.0"
}

look_around_eyes() {
    echo "ctpq time $1 off 3 pos (0.0 0.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $1 off 3 pos (1.0 3.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $1 off 3 pos (5.0 -5.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $1 off 3 pos (-10.0 0.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $1 off 3 pos (-6.0 2.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $1 off 3 pos (4.0 8.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $1 off 3 pos (0.0 -1.0)"  | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $1 off 3 pos (-3.0 6.0)"  | yarp rpc /ctpservice/head/rpc
}

follow_draw_wall_left() {
    ENDEYE=$(bc <<< "$1 - $2")
    fix_point $DRAW_TIME 0.0274725 0.021978 31 0.043956 $1 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 31 0.043956 $ENDEYE 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 31 0.043956 $1 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 31 0.043956 $ENDEYE 2.00394
    fix_point $DRAW_TIME 0.0274725 0.021978 31 0.043956 $1 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 31 0.043956 $ENDEYE 2.00394
    fix_point $DRAW_TIME 0.0274725 0.021978 31 0.043956 $1 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 31 0.043956 $ENDEYE 2.00394
}

follow_draw_wall_right() {
    ENDEYE=$(bc <<< "$1 - $2")
    fix_point $DRAW_TIME 0.0274725 0.021978 -31 0.043956 $1 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 -31 0.043956 $ENDEYE 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 -31 0.043956 $1 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 -31 0.043956 $ENDEYE 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 -31 0.043956 $1 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 -31 0.043956 $ENDEYE 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 -31 0.043956 $1 2.00394	
    fix_point $DRAW_TIME 0.0274725 0.021978 -31 0.043956 $ENDEYE 2.00394
}

follow_draw_line_left() {
    ENDEYE=$(bc <<< "$1 - $2") #WE NEED THE EXTRASPACE BEFORE AND AFTER THE MINUS
    echo $ENDEYE
    fix_point $DRAW_TIME 0.0274725 0.021978 18.0 0.043956 $1 10.0	
    fix_point $DRAW_TIME 0.0274725 0.021978 18.0 0.043956 $ENDEYE 10.0	
}

set_speed_eyes() {
    echo "set Teyes $1" | yarp rpc /iKinGazeCtrl/rpc
}

set_speed_neck() {
    echo "set Tneck $1" | yarp rpc /iKinGazeCtrl/rpc
}

take_pen_wall_right() {
    START=${1:-30}
    echo "ctpq time 3 off 0 pos (-80.1648 $START -5.31495 52.7582 0.000353772 -0.043956 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc  
}

take_pen_wall_left() {
    START=${1:-30}
    echo "ctpq time 3 off 0 pos (-80.1648 $START -5.31495 52.7582 0.000353772 -0.043956 -0.142857 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc  
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

cover_left_eye() {
    echo "ctpq time $1 off 0 pos (-67.19 19 25.74 95 -60 0 0 15.0 20.0 20.0 17.0 10.0 13.5 10.0 13.0 5.0)" | yarp rpc /ctpservice/left_arm/rpc
}

cover_right_eye() {
    echo "ctpq time $1 off 0 pos (-67.19 19 25.74 95 -60 0 0 57.0 20.0 0.0 0.0 0.0 0.0 0.0 0.0 2.5)" | yarp rpc /ctpservice/right_arm/rpc
}

uncover_left_eye() {
    echo "ctpq time $1 off 0 pos (-35 35 16 95 -60 0 0 15.0 20.0 20.0 17.0 10.0 13.5 10.0 13.0 5.0)" | yarp rpc /ctpservice/left_arm/rpc
}

uncover_right_eye() {
    echo "ctpq time $1 off 0 pos (-35 35 16 95 -60 0 0 57.0 20.0 0.0 0.0 0.0 0.0 0.0 0.0 2.5)" | yarp rpc /ctpservice/right_arm/rpc
}

peek_a_boo(){
    TARM=$1
    TOPEN=$2
    THIDE=$3
    gaze "idle"
    cover_left_eye $TARM
    sleep $TARM
    #happy
    cover_right_eye $TARM
    sleep $TARM
    close_eyes
    sleep $THIDE
    TUNCOVER=$(bc <<< "$TOPEN*2")
    echo $TUNCOVER
    uncover_left_eye $TUNCOVER
    uncover_right_eye $TUNCOVER
    sleep $TOPEN
    open_eyes
    #surprised
}

emotion() {
    MOU=${1:-neu}
    LEB=${2:-$1}
    REB=${3:-$LEB}
    echo "set mou $MOU" | yarp rpc /icub/face/emotions/in
    echo "set leb $LEB" | yarp rpc /icub/face/emotions/in
    echo "set reb $REB" | yarp rpc /icub/face/emotions/in
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

surprised() {
    emotion "hap" "sur"
}

curious() {
    emotion "neu" "shy"
}

arm_sleeve_left() {
    echo "ctpq time $1 off 0 pos (-48.48 25.71 3.5 29.99 39.6 6.37 -2.65 59.65 69.97 70.87 19.98 10.4 10.02 10.37 9.07 5.3)" | yarp rpc /ctpservice/left_arm/rpc
}

arm_sleeve_right() {
    echo "ctpq time $1 off 0 pos (-48.48 25.71 3.5 29.99 39.6 6.37 -2.65 59.65 33.6 70.0 1.7 0.0 1.7 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
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
    echo "ctpq time $TIME off 6 pos ($RANGE 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time $TIME off 6 pos (-$RANGE 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$1/rpc
}

caress_elbow() {
    START=46.5
    PLUS=63.0
    MINUS=30.0
    MINUSW=15.0
    PLUSW=-15.0
    TIME=$1
    echo "ctpq time 2.0 off 0 pos (-78.0 33.7 -4.0 $START 21.6 15.7 0 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$2/rpc
    sleep 2.0
    echo "ctpq time $TIME off 3 pos ($PLUS 21.6 15.7 $MINUSW 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $TIME off 3 pos ($MINUS 21.6 15.7 $PLUSW 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $TIME off 3 pos ($PLUS 21.6 15.7 $MINUSW 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $TIME off 3 pos ($MINUS 21.6 15.7 $PLUSW 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$2/rpc
    echo "ctpq time $TIME off 3 pos ($PLUS 21.6 15.7 $MINUSW 20.0 10.0 16.2 34.0 2.7 30.5 0.0 30.5 10.0)" | yarp rpc /ctpservice/$2/rpc
}

draw_table_right() {
    echo "ctpq time 2.0 off 0 pos (-84.35 67.65 56.69 58.38 1.23 -2.33 13.44 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-84.35 77.23 56.6 58.38 1.23 -2.33 13.44 16.75 20.71 23.91 29.79 36 52.52 42.96 49.4 95.54)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-84.35 62.81 56.78 58.38 1.23 -2.24 13.53 15.85 21.49 22.17 30.52 36.4 50.11 42.22 40.3 93.94)" | yarp rpc /ctpservice/right_arm/rpc
}

draw_table_left() {
    echo "ctpq time 2.0 off 0 pos (-84.35 67.65 56.69 58.38 1.23 -2.33 13.44 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-84.35 77.23 56.6 58.38 1.23 -2.33 13.44 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-84.35 62.81 56.78 58.38 1.23 -2.24 13.53 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
}

draw_point_right() {
    ENDARM=$(bc <<< "$1+$2")
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 10.0 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc    
}

draw_line_right() {
    ENDARM=$(bc <<< "$1+$2")
    echo $ENDARM
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 10 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
}

draw_wall_wrist_right() {
    ENDARM=$(bc <<< "$1+$2")
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 10 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -10 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.0549451 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -10 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.0549451 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -10 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.0549451 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
}

draw_wall_no_wrist_right() {
    ENDARM=$(bc <<< "$1+$2")
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 0 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.0549451 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 0 -0.142857 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.0549451 16.75 20.84 23.48 29.79 36 49.71 42.96 40.3 95.01)" | yarp rpc /ctpservice/right_arm/rpc
}

draw_point_left() {
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 10.0 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
}

draw_line_left() {
    ENDARM=$(bc <<< "$1+$2")
    echo $ENDARM
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 10 -0.142857 8.68525 21.4805 30 70.5475 36.7637 60.0628 68.6921 29.1707 86.5875)" | yarp rpc /ctpservice/left_arm/rpc
}

draw_wall_wrist_left() {
    ENDARM=$(bc <<< "$1+$2")
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 10 -0.142857 8.68525 21.4805 30 70.5475 36.7637 60.0628 68.6921 29.1707 86.5875)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -10 -0.142857 8.68525 21.368 30 70.9092 36.3807 61.2324 69.7943 29 86.5875)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.0549451 8.28121 22.268 30 70.9092 35.9978 57.7237 68.3248 28.1038 84.9615)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 10 -0.142857 8.68525 21.4805 30 70.5475 36.7637 60.0628 68.6921 29.1707 86.5875)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -10 -0.142857 8.68525 21.368 30 70.9092 36.3807 61.2324 69.7943 29 86.5875)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.0549451 8.28121 22.268 30 70.9092 35.9978 57.7237 68.3248 28.1038 84.9615)" | yarp rpc /ctpservice/left_arm/rpc
}

draw_wall_no_wrist_left() {
    ENDARM=$(bc <<< "$1+$2")
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.142857 8.68525 21.4805 30 70.5475 36.7637 60.0628 68.6921 29.1707 86.5875)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 0 -0.142857 8.68525 21.368 30 70.9092 36.3807 61.2324 69.7943 29 86.5875)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.0549451 8.28121 22.268 30 70.9092 35.9978 57.7237 68.3248 28.1038 84.9615)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 -0.043956 -0.142857 8 21.4805 30 71.9942 36.3807 59.2831 68.6921 28.1038 87.807)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.142857 8.68525 21.4805 30 70.5475 36.7637 60.0628 68.6921 29.1707 86.5875)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $1 -5.31495 52.7582 0.000353772 0 -0.142857 8.68525 21.368 30 70.9092 36.3807 61.2324 69.7943 29 86.5875)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $DRAW_TIME off 0 pos (-80.1648 $ENDARM -5.31495 52.7582 0.000353772 0 -0.0549451 8.28121 22.268 30 70.9092 35.9978 57.7237 68.3248 28.1038 84.9615)" | yarp rpc /ctpservice/left_arm/rpc
}

move_trex_left() {
    echo "ctpq time 1.0 off 0 pos (-82.2747 60 60.7949 23.6593 -26 1.01099 -0.142857 3.23071 15.743 22.6271 57.5276 5.74115 79.9459 33.7913 50.8634 59.7582)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-82.2747 55 60.9708 23.6593 14.3996 1.01099 0.912088 3.83677 15.2931 23.55 56.081 6.12414 79.9459 33.424 47.6629 56.9127)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-82.2747 50 60.9708 23.6593 -6 1.01099 0.912088 3.83677 15.2931 23.55 56.081 6.12414 79.9459 33.424 47.6629 56.9127)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-82.2747 45 60.9708 23.6593 10 1.01099 0.912088 3.83677 15.2931 23.55 56.081 6.12414 79.9459 33.424 47.6629 56.9127)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-82.2747 40 60.9708 23.6593 -11 1.01099 0.912088 3.83677 15.2931 23.55 56.081 6.12414 79.9459 33.424 47.6629 56.9127)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-82.2747 35 60.9708 23.6593 7 1.01099 0.912088 3.83677 15.2931 23.55 56.081 6.12414 79.9459 33.424 47.6629 56.9127)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-82.2747 30 60.9708 23.6593 -9 1.01099 0.912088 3.83677 15.2931 23.55 56.081 6.12414 79.9459 33.424 47.6629 56.9127)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-82.2747 25 60.9708 23.6593 5 1.01099 0.912088 3.83677 15.2931 23.55 56.081 6.12414 79.9459 33.424 47.6629 56.9127)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-82.2747 20 60.9708 23.6593 -7 1.01099 0.912088 3.83677 15.2931 23.55 56.081 6.12414 79.9459 33.424 47.6629 56.9127)" | yarp rpc /ctpservice/left_arm/rpc
}

imitate_robot() {
    ENDARM=$(bc <<< "$3+$4")
    i=1
    while [ "$i" -le "$2" ]; do
        echo "ctpq time $1 off 0 pos (-15.8649 22.3947 0.00176004 $3 -0.00142396 0.000890493 0.119221 59.8433 0.048714 0.0672761 0.0200121 0.0240908 0.00724052 0.0210287 0.00672317 0.0203399)" | yarp rpc /ctpservice/left_arm/rpc
        fix_point $1 0.0 0.0 12.0 0.0 0.0 0.0 
        sleep $1
        echo "ctpq time $1 off 0 pos (-15.7507 22.4016 0.000323085 $3 0.000139115 0.000481608 0.118885 59.8411 0.0486692 0.0672874 0.0202492 0.0240462 0.0071755 0.0209986 0.00668006 0.0328025)" | yarp rpc /ctpservice/right_arm/rpc
        fix_point $1 0.0 0.0 -12.0 0.0 0.0 0.0 
        sleep $1

        echo "ctpq time $1 off 0 pos (-15.8649 22.3947 0.00176004 $ENDARM -0.00142396 0.000890493 0.119221 59.8433 0.048714 0.0672761 0.0200121 0.0240908 0.00724052 0.0210287 0.00672317 0.0203399)" | yarp rpc /ctpservice/left_arm/rpc
        fix_point $1 0.0 0.0 12.0 0.0 0.0 0.0 
        sleep $1
        echo "ctpq time $1 off 0 pos (-15.7507 22.4016 0.000323085 $ENDARM 0.000139115 0.000481608 0.118885 59.8411 0.0486692 0.0672874 0.0202492 0.0240462 0.0071755 0.0209986 0.00668006 0.0328025)" | yarp rpc /ctpservice/right_arm/rpc
        fix_point $1 0.0 0.0 -12.0 0.0 0.0 0.0 
        sleep $1
        i=$(($i + 1))
    done
}

home_left_arm_body() {
    echo "ctpq time 2.0 off 0 pos (-15.8649 22.3947 0.00176004 30.0 -0.00142396 0.000890493 0.119221 59.8433 0.048714 0.0672761 0.0200121 0.0240908 0.00724052 0.0210287 0.00672317 0.0203399)" | yarp rpc /ctpservice/left_arm/rpc
}

home_right_arm_body() {
    echo "ctpq time 2.0 off 0 pos (-15.7507 22.4016 0.000323085 30.0 0.000139115 0.000481608 0.118885 59.8411 0.0486692 0.0672874 0.0202492 0.0240462 0.0071755 0.0209986 0.00668006 0.0328025)" | yarp rpc /ctpservice/right_arm/rpc
}

home_head() {
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 0.0 0.0 0.0 5.0)"  | yarp rpc /ctpservice/head/rpc
}

home_left_arm() {
    echo "ctpq time $1 off 0 pos (-29.5 30.0 0.0 44.5 0.0 0.0 0.0 15.0 20.0 20.0 17.0 10.0 13.5 10.0 13.0 5.0)" | yarp rpc /ctpservice/left_arm/rpc
}

home_right_arm() {
    echo "ctpq time $1 off 0 pos (-29.5 30.0 0.0 44.5 0.0 0.0 0.0 57.0 20.0 0.0 0.0 0.0 0.0 0.0 0.0 2.5)" | yarp rpc /ctpservice/right_arm/rpc
}

home_all() {
    # This is with the arms over the table
    home_left_arm 3.0
    home_right_arm 3.0
    home_head
    #neutral
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
    #curious
}

perform_8_3() {
    AZIDIR=${1:-1}
    TEYES=${2:-2.5}
    set_speed_eyes $TEYES
    fix_only_eyes $AZIDIR
}

perform_8_4() {
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    point $TARM $ARM
    gaze "look -20.0 15.0 5.0"
}

perform_8_5() {
    TARM=${1:-1.5}
    ARM=${2:-left_arm}
    point_breast $TARM $ARM
    fix_only_eyes_down
    #sad
}

perform_8_6() {
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    gaze "look -10.0 -10.0 5.0"
    point_forehead $TARM $ARM
    #happy
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
    gaze "idle"
    gaze "look -10.0 -25.0 5.0"
    point_glass $TARM $ARM
    sleep 7.0
    clean left_arm 
}

perform_11_9() {
    look_down
    draw_table_right
}

perform_11_10() {
    fix_point 1.5 15 6 16 11 -5.4 5 
}

perform_12_12() {
    AZI=${1:-20.0}
    EL=${2:-10.0}
    gaze "look $AZI $EL 5"
}

perform_13_13_1() {
    EYETILT=${1:-12}
    AZI=${2:-0.0}
    EL=${3:-17.0}
    fix_point 1.5 $EL 0 $AZI $EYETILT 0 10
    sleep 1.5
    #emotion "neu" "sur" "neu"
}

perform_13_13_2() {
    TARM=${1:-1.5}
    arm_sleeve_left $TARM 
    arm_sleeve_right $TARM
}

perform_13_13_3() {
    EYESDIR=${1:-1}
    EYESYAW=$(bc <<< "22*$EYESDIR")
    fix_point 1.5 -28.8956 -3.23077 $EYESYAW -17.978 -0.346534 9.00014
    sleep 0.5
    #neutral
}

perform_13_13() {
    perform_13_13_1
    sleep 1.0
    perform_13_13_2
    sleep 3.0
    perform_13_13_3
}

perform_14_14() {
    look_down
    draw_table_right
}

perform_14_15() {
    TARM=${1:-0.3}
    ARM=${2:-left_arm}
    look_down
    greet $TARM $ARM
}

perform_15_16() {
    TLOOK=${1:-1.5}
    AZI=${2:-20.0}
    EL=${3:-10.0}
    set_speed_eyes 0.75
    set_speed_neck 1
    gaze "look $AZI $EL 5.0"
    sleep 4.0
    look_around_eyes $TLOOK
}

perform_15_17() {
    TARM=${1:-2.0}
    TOPEN=${2:-1.0}
    THIDE=${3:-2.5}
    peek_a_boo $TARM $TOPEN $THIDE
}

perform_15_18() {
    STARTLEFT=${1:-30.0}
    AMPLLEFT=${2:-30.0}
    STARTEYES=${3:-0.0} #${3:--8.0}
    AMPLEYES=${4:-20.0} #${4:--13.0}
    #follow_draw_wall_right $STARTEYES $AMPLEYES
    #draw_wall_wrist_right $STARTLEFT $AMPLLEFT
    fix_point $DRAW_TIME 0.0274725 0.021978 18.0 0.043956 $STARTEYES 12.0
    draw_point_left $STARTLEFT
    TREACT=$(bc <<< "$DRAW_TIME*3")
    sleep $TREACT
    follow_draw_line_left $STARTEYES $AMPLEYES
    draw_line_left $STARTLEFT $AMPLLEFT
}

perform_15_21() {
    TIME=${1:-1.5}
    NREP=${2:-2}
    START=${3:-45.0}
    AMPL=${4:-10.0}
    imitate_robot $TIME $NREP $START $AMPL
}

perform_17_22() {
    TEYES=${1:-0.75}
    fix_only_eyes_right
    sleep 0.2
    #emotion "neu" "neu" "sur"
    sleep 3.0
    fix_only_eyes_left
    sleep 0.2
    #emotion "hap" "sur" "neu"
    sleep 3.0
    fix_only_eyes_up
    sleep 0.2
    #emotion "neu" "sur" "sur"
    sleep 3.0
    fix_only_eyes_down
    #sad
    sleep 3.0
    #neutral
    close_eyes
    home_head
    sleep 3.0
    open_eyes
    #surprised
    sleep 3.0
    #emotion "neu" "ang"
    squint
    sleep 3.0
}

perform_20_24() {
    EYETILT=${1:-12}
    AZI=${2:--20.0}
    EL=${3:-18.0}
    fix_point 1.5 $EL 0 $AZI $EYETILT 0 10
}

perform_20_25() {
    EYETILT=${1:--15}
    AZI=${2:--20.0}
    EL=${3:--25.0}
    fix_point 1.5 $EL 0 $AZI $EYETILT 0 10
    sleep 0.75
    #sad
}

perform_20() {
    perform_20_24
    sleep 2.0
    perform_20_25
}

perform_22_26() {
    EYETILT=${1:-12}
    AZI=${2:--20.0}
    EL=${3:-17.0}
    fix_point 1.5 $EL 0 $AZI $EYETILT 0 10
}

perform_22_27_1() {
    EYETILT=${1:-12}
    AZI=${2:-20.0}
    EL=${3:-17.0}
    fix_point 1.5 $EL 0 $AZI $EYETILT 0 10
}

perform_22_27_2() {
    fix_point 1.5 -28.8956 -3.23077 22 -17.978 -0.346534 9.00014
    arm_sleeve 3.0 left_arm
    arm_sleeve 3.0 right_arm
}

perform_22_27_3() {
    EYETILT=${1:-12}
    AZI=${2:-20.0}
    EL=${3:-17.0}
    fix_point 1.5 $EL 0 $AZI $EYETILT 0 10
    sleep 0.75
    #emotion "neu" "sur"
}

perform_22_29() {
    TARM=${1:-3.0}
    ARM=${2:-left_arm}
    AZI=${3:-20.0}
    EYETILT=${4:-0}
    EL=${5:-17.0}
    fix_point 1.5 $EL 0 $AZI $EYETILT 0 10
    point_face $TARM $ARM
    #sleep $TARM
    #speak "tob ia"
}

perform_22_30() {
    TARM=${1:-1.5}
    ARM=${2:-left_arm}
    AZI=${3:-20.0}
    EYETILT=${4:-0}
    EL=${5:-0.0}
    fix_point 1.5 $EL 0 $AZI $EYETILT 0 10
    #sad
    #caress $ARM
    caress_elbow $TARM $ARM
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

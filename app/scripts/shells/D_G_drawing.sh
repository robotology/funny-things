#!/bin/bash
#######################################################################################
# FLATWOKEN ICON THEME CONFIGURATION SCRIPT
# Copyright: (C) 2014 FlatWoken icons
# Author:  Alessandro Roncone
# email:   alecive87@gmail.com
# Permission is granted to copy, distribute, and/or modify this program
# under the terms of the GNU General Public License, version 2 or any
# later version published by the Free Software Foundation.
#  *
# A copy of the license can be found at
# http://www.robotcub.org/icub/license/gpl.txt
#  *
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details
#######################################################################################


#######################################################################################
# HELP
#######################################################################################
usage() {
cat << EOF
***************************************************************************************
DEA SCRIPTING
Author:  Vadim Tikhanoff   <vadim.tikhanoff@iit.it>
         Valentina Vasco   <valentina.vasco@iit.it>

This script scripts through the commands available for the DeA Kids videos.

USAGE:
        $0 options

***************************************************************************************
OPTIONS:

***************************************************************************************
EXAMPLE USAGE:

***************************************************************************************
EOF
}

HAND=${2:-right}
OFFSET=${3:-0.0}

AX_LEFT=0.0
AY_LEFT=-0.2
AZ_LEFT=0.8
THETA_LEFT=3.14152

#######################################################################################
# HELPER FUNCTIONS
#######################################################################################
gaze() {
    echo "$1" | yarp write ... /gaze
}

speak() {
    echo "\"$1\"" | yarp write ... /iSpeak &&  echo "\"$1\"" | yarp write ... /googleSynthesis/text:i
}

blink() {
    echo "blink" | yarp rpc /iCubBlinker/rpc
    sleep 0.5
}

breathers() {
    # echo "$1"  | yarp rpc /iCubBlinker/rpc
    # echo "$1" | yarp rpc /iCubBreatherH/rpc:i
    echo "$1" | yarp rpc /iCubBreatherRA/rpc:i
    sleep 0.4
    echo "$1" | yarp rpc /iCubBreatherLA/rpc:i
}

breathersL() {
   echo "$1" | yarp rpc /iCubBreatherLA/rpc:i
}

breathersR() {
   echo "$1" | yarp rpc /iCubBreatherRA/rpc:i
}

stop_breathers() {
    breathers "stop"
}

start_breathers() {
    breathers "start"
}

go__helperL() {
    # This is with the arms close to the legs
     echo "ctpq time $1 off 0 pos (-24.7695	17.9352	0.203248	29.11	18	0	-0.0439454	15.3864	29.8334	1.95557	11.7389	0.351563	7.43227	2.46644	1.06018	2.38404	)" | yarp rpc /ctpservice/left_arm/rpc
}

go__helperR() {
    # This is with the arms close to the legs
     echo "ctpq time $1 off 0 pos (-21.7 24.1535 23.5987	28.1361	-6.7912	0	-4.42201	18.1385	28.9106	0	5.46571	0.373536	1.66993	0.379029	0	-0.422975	)" | yarp rpc /ctpservice/right_arm/rpc
}

go__helper() {
    go__helperR $1
    go__helperL $1
}

go_() {
    #breathers "stop"
    sleep 1.0
    go__helper 2.0
    sleep 3.0
    #breathers "start"
}

greet_with_right_thumb_up() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_
    breathers "start"
}

greet_with_left_thumb_up() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_
    breathers "start"
}

smile() {
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}

surprised() {
    echo "set mou sur" | yarp rpc /icub/face/emotions/in
    echo "set leb sur" | yarp rpc /icub/face/emotions/in
    echo "set reb sur" | yarp rpc /icub/face/emotions/in
}

sad() {
    echo "set mou sad" | yarp rpc /icub/face/emotions/in
    echo "set leb sad" | yarp rpc /icub/face/emotions/in
    echo "set reb sad" | yarp rpc /icub/face/emotions/in
}

cun() {
    echo "set reb cun" | yarp rpc /icub/face/emotions/in
    echo "set leb cun" | yarp rpc /icub/face/emotions/in
}

angry() {
    echo "set all ang" | yarp rpc /icub/face/emotions/in
}

evil() {
    echo "set all evi" | yarp rpc /icub/face/emotions/in
}

wait_till_quiet() {
    sleep 0.3
    isSpeaking=$(echo "stat" | yarp rpc /iSpeak/rpc)
    while [ "$isSpeaking" == "Response: speaking" ]; do
        isSpeaking=$(echo "stat" | yarp rpc /iSpeak/rpc)
        sleep 0.1
        # echo $isSpeaking
    done
    echo "I'm not speaking any more :)"
    echo $isSpeaking
}

victory() {
    echo "ctpq time 1.0 off 7 pos                                       (18.0 40.0 50.0 167.0 0.0 0.0 0.0 0.0 222.0)" | yarp rpc /ctpservice/$1/rpc
    echo "ctpq time 2.0 off 0 pos (-57.0 32.0 -1.0 88.0 56.0 -30.0 -11.0 18.0 40.0 50.0 167.0 0.0 0.0 0.0 0.0 222.0)" | yarp rpc /ctpservice/$1/rpc
}

point_eye() {
    echo "ctpq time 2 off 0 pos (-50.0 33.0 45.0 95.0 -58.0 24.0 -11.0 10.0 28.0 11.0 78.0 32.0 15.0 60.0 130.0 170.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0 && blink && blink
    go_
}

point_ears() {
    breathers "stop"

    echo "ctpq time 1 off 0 pos (-10.0 8.0 -37.0 7.0 -21.0 1.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 2 off 0 pos (-18.0 59.0 -30.0 105.0 -22.0 28.0 -6.0 6.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0

    echo "ctpq time 2 off 0 pos (-10.0 -8.0 37.0 7.0 -21.0 1.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 2 off 0 pos (-18.0 59.0 -30.0 105.0 -22.0 28.0 -6.0 6.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/right_arm/rpc

    echo "ctpq time 2 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    go__helperL 2.0
    go__helperR 2.0

    breathers "start"
}

point_arms() {
    breathers "stop"

    echo "ctpq time 2 off 0 pos (-60.0 32.0 80.0 85.0 -13.0 -3.0 -8.0 15.0 37.0 47.0 52.0 9.0 1.0 42.0 106.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2 off 0 pos (-64.0 43.0 6.0 52.0 -28.0 -0.0 -7.0 15.0 30.0 7.0 0.0 4.0 0.0 2.0 8.0 43.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    go__helperL 2.0
    go__helperR 2.0

    breathers "start"
}

fonzie() {
    echo "ctpq time 2.0 off 0 pos ( -3.0 57.0   3.0 106.0 -9.0 -8.0 -10.0 22.0 0.0 0.0 20.0 62.0 146.0 90.0 130.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2.0 off 0 pos ( -3.0 57.0   3.0 106.0 -9.0 -8.0 -10.0 22.0 0.0 0.0 20.0 62.0 146.0 90.0 130.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.5
    go__helper 2.0
}

hello_left() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    go_ 2.0
    smile
}

hello_left_simple() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    sleep 2.0
    go__helperL 2.0
    smile
}

hello_right_simple() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile
    sleep 2.0
    go__helperR 2.0
    smile
}

hello_right() {
    #breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile
    go_
    smile
    #breathers "start"
}

hello_both() {
    #breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0

    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc

    smile
    go__helper 2.0
    smile
    #breathers "start"
}

show_musles() {
    #breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    smile
    go__helper 2.0
    breathers "start"
}

show_musles_left() {
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    smile
    go__helperL 2.0
}

show_iit() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-27.0 64.0 -30.0 62.0 -58.0 -32.0 4.0 17.0 11.0 21.0 29.0 8.0 9.0 5.0 11.0 1.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-27.0 64.0 -30.0 62.0 -58.0 -32.0 4.0 17.0 11.0 21.0 29.0 8.0 9.0 5.0 11.0 1.0)" | yarp rpc /ctpservice/left_arm/rpc

    sleep 3.0
    smile

    go_
    breathers "start"
}

talk_mic() {
    #breathers "stop"
    sleep 1.0
    echo "ctpq time $1 off 0 pos (-47.582418 37.967033 62.062198 107.868132 -32.921661 -12.791209 -0.571429 0.696953 44.352648 14.550271 86.091537 52.4 64.79118 65.749353 62.754529 130.184865)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    #breathers "start"
}

draw() {
   echo "Drawing with an offset of $OFFSET"
   echo "Reaching target $1 $2 $(bc <<< "$3+$OFFSET") $4 $5 $6 $7"

    if [ "$HAND" = "right" ]; then
        echo "$1 $2 $(bc <<< "$3+$OFFSET") $4 $5 $6 $7" | yarp write ...  /armCtrl/right_arm/xd:i
    else if [ "$HAND" = "left" ]; then
        echo "$1 $2 $(bc <<< "$3+$OFFSET") $4 $5 $6 $7" | yarp write ...  /armCtrl/left_arm/xd:i
    fi
    fi  
}

start_draw() {
   if [ "$HAND" = "right" ]; then
        echo "$1 $2 $3 $4 $5 $6 $7" | yarp write ...  /armCtrl/right_arm/xd:i
    else if [ "$HAND" = "left" ]; then
        echo "$1 $2 $3 $4 $5 $6 $7" | yarp write ...  /armCtrl/left_arm/xd:i
    fi
    fi
}

torso_low(){
    echo "ctpq time 2 off 0 pos (-4.32862 1.23047 33.4864)" | yarp rpc /ctpservice/torso/rpc
}

torso_high(){
    echo "ctpq time 2 off 0 pos (-4.32862 1.23047 22.3243)" | yarp rpc /ctpservice/torso/rpc
}

torso_right(){
    echo "ctpq time 2 off 0 pos (13.9527 1.23047 32.4122)" | yarp rpc /ctpservice/torso/rpc
}

torso_left(){
    echo "ctpq time 2 off 0 pos (-13.9527 1.23047 32.4122)" | yarp rpc /ctpservice/torso/rpc
}

torso_home(){
    echo "ctpq time 2 off 0 pos (0 0 0 )" | yarp rpc /ctpservice/torso/rpc
}

left_arm_low(){
    #echo "ctpq time 1.5 off 0 pos (-3.90016 69.0492 -7.45974 54.3715 4.0265 -4.30665 -8.87697 13.1232 29.6027 -0.357057 1.62049 0 2.21375 0 0 0.900881)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-22.7 27.19 3.3 76.3715 50.0265 -15.30665 -10.87697 13.1232 15.6027 -0.357057 1.62049 0 2.21375 0 0 0.900881)" | yarp rpc /ctpservice/left_arm/rpc
}

left_arm_low_right(){
    #echo "ctpq time 1.5 off 0 pos (-3.90016 69.0492 -7.45974 54.3715 4.0265 -4.30665 -8.87697 13.1232 29.6027 -0.357057 1.62049 0 2.21375 0 0 0.900881)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-22.7 27.19 -17.3 76.3715 50.0265 -15.30665 -10.87697 13.1232 15.6027 -0.357057 1.62049 0 2.21375 0 0 0.900881)" | yarp rpc /ctpservice/left_arm/rpc
}

left_arm_high(){
    echo "ctpq time 2.0 off 0 pos (-22.7 27.19 3.3 58.3715 50.0265 -15.30665 -10.87697 13.1232 15.6027 -0.357057 1.62049 0 2.21375 0 0 0.900881)" | yarp rpc /ctpservice/left_arm/rpc
}

left_arm_right(){
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
}

set_up_right_arm(){
    echo "ctpq time 1.5 off 7 pos (23.3295 30.7783 1.06519 53.8881 49.0925 58.8869 45.9779 83.2985 140.312)" | yarp rpc /ctpservice/right_arm/rpc
}

open_right_hand() {
    echo "ctpq time 2.0 off 7 pos (20.0 30.0 0.0 1.0 1.0 1.0 1.0 1.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

right_arm_home(){
   draw -0.282108698046593331377 0.181726082363135865716 0.0254698106007657451566 -0.0243652369835574283963 -0.867441689747252331344 0.496941898128107961696 3.11038776267348771043
}

set_up_left_arm(){
    echo "ctpq time 1.5 off 7 pos (23.3295 30.7783 -3.06519 53.8881 49.0925 58.8869 45.9779 83.2985 140.312)" | yarp rpc /ctpservice/left_arm/rpc
    
    #with the glove
    #echo "ctpq time 1.5 off 8 pos (9.80532 0 139.999 47.7522 132.133 76.9429 109.127 270.001)" | yarp rpc /ctpservice/left_arm/rpc
}

open_left_hand() {
    echo "ctpq time 2.0 off 7 pos (20.0 35.0 17.0 1.0 1.0 1.0 1.0 1.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

left_arm_home(){
   draw -0.282108698046593331377 -0.181726082363135865716 0.0254698106007657451566 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
}

right_arm_low(){
    echo "ctpq time 1.5 off 0 pos (-3.90016 69.0492 -7.45974 54.3715 4.0265 -4.30665 -8.87697 13.1232 29.6027 -0.357057 1.62049 0 2.21375 0 0 0.900881)" | yarp rpc /ctpservice/right_arm/rpc
}

#######################################################################################
# SEQUENCE FUNCTIONS
#######################################################################################
set_up_hand() {
    if [ "$HAND" = "right" ]; then
        echo "Using right hand"
        set_up_right_arm
    else if [ "$HAND" = "left" ]; then
        echo "Using left hand"
        set_up_left_arm
    fi
    fi    
}

prepare() {
    torso_high
    if [ "$HAND" = "right" ]; then
        left_arm_low
    else if [ "$HAND" = "left" ]; then
        right_arm_low
    fi
    fi
    raise_up
}

start_part_1() {

    X=-0.312099692973232367699
    Y=0.0323477147963253594543
    Z=-0.0159028330966882788799
    AX=-0.293717864467345990409
    AY=0.86283731061040169763
    AZ=-0.411389829129684136966
    THETA=2.57931818061652062823
    if [ "$HAND" = "left" ]; then
        Y=$(bc <<< "$Y*-1.0")
        AX=$AX_LEFT
        AY=$AY_LEFT
        AZ=$AZ_LEFT
        THETA=$THETA_LEFT
    fi
    start_draw $X $Y $Z $AX $AY $AZ $THETA
    sleep 1.0
    echo "ctpq time 2 off 0 pos (-25.0 0.0 -5.0 -15.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    torso_low
    left_arm_low
}

calib_table()
{
    draw -0.312099692973232367699 0.0323477147963253594543 -0.0629028330966882788799 -0.293717864467345990409 0.86283731061040169763 -0.411389829129684136966 2.57931818061652062823
}

part_1() {
    
    if [ "$HAND" = "right" ]; then
        #high left arm drawing
        echo "ctpq time 10 off 0 pos (-15.0 0.0 -11.0 -10.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc

        draw -0.312099692973232367699 0.0323477147963253594543 -0.0629028330966882788799 -0.293717864467345990409 0.86283731061040169763 -0.411389829129684136966 2.57931818061652062823
        sleep 2.0

        #left shoulder drawing
        draw -0.355636830985369190028 0.0388126252091117590615 -0.0631642155600774081181 -0.162058245455364124954 0.88017887051037080326 -0.446119133177469373575 2.60579612694132656259
        sleep 2.0

        #go down left  neck / shoulder drawing
        draw -0.353578938749672666564 0.0733265228440144745115 -0.069040502935731338785 -0.139080462476080801704 0.864773202310446520436 -0.482518324546513943663 2.60992081676853482364
        sleep 2.0

        #left  neck / face drawing
        draw -0.386334435421571142921 0.0753170618625696063342 -0.0600025084774475305771 -0.0558197697426994418612 0.889354215875829745563 -0.453798669025990086823 2.6823552766618048437
        sleep 2.0

        #up face face drawing
        draw -0.386334435421571142921 0.0753170618625696063342 -0.040025084774475305771 -0.0558197697426994418612 0.889354215875829745563 -0.453798669025990086823 2.68235527666180484374
    
    else if [ "$HAND" = "left" ]; then
        #high left arm drawing
        draw -0.312099692973232367699 -0.0323477147963253594543 -0.0629028330966882788799 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        #left shoulder drawing
        draw -0.355636830985369190028 -0.0388126252091117590615 -0.0631642155600774081181 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        #go down left  neck / shoulder drawing
        draw -0.353578938749672666564 -0.0733265228440144745115 -0.069040502935731338785 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        #left  neck / face drawing
        draw -0.386334435421571142921 -0.0753170618625696063342 -0.0600025084774475305771 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        #up face face drawing
        draw -0.386334435421571142921 -0.0753170618625696063342 -0.040025084774475305771 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
    fi
    fi

}

start_part_2() {
    X=-0.325723724067253908032
    Y=0.061830599363296217863
    Z=-0.0253764683221865031681
    AX=-0.0846392633486617862459 
    AY=0.850400373120677621763
    AZ=-0.519283545373823929303
    THETA=2.80263529378769327138
    if [ "$HAND" = "left" ]; then
        Y=$(bc <<< "$Y*-1.0")
        AX=$AX_LEFT
        AY=$AY_LEFT
        AZ=$AZ_LEFT
        THETA=$THETA_LEFT
    fi
    echo "ctpq time 2 off 0 pos (-25.0 0.0 -11.0 -15.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    torso_high
    left_arm_high
    start_draw $X $Y $Z $AX $AY $AZ $THETA
}

part_2() {

    if [ "$HAND" = "right" ]; then
        #low left side drawing

        echo "ctpq time 10 off 0 pos (-30.0 0.0 -11.0 -25.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc

        draw -0.325723724067253908032 0.061830599363296217863 -0.0753764683221865031681 -0.0846392633486617862459 0.850400373120677621763 -0.519283545373823929303 2.80263529378769327138
        sleep 2.0

        #left hip drawing
        draw -0.289944036071337554183 0.0851777355197631902417 -0.0759953769297628758395 -0.10751963389291122053 0.839232379285349883169 -0.533037092411574375816 2.54682985772410441783
        sleep 2.0

        draw -0.275501647220710739195 0.0640503941659466184411 -0.0757591226418964505118 -0.201684637552583395648 0.85687107052205269131 -0.474442067567447556264 2.57722785711047386314
        sleep 2.0

        draw -0.210324055274786971825 0.0726375747705533834075 -0.0732430696781040821985 -0.331076573016411412897 0.839284378792964691485 -0.431265619211427697621 2.33134272817010890222
        sleep 2.0
    
        draw -0.210324055274786971825 0.0726375747705533834075 -0.0192430696781040821985 -0.331076573016411412897 0.839284378792964691485 -0.431265619211427697621 2.33134272817010890222
    else if [ "$HAND" = "left" ]; then
        draw -0.325723724067253908032 -0.061830599363296217863 -0.0753764683221865031681 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        #left hip drawing
        draw -0.289944036071337554183 -0.0851777355197631902417 -0.0759953769297628758395 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        draw -0.275501647220710739195 -0.0640503941659466184411 -0.0757591226418964505118 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        draw -0.210324055274786971825 -0.0726375747705533834075 -0.0732430696781040821985 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0
    
        draw -0.210324055274786971825 -0.0726375747705533834075 -0.0192430696781040821985 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
    fi
    fi
}

start_part_3() {
    X=-0.315723724067253908032
    Y=0.11
    Z=-0.0192430696781040821985
    AX=-0.0846392633486617862459
    AY=0.850400373120677621763
    AZ=-0.519283545373823929303
    THETA=2.80263529378769327138
    if [ "$HAND" = "left" ]; then
        Y=$(bc <<< "$Y*-1.0")
        AX=$AX_LEFT
        AY=$AY_LEFT
        AZ=$AZ_LEFT
        THETA=$THETA_LEFT
    fi
    
    start_draw $X $Y $Z $AX $AY $AZ $THETA
    sleep 1.0

    echo "ctpq time 2 off 0 pos (-25.0 0.0 -0.0 -15.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc

    if [ "$HAND" = "right" ]; then
        torso_right
        left_arm_low_right
    else if [ "$HAND" = "left" ]; then
        torso_left
    fi
    fi
}

part_3() {

    echo "ctpq time 10 off 0 pos (-30.0 0.0 -0.0 -25.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    if [ "$HAND" = "right" ]; then
        draw -0.315723724067253908032 0.11 -0.0733764683221865031681 -0.0846392633486617862459 0.850400373120677621763 -0.519283545373823929303 2.80263529378769327138
        sleep 2.0
     
        draw -0.2823724067253908032 0.10 -0.0733764683221865031681 -0.0846392633486617862459 0.850400373120677621763 -0.519283545373823929303 2.80263529378769327138
        sleep 2.0 
    
        draw -0.2653724067253908032 0.115 -0.0713764683221865031681 -0.0846392633486617862459 0.850400373120677621763 -0.519283545373823929303 2.80263529378769327138
        sleep 2.0
         
        draw -0.2023250129427876709 0.118728067975726200523 -0.0796862721934695412696 -0.00496676038412719334653 0.774492962781589078247 -0.632563026024350216758 2.56487352093593168334
        sleep 3.0

        draw -0.2023250129427876709 0.118728067975726200523 -0.0236862721934695412696 -0.00496676038412719334653 0.774492962781589078247 -0.632563026024350216758 2.56487352093593168334
    else if [ "$HAND" = "left" ]; then
        draw -0.315723724067253908032 -0.11 -0.0733764683221865031681 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0
     
        draw -0.2823724067253908032 -0.10 -0.0733764683221865031681 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0 
    
        draw -0.2653724067253908032 -0.115 -0.0713764683221865031681 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0
         
        draw -0.2023250129427876709 -0.118728067975726200523 -0.0796862721934695412696 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 3.0

        draw -0.2023250129427876709 -0.118728067975726200523 -0.0236862721934695412696 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
    fi
    fi
}

start_part_4() {
    X=-0.353578938749672666564
    Y=0.0803265228440144745115
    Z=-0.023040502935731338785
    AX=-0.139080462476080801704
    AY=0.864773202310446520436
    AZ=-0.482518324546513943663
    THETA=2.60992081676853482364
    if [ "$HAND" = "left" ]; then
        Y=$(bc <<< "$Y*-1.0")
        AX=$AX_LEFT
        AY=$AY_LEFT
        AZ=$AZ_LEFT
        THETA=$THETA_LEFT
    fi
    echo "ctpq time 2 off 0 pos (-25.0 0.0 -11.0 -10.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    torso_high
    left_arm_high
    start_draw $X $Y $Z $AX $AY $AZ $THETA
}

part_4() {

     echo "ctpq time 6 off 0 pos (-30.0 0.0 -20.0 -25.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc

    if [ "$HAND" = "right" ]; then
        draw -0.350578938749672666564 0.0803265228440144745115 -0.069040502935731338785 -0.139080462476080801704 0.864773202310446520436 -0.482518324546513943663 2.60992081676853482364
        sleep 2.0
   
        draw -0.355263690567933779096 0.110372969207294786109 -0.0714483792852473856283 0.000476032722984540655753 0.899948998521016729768 -0.435994923656073951612 2.64223014371933695443
        sleep 2.0

        draw -0.252796728742653742383 0.148477115442454329575 -0.062648460877686668713 -0.0534217533651084874879 0.894491590600037245196 -0.443881640320043957537 2.61822271176086873723
        sleep 2.0

        draw -0.252796728742653742383 0.148477115442454329575 -0.019648460877686668713 -0.0534217533651084874879 0.894491590600037245196 -0.443881640320043957537 2.61822271176086873723
    else if [ "$HAND" = "left" ]; then
        draw -0.350578938749672666564 -0.0803265228440144745115 -0.069040502935731338785 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0
   
        draw -0.355263690567933779096 -0.110372969207294786109 -0.0714483792852473856283 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        draw -0.252796728742653742383 -0.148477115442454329575 -0.062648460877686668713 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        draw -0.252796728742653742383 -0.148477115442454329575 -0.019648460877686668713 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
    fi
    fi
}

start_part_5() {
    X=-0.313077938533828088463
    Y=0.0777121914641277429237
    Z=-0.0198548882212590064311
    AX=-0.169874296403569297054
    AY=0.808215152442865791826
    AZ=-0.563853696257413439241
    THETA=2.59245150059519691155
    if [ "$HAND" = "left" ]; then
        Y=$(bc <<< "$Y*-1.0")
        AX=$AX_LEFT
        AY=$AY_LEFT
        AZ=$AZ_LEFT
        THETA=$THETA_LEFT
    fi
    
    start_draw $X $Y $Z $AX $AY $AZ $THETA
    sleep 1.0
    
    echo "ctpq time 2 off 0 pos (-25.0 0.0 -11.0 -20.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc

    torso_low
    left_arm_low
}

part_5() {
    
     echo "ctpq time 5 off 0 pos (-25.0 0.0 -18.0 -20.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc

    if [ "$HAND" = "right" ]; then
        draw -0.313077938533828088463 0.0777121914641277429237 -0.0758548882212590064311 -0.169874296403569297054 0.808215152442865791826 -0.563853696257413439241 2.59245150059519691155
        sleep 2.0

        draw -0.306886776896212300603 0.127579528816639274136 -0.0788054075826516292613 -0.0406193229074667538914 0.812088367509156250357 -0.582119020444146206827 2.56000409079834900794
        sleep 2.0 

        draw -0.306886776896212300603 0.127579528816639274136 -0.0488054075826516292613 -0.0406193229074667538914 0.812088367509156250357 -0.582119020444146206827 2.56000409079834900794
    else if [ "$HAND" = "left" ]; then
        draw -0.313077938533828088463 -0.0777121914641277429237 -0.0758548882212590064311 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        draw -0.306886776896212300603 -0.127579528816639274136 -0.0788054075826516292613 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0 

        draw -0.306886776896212300603 -0.127579528816639274136 -0.0488054075826516292613 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
    fi
    fi
}

start_part_6() {
    X=-0.300077938533828088463
    Y=0.0827121914641277429237
    Z=-0.0258548882212590064311
    AX=-0.169874296403569297054
    AY=0.808215152442865791826
    AZ=-0.563853696257413439241
    THETA=2.59245150059519691155
    if [ "$HAND" = "left" ]; then
        Y=$(bc <<< "$Y*-1.0")
        AX=$AX_LEFT
        AY=$AY_LEFT
        AZ=$AZ_LEFT
        THETA=$THETA_LEFT
    fi
    start_draw $X $Y $Z $AX $AY $AZ $THETA
    sleep 1.0
    echo "ctpq time 2 off 0 pos (-25.0 0.0 -11.0 -20.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    torso_low
    left_arm_low
}

part_6() {
    echo "ctpq time 5 off 0 pos (-25.0 0.0 -18.0 -20.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    if [ "$HAND" = "right" ]; then
        draw -0.300077938533828088463 0.0827121914641277429237 -0.0758548882212590064311 -0.169874296403569297054 0.808215152442865791826 -0.563853696257413439241 2.59245150059519691155
        sleep 2.0

        draw -0.288886776896212300603 0.129579528816639274136 -0.0788054075826516292613 -0.0406193229074667538914 0.812088367509156250357 -0.582119020444146206827 2.56000409079834900794
        sleep 2.0

        draw -0.288886776896212300603 0.129579528816639274136 -0.0488054075826516292613 -0.0406193229074667538914 0.812088367509156250357 -0.582119020444146206827 2.56000409079834900794
    else if [ "$HAND" = "left" ]; then
        draw -0.300077938533828088463 -0.0827121914641277429237 -0.0758548882212590064311 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        draw -0.288886776896212300603 -0.129579528816639274136 -0.0788054075826516292613 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT
        sleep 2.0

        draw -0.288886776896212300603 -0.129579528816639274136 -0.0488054075826516292613 $AX_LEFT $AY_LEFT $AZ_LEFT $THETA_LEFT  
    fi
    fi
}

raise_up() {

    #draw -0.288886776896212300603 0.129579528816639274136 -0.0488054075826516292613 -0.0406193229074667538914 0.812088367509156250357 -0.582119020444146206827 2.56000409079834900794
  
    echo $HAND
    X=-0.288886776896212300603
    Y=0.205579528816639274136
    Z=-0.00208054075826516292613
    AX=-0.0406193229074667538914
    AY=0.812088367509156250357
    AZ=-0.582119020444146206827
    THETA=2.56000409079834900794
    if [ "$HAND" = "left" ]; then
        Y=$(bc <<< "$Y*-1.0")
        AX=$AX_LEFT
        AY=$AY_LEFT
        AZ=$AZ_LEFT
        THETA=$THETA_LEFT
    fi
    echo "ctpq time 3 off 0 pos (-25.0 0.0 -5.0 -18.0 -0.0 5.0)" | yarp rpc /ctpservice/head/rpc

    draw $X $Y $Z $AX $AY $AZ $THETA 
}

all_parts() {
    #1: set_up_hand => place pen in hand
    #2: prepare     => set up home position (before putting the robot drawing on the table)

    start_part_1
    sleep 3.0
    part_1
    sleep 3.0

    start_part_2
    sleep 3.0
    part_2
    sleep 3.0

    start_part_3
    sleep 2.0
    part_3
    sleep 2.0
    
    start_part_4
    sleep 2.0
    part_4
    sleep 2.0

    start_part_5
    sleep 2.0
    part_5
    sleep 2.0

    start_part_6
    sleep 2.0
    part_6
    sleep 2.0

    raise_up    
}


#######################################################################################
# "MAIN" FUNCTION:                                                                    #
#######################################################################################
echo "********************************************************************************"
echo ""

$1 $2 $3

if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi

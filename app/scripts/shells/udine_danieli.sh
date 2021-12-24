#!/bin/bash
#######################################################################################
# Copyright: (C) 2017
# Author:  Vadim Tikhanoff
# email:   vadim.tikhanoff@iit.it
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
Author:  Vadim Tikhanoff    <vadim.tikhanoff@iit.it>

This script scripts through the commands available for the event Danieli at Udine .

USAGE:
        $0 options

***************************************************************************************
OPTIONS:

***************************************************************************************
EXAMPLE USAGE:

***************************************************************************************
EOF
}

#######################################################################################
# HELPER FUNCTIONS
#######################################################################################
gaze() {
    echo "$1" | yarp write ... /gaze
}

speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}

blink() {
    echo "blink_single" | yarp rpc /iCubBlinker/rpc
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

go_home_helperL() {
    # This is with the arms over the table
    echo "ctpq time $1 off 0 pos (-12.0 24.0 23.0 64.0 -7.0 -5.0 10.0    12.0 -6.0 37.0 2.0 0.0 3.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    # This is with the arms close to the legs
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
}

go_home_helperR() {
    # This is with the arms over the table
    echo "ctpq time $1 off 0 pos (-15.0 23.0 22.0 48.0 13.0 -10.0 8.0    0.0 9.0 42.0 2.0 0.0 1.0 0.0 8.0 4.0)" | yarp rpc /ctpservice/right_arm/rpc
    # This is with the arms close to the legs
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
}

go_home_helper() {
    go_home_helperR $1
    go_home_helperL $1
}

go_home() {
    #breathers "stop"
    sleep 1.0
    go_home_helper 2.0
    sleep 3.0
    #breathers "start"
}

greet_with_right_thumb_up() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0      21.0 0.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home
    breathers "start"
}

greet_with_left_thumb_up() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0      21.0 0.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home
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

victory_both() {

    echo "ctpq time 1.0 off 7 pos                                       (18.0 40.0 50.0 167.0 0.0 0.0 0.0 0.0 222.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-57.0 32.0 -1.0 88.0 56.0 -30.0 -11.0 18.0 40.0 50.0 167.0 0.0 0.0 0.0 0.0 222.0)" | yarp rpc /ctpservice/left_arm/rpc

    echo "ctpq time 1.0 off 7 pos                                       (18.0 40.0 50.0 167.0 0.0 0.0 0.0 0.0 222.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-57.0 32.0 -1.0 88.0 56.0 -30.0 -11.0 18.0 40.0 50.0 167.0 0.0 0.0 0.0 0.0 222.0)" | yarp rpc /ctpservice/right_arm/rpc

    sleep 3.0
    go_home
}

point_eye() {
    echo "ctpq time 2 off 0 pos (-50.0 33.0 45.0 95.0 -58.0 24.0 -11.0 10.0 28.0 11.0 78.0 32.0 15.0 60.0 130.0 170.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0 && blink && blink
    go_home
}

point_ear_right() {
    echo "ctpq time 2 off 0 pos (-18.0 59.0 -30.0 105.0 -22.0 28.0 -6.0 6.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    go_home_helperR 2.0
}

point_ears() {
    breathers "stop"

    echo "ctpq time 1 off 0 pos (-10.0 8.0 -37.0 7.0 -21.0 1.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 2 off 0 pos (-18.0 59.0 -30.0 105.0 -22.0 28.0 -6.0 6.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0

    echo "ctpq time 2 off 0 pos (-10.0 -8.0 37.0 7.0 -21.0 1.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 2 off 0 pos (-18.0 59.0 -30.0 105.0 -22.0 28.0 -6.0 6.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/right_arm/rpc

    echo "ctpq time 2 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    go_home_helperL 2.0
    go_home_helperR 2.0

    breathers "start"
}

point_arms() {
    breathers "stop"

    echo "ctpq time 2 off 0 pos (-60.0 32.0 80.0 85.0 -13.0 -3.0 -8.0 15.0 37.0 47.0 52.0 9.0 1.0 42.0 106.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2 off 0 pos (-64.0 43.0 6.0 52.0 -28.0 -0.0 -7.0 15.0 30.0 7.0 0.0 4.0 0.0 2.0 8.0 43.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    go_home_helperL 2.0
    go_home_helperR 2.0

    breathers "start"
}

boh() {
    echo "ctpq time 1.0 off 0 pos ( -24.7962 39.5564 -18.3967 85.3255 -59.98 -43.4126 -13.4693 9.24502 9.89871 11.2995 0.0 0.0 2.86195 0.0 4.94386 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos ( -24.7962 39.5564 -18.3967 85.3255 -59.98 -43.4126 -13.4693 9.24502 9.89871 11.2995 0.0 0.0 2.86195 0.0 4.94386 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.0
    surprised
    sleep 1.0
    go_home_helper 2.0
}

fonzie() {
    echo "ctpq time 1.0 off 0 pos ( -3.0 57.0   3.0 106.0 -9.0 -8.0 -10.0 0.0 10.0 10.0 0.0 62.0 146.0 90.0 130.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos ( -3.0 57.0   3.0 106.0 -9.0 -8.0 -10.0 0.0 10.0 10.0 0.0 62.0 146.0 90.0 130.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.0
    smile
    sleep 1.0
    go_home_helper 2.0
}

fonzie_L() {
    echo "ctpq time 1.0 off 0 pos ( -3.0 57.0   3.0 106.0 -9.0 -8.0 -10.0 0.0 10.0 10.0 0.0 62.0 146.0 90.0 130.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
}

point_R() {
    echo "ctpq time 1.5 off 0 pos ( -95.2847 28.7458 7.44326 19.5832 59.9251 3.87269 3.84522 9.7449 9.86575 42.7095 52.3665 0.0 6.80055 47.8511 135.094 269.534)" | yarp rpc /ctpservice/right_arm/rpc
}

hello_left() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    go_home 2.0
    smile
}

hello_left_simple() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    sleep 2.0
    go_home_helperL 2.0
    smile
}

hello_right_simple() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile
    sleep 2.0
    go_home_helperR 2.0
    smile
}

interaction_right() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    go_home_helperR 2.0
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
    go_home
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
    go_home_helper 2.0
    smile
    #breathers "start"
}

show_muscles() {
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    smile
    go_home_helper 2.0
}

show_muscles_left() {
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    smile
    go_home_helperL 2.0
}

show_iit() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-27.0 64.0 -30.0 62.0 -58.0 -32.0 4.0 17.0 11.0 21.0 29.0 8.0 9.0 5.0 11.0 1.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-27.0 64.0 -30.0 62.0 -58.0 -32.0 4.0 17.0 11.0 21.0 29.0 8.0 9.0 5.0 11.0 1.0)" | yarp rpc /ctpservice/left_arm/rpc

    sleep 3.0
    smile

    go_home
    breathers "start"
}

show_agitation() {

    echo "ctpq time 1.0 off 0 pos (0.0 0.0 -12.0)" | yarp rpc /ctpservice/torso/rpc

    echo "bind pitch -10.0 0.0" | yarp rpc /iKinGazeCtrl/rpc
    sleep 0.2
    echo "bind roll 0.0 0.0" | yarp rpc /iKinGazeCtrl/rpc
    sleep 0.2
    echo "bind yaw 0.0 0.0" | yarp rpc /iKinGazeCtrl/rpc
    sleep 0.2

    gaze "look -30.0 0.0 5.0"
    sleep 1.5
    gaze "look 30.0 0.0 5.0"
    sleep 1.5
    gaze "look -30.0 0.0 5.0"
    sleep 1.5
    gaze "look 30.0 0.0 5.0"
    sleep 1.5

    echo "clear pitch" | yarp rpc /iKinGazeCtrl/rpc
    sleep 0.2
    echo "clear roll" | yarp rpc /iKinGazeCtrl/rpc
    sleep 0.2
    echo "clear yaw" | yarp rpc /iKinGazeCtrl/rpc
    sleep 0.2

    echo "ctpq time 1.0 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

question() {
    echo "ctpq time 1.5 off 0 pos (-39.0 37.0 -17.0 53.0 -47.0 14.0 -2.0 -1.0 8.0 45 3.4 2.4 2.2 0.0 6.8 17)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-39.0 37.0 -17.0 53.0 -47.0 14.0 -2.0 -1.0 8.0 45 3.4 2.4 2.2 0.0 6.8 17)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    go_home
}

question_left() {
    echo "ctpq time 1.5 off 0 pos (-39.0 37.0 -17.0 53.0 -47.0 14.0 -2.0 -1.0 8.0 45 3.4 2.4 2.2 0.0 6.8 17)" | yarp rpc /ctpservice/left_arm/rpc
    go_home_helperL 1.5
}

question_right() {
    echo "ctpq time 1.5 off 0 pos (-39.0 37.0 -17.0 53.0 -47.0 14.0 -2.0 -1.0 8.0 45 3.4 2.4 2.2 0.0 6.8 17)" | yarp rpc /ctpservice/right_arm/rpc
    go_home_helperR 1.5
}

talk_mic() {
    #breathers "stop"
    sleep 1.0
    echo "ctpq time $1 off 0 pos (-47.582418 37.967033 62.062198 107.868132 -32.921661 -12.791209 -0.571429 0.696953 44.352648 14.550271 86.091537 52.4 64.79118 65.749353 62.754529 130.184865)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    #breathers "start"
}

#######################################################################################
# SEQUENCE FUNCTIONS
#######################################################################################
sequence_01() {
    speak "Ma allora, visto che io sono uno dei robot piu avanzati al mondo, perche non usate quelli come me?"
    sleep 0.1
    boh
    sleep 3.0
    fonzie
    wait_till_quiet
    sleep 1.1
    speak "che differenza c'e? fra noi"
    sleep 0.5
    fonzie_L
    sleep 1.0
    wait_till_quiet
    echo "look ang (abs 10.0 20.0 3.0)" | yarp rpc /iKinGazeCtrl/rpc
    speak "e i robot industriali?"
    point_R
    wait_till_quiet
    go_home_helper 2.0
    echo "look ang (abs 0.0 0.0 5.0)" | yarp rpc /iKinGazeCtrl/rpc
}

sequence_02() {
    speak "Senti Corsini!"
    echo "ctpq time 1.2 off 0 pos (30.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "look ang (abs 60.0 0.0 3.0)" | yarp rpc /iKinGazeCtrl/rpc
    sleep 1.0
    wait_till_quiet

    speak "Adesso basta parole!"
    echo "ctpq time 1.0 off 0 pos (-35.6947 42.281 -14.7052 69.2415 60.0185 -29.35 -1.42823 8.74514 9.93166 39.886 0.0 0.0 1.78528 0.384522 4.94386 -0.46692)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    wait_till_quiet

    speak "Andiamo a lavorare assieme nel gioint lab appena creato"
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "look ang (abs 0.0 0.0 3.0)" | yarp rpc /iKinGazeCtrl/rpc
    echo "ctpq time 1.5 off 0 pos (-48.1752 17.8473 47.082 82.1615 -34.2005 9.58559 25.5543 14.4965 40.0 70.0 3.0 10.0 15.0 20.0 25.0 50.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    go_home_helper 2.0
    wait_till_quiet

    speak "dopo tanti anni che mi dici che sono ancora troppo immaturo, non vedo l'ora di andare in impianto, e farti vedere di cosa sono capace."
    sad
    echo "look ang (abs 0.0 -30.0 3.0)" | yarp rpc /iKinGazeCtrl/rpc
    echo "ctpq time 1.5 off 0 pos (-29.3665 24.0876 10.2558 101.937 -60.0459 25.1423 0.505372 30.4981 62.3201 0.0 5.09218 0.0 0.0 0.0 0.0 0.928347)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-29.3665 24.0876 10.2558 101.937 -60.0459 25.1423 0.505372 30.4981 62.3201 0.0 5.09218 0.0 0.0 0.0 0.0 0.928347)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    echo "look ang (abs 0.0 0.0 3.0)" | yarp rpc /iKinGazeCtrl/rpc
    smile
    go_home_helper 2.0
    sleep 3.0
    show_muscles

    wait_till_quiet
}


#######################################################################################
# "MAIN" FUNCTION:                                                                    #
#######################################################################################
echo "********************************************************************************"
echo ""

$1 "$2"

if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi

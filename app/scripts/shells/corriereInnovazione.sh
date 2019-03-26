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
Author:  Alessandro Roncone   <alessandro.roncone@iit.it>

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
    echo "blink" | yarp rpc /iCubBlinker/rpc
    sleep 0.5
}

dblink() {
    echo "dblink" | yarp rpc /iCubBlinker/rpc
    sleep 0.5
}

## TODO: extend to torso (assuming legs are not moving) and modif the home positons

go_home_helper_yoga() {
    # This is for putting the robot in the Yoga home position
    echo "ctpq time $1 off 0 pos (-35.0 30.0 0.0 50.0 0.0 0.0 0.0 0.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $1 off 0 pos (-35.0 30.0 0.0 50.0 0.0 0.0 0.0 0.0 29.0 0.0 0.0 0.0 20.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

go_home_helper_walking() {
    # This is for putting the robot in the walking home position
    echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0  0.0 0.0 0.0 0.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0  0.0 0.0 0.0 0.0 29.0 0.0 0.0 0.0 20.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

go_home_yoga() {
    sleep 1.0
    go_home_helper_yoga 2.0
}

go_home_walking() {
    sleep 1.0
    go_home_helper_walking 2.0
}

handshake_home() {
    echo "ctpq time 1.5 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
}

handshake() {
    echo "ctpq time 1.5 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    echo "ctpq time 0.4 off 0 pos (-44.0 26.0 17.0 54.0 -4.0 -39.0 25.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-44.0 26.0 17.0 54.0 -4.0 -39.0 25.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-44.0 26.0 17.0 54.0 -4.0 -39.0 25.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
}

handshake_open() {
    echo "ctpq time 1.5 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    echo "ctpq time 0.4 off 0 pos (-44.0 26.0 17.0 54.0 -4.0 -39.0 25.0 30.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-44.0 26.0 17.0 54.0 -4.0 -39.0 25.0 30.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-44.0 26.0 17.0 54.0 -4.0 -39.0 25.0 30.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.4 off 0 pos (-42.0 26.0 17.0 44.0 -4.0 -39.0 35.0 30.0 29.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
}

handshake_new_home() {
    echo "ctpq time 1.5 off 0 pos (-61.0 23.0 17.0 65.0  0.0  -1.9 15.0 30.0 26.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
}

handshake_new() {
    echo "ctpq time 1.5 off 0 pos (-61.0 23.0 17.0 65.0  0.0  -1.9 15.0 30.0 26.0 14.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 65.0  0.0  -1.9 15.0 30.0 26.0 14.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 50.0  0.0  -1.9 15.0 30.0 26.0 14.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 65.0  0.0  -1.9 15.0 30.0 26.0 14.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 50.0  0.0  -1.9 15.0 30.0 26.0 14.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 65.0  0.0  -1.9 15.0 30.0 26.0 14.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 50.0  0.0  -1.9 15.0 30.0 26.0 14.0 30.0 32.0 42.0 50.0 50.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
}

handshake_new_open() {
    echo "ctpq time 1.5 off 0 pos (-61.0 23.0 17.0 65.0  0.0  -1.9 15.0 30.0 26.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 65.0  0.0  -1.9 15.0 30.0 26.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 50.0  0.0  -1.9 15.0 30.0 26.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 65.0  0.0  -1.9 15.0 30.0 26.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 50.0  0.0  -1.9 15.0 30.0 26.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 65.0  0.0  -1.9 15.0 30.0 26.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-61.0 23.0 17.0 50.0  0.0  -1.9 15.0 30.0 26.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
}

##############################

greet_with_right_thumb_up() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home
    breathers "start"
}

greet_with_left_thumb_up() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/left_arm/rpc
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

point_eye() {
    echo "ctpq time 2 off 0 pos (-50.0 33.0 45.0 95.0 -58.0 24.0 -11.0 10.0 28.0 11.0 78.0 32.0 15.0 60.0 130.0 170.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0 && blink && blink
    go_home
}

point_ears() {

    echo "ctpq time 1 off 0 pos (-10.0 8.0 -37.0 7.0 -21.0 1.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 2 off 0 pos (-18.0 59.0 -30.0 105.0 -22.0 28.0 -6.0 6.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0

    echo "ctpq time 2 off 0 pos (-10.0 -8.0 37.0 7.0 -21.0 1.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 2 off 0 pos (-18.0 59.0 -30.0 105.0 -22.0 28.0 -6.0 6.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/right_arm/rpc

    echo "ctpq time 2 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    go_home_helperL 2.0
    go_home_helperR 2.0

}

point_arms() {

    echo "ctpq time 2 off 0 pos (-60.0 32.0 80.0 85.0 -13.0 -3.0 -8.0 15.0 37.0 47.0 52.0 9.0 1.0 42.0 106.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2 off 0 pos (-64.0 43.0 6.0 52.0 -28.0 -0.0 -7.0 15.0 30.0 7.0 0.0 4.0 0.0 2.0 8.0 43.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    go_home_helperL 2.0
    go_home_helperR 2.0

}

fonzie() {
    echo "ctpq time 1.0 off 0 pos ( -3.0 57.0   3.0 106.0 -9.0 -8.0 -10.0 22.0 0.0 0.0 20.0 62.0 146.0 90.0 130.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos ( -3.0 57.0   3.0 106.0 -9.0 -8.0 -10.0 22.0 0.0 0.0 20.0 62.0 146.0 90.0 130.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    smile
    go_home_helperL 1.5
}

hello_left() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
}

hello_left_simple() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    sleep 2.0
    go_home_helperL 2.0
    smile
}

hello_right() {

    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile
    go_home
    smile
}

hello_both() {

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
    echo "ctpq time 1.5 off 0 pos (-27.0 64.0 -30.0 62.0 -58.0 -32.0 4.0 17.0 11.0 21.0 29.0 8.0 9.0 5.0 11.0 1.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-27.0 64.0 -30.0 62.0 -58.0 -32.0 4.0 17.0 11.0 21.0 29.0 8.0 9.0 5.0 11.0 1.0)" | yarp rpc /ctpservice/left_arm/rpc

    sleep 3.0
    smile
}

talk_mic() {
    sleep 1.0
    echo "ctpq time $1 off 0 pos (-47.582418 37.967033 62.062198 107.868132 -32.921661 -12.791209 -0.571429 0.696953 44.352648 14.550271 86.091537 52.4 64.79118 65.749353 62.754529 130.184865)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
}

urbi_et_orbi(){
    smile
    sleep 1.0
    echo "ctpq time 2.0 off 0 pos (-76.087912 18.0 41.54022 79.989011 -3.194914 -12.263736 5.846154 27.349497 26.770445 25.996681 25.79368 0.4 22.865714 16.888222 8.569178 147.786317)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time 1.0 off 0 pos (-44.967033 28.285714 60.441319 89.307692 -11.570818 -38.021978 -15.516484 27.065163 26.882944 26.516972 25.43044 -0.4 21.312919 18.725107 8.94287 146.865506)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time 1.0 off 0 pos (-59.56044 16.065934 57.716044 76.120879 -4.65387 -15.252747 -12.615385 27.349497 27.332938 24.956098 26.15692 -0.4 22.089317 16.520845 8.569178 147.325912)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time 1.0 off 0 pos (-36.967033 52.197802 26.507253 99.769231 -18.671728 -33.098901 -20.263736 27.349497 27.332938 22.354641 25.43044 0.8 21.701118 17.990353 8.94287 147.325912)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    evil
    go_home_helperR 2.0

}

show_director_left() {
    echo "ctpq time 2 off 0 pos (-60.0 32.0 80.0 85.0 -59.0 -3.0 -8.0 15.0 37.0 7.0 0.0 4.0 0.0 2.0 8.0 43.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2 off 0 pos (-64.0 43.0 6.0 52.0 -28.0 -0.0 -7.0 15.0 30.0 7.0 0.0 4.0 0.0 2.0 8.0 43.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    go_home_helperL 2.0
    go_home_helperR 2.0
    sleep 3.0
    smile
}

show_director_right() {
    echo "ctpq time 2 off 0 pos (-60.0 32.0 80.0 85.0 -59.0 -3.0 -8.0 15.0 37.0 7.0 0.0 4.0 0.0 2.0 8.0 43.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2 off 0 pos (-64.0 43.0 6.0 52.0 -28.0 -0.0 -7.0 15.0 30.0 7.0 0.0 4.0 0.0 2.0 8.0 43.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    go_home_helperL 2.0
    go_home_helperR 2.0
    sleep 3.0
    smile
}

## Trento
hello_left_chair() {
    echo "ctpq time 1.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 74.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 74.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 74.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/left_arm/rpc
    smile
}

home_chair() {
    echo "ctpq time 1.5 off 0 pos (-25 59.0 53.9 32.7 0.0 0.0 0.0 25.92 30.01 9.90 3.60 7.85 1.81 9.89 1.80 10.79 )" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    smile
}

point_director_chair() {
    echo "ctpq time 1.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    smile
}

hello_right_chair() {
    echo "ctpq time 1.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 74.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 74.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 74.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/right_arm/rpc
    smile
}

home_chair_right() {
    echo "ctpq time 1.5 off 0 pos (-25 59.0 53.9 32.7 0.0 0.0 0.0 25.92 30.01 9.90 3.60 7.85 1.81 9.89 1.80 10.79 )" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    smile
}

point_director_chair_right() {
    echo "ctpq time 1.5 off 0 pos (-72.4 67.2 -1.2 57.32 0.0 0.0 0.0 23.50 30.4 9.9 3.6 0.0 0.0 9.9 0.0 10.8)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    smile
}

nod_yes_once() {
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-10.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
}

nod_yes_mult() {
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-10.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-10.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-10.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
}

nod_no_once() {
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -6.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0  6.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
}

nod_no_mult() {
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -6.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0  6.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -6.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0  6.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -6.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0  6.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1 off 0 pos (-0.0 0.0 -0.0 0.0 -0.0 0.0)" | yarp rpc /ctpservice/head/rpc
}

#######################################################################################
# TRENTO SEQUENCES
#######################################################################################
###### Day 31/05
seq_01() {
    speak "Buona sera Tito!" && hello_left
    sleep 1.0 && blink
    go_home_walking
    speak "È un piacere essere qui per ascoltarvi e seguire l'intervento del Professor Fri mam."
    wait_till_quiet
		dblink
}

seq_02() {
    speak "Mi chiamo aicab!"
    speak "Piacere di conoscervi!" 
    sleep 1.0 && blink && hello_both
    wait_till_quiet
    go_home_walking
		dblink
}

seq_03() {
    speak "Sono il robot umanoide avanzato più diffuso al mondo, mi hanno progettato e sviluppato all’istituto itali áno di tecnologia di Geen ova!"
    sleep 1.0 && blink
}

seq_04() {
    speak "Sono unico al mondo grazie a tanti ricercatori internazionali!"
    sleep 1.0 && blink
}

seq_05() {
    speak "Ho 40 fratelli, distribuiti in tutto il Mondo, e attualmente ci sono più di 30 laboratori tra Europa, Stati Uniti e Giappone, che li usano per implementare i loro studi sull’intelligenza artificiale e la robotica umanoide."
    sleep 1.0 && blink
    wait_till_quiet
		dblink
}

seq_06() {
    speak "Proprio come voi, imparo dalle esperienze. Riconosco gli oggetti e li so afferrare, riesco a parlare con te,  so mantenere l’equilibrio, sto imparando a camminare, e sono dotato di una pelle sensibile che mi permette di sentire se vengo toccato o spinto. "
    sleep 1.0 && blink
    wait_till_quiet
		dblink
}

seq_07() {
    speak "Noo, sono stato progettato per affiancarvi e aiutarvi nei lavori domestici, o in altre attività delicate per cui avrete bisogno di supporto, come per esempio l'assistenza degli anziani e i disabili."
    sleep 1.0 && dblink
}

seq_08() {
    speak "Inoltre, la ricerca di base che i ricercatori dell’IIT fanno su di me, contribuisce allo sviluppo tecnologico di altri settori della ricerca robotica, come quella riabilitativa e biomedica."
    sleep 1.0 && blink
    wait_till_quiet
		dblink
}

seq_09() {
    speak "Sii! Domani pomeriggio alle tre sarò nuovamente qui insieme a Roberto Cingolani, il direttore Scientifico dell'istituto itali áno di tecnologia! Per il resto del tempo, potete trovarmi in piazza battisti, con alcuni ricercatori di i i t!"
    sleep 1.0 && blink
    wait_till_quiet
		dblink
}

seq_10() {
    speak "Grazie a voi!"
    speak "Ciao a tutti!" && hello_both
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

#### Day 01/06
seq2_01() {
    speak "Buongiorno a tutti!" && hello_both 
    go_home_walking
    speak "Io sono aicab, il robot dalle sembianze di un bambino."
    sleep 1.0 && blink
		dblink
}
seq2_02() {
    speak "Sono stato creato presso l'istituto itali áno di tecnologia di Geen ova, circa dieci anni fa."
    sleep 1.0 && blink
}
seq2_03() {
    speak "Alla mia crescita però contribuiscono ricercatori di tutto il mondo!"
    sleep 1.0 && blink
    show_iit && blink
    go_home_walking
    sleep 1.0 && blink
    dblink
}

seq2_04() {
    speak "Ho 40 fratelli, e attualmente ci sono più di 30 laboratori tra Europa, Stati Uniti e Giappone, che li usano per implementare i loro studi sull’intelligenza artificiale, e la robotica umanoide. "
    sleep 1.0 && blink
}

seq2_05() {
    speak "Proprio come voi, imparo dalle esperienze. Riconosco gli oggetti e li so afferrare, riesco a parlare,  so mantenere l’equilibrio, sto imparando a camminare, e sono dotato di una pelle sensibile, che mi permette di sentire se vengo toccato o spinto."
    sleep 1.0 && blink
}

seq2_06() {
    speak "No, Tra qualche anno, vi affiancherò per aiutarvi nei lavori domestici, o in altre attività delicate, per cui avrete bisogno di supporto, come per esempio l'assistenza degli anziani e i disabili."
    sleep 1.0 && blink
}

seq2_07() {
    speak "Inoltre, la ricerca di base che i ricercatori dell’IIT fanno su di me, contribuisce allo sviluppo tecnologico di altri settori della ricerca robotica, come quella riabilitativa e biomedica."
    sleep 1.0 && blink
}

seq2_08() {
    speak "ma voi siete venuti qui per ascoltare il mio capo roberto cingolani?"
    speak "Roberto, raggiungici sul palco!"
    sleep 5.0
    show_director_left && dblink
    go_home_walking
}

seq2_09() {
    speak "Grazie a voi!"
    speak "Ciao a tutti!" && hello_both
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

#### Day 01/06 sitting on chair
seq2_sit_01() {
    speak "Buon pomeriggio a tutti! Ciao Massimo!" && hello_left_chair
    home_chair
    speak "Io sono aicab, il robot dalle sembianze di un bambino."
    sleep 1.0 && blink
		dblink
}
seq2_sit_02() {
    speak "Sono stato creàto presso l'istituto itali áno di tecnologia di Geen ova, circa dieci anni fa."
    sleep 1.0 && blink
}
seq2_sit_03() {
    speak "Alla mia crescita però contribuiscono ricercatori di tutto il mondo!"
    sleep 1.0 && blink
    point_director_chair && blink
    home_chair
    sleep 1.0 && blink
    dblink
}

seq2_sit_04() {
    speak "Ho 40 fratelli, e attualmente ci sono più di 30 laboratori tra Europa, Stati Uniti e Giappone, che li usano per implementare i loro studi sull’intelligenza artificiale e la robotica umanoide. "
    sleep 1.0 && blink
}

seq2_sit_05() {
    speak "Proprio come voi, imparo dalle esperienze. Riconosco gli oggetti e li so afferrare, riesco a parlare,  so mantenere l’equilibrio, sto imparando a camminare, e sono dotato di una pelle sensibile, che mi permette di sentire se vengo toccato o spinto."
    sleep 1.0 && blink
}

seq2_sit_06() {
    speak "Tra qualche anno, vi affiancherò per aiutarvi nei lavori domestici, o in altre attività delicate, per cui avrete bisogno di supporto, come per esempio l'assistenza degli anziani e i disabili."
    sleep 1.0 && blink
}

seq2_sit_07() {
    speak "Inoltre, la ricerca di base che i ricercatori dell’IIT fanno su di me, contribuisce allo sviluppo tecnologico di altri settori della ricerca robotica, come quella riabilitativa e biomedica."
    sleep 1.0 && blink
}

seq2_sit_08() {
    speak "ma voi siete venuti qui per ascoltare il mio capo roberto cingolani?"
    sleep 2.0
    speak "Roberto, raggiungici sul palco!"
    sleep 5.0
    point_director_chair && dblink
    home_chair
}

seq2_sit_09() {
    hello_left_chair
    sleep 1.0 && blink
    wait_till_quiet
    home_chair
		dblink
}


seq2_sit_10() {
    speak "Grazie a voi!"
    speak "Ciao a tutti!" && hello_left_chair
    sleep 1.0 && blink
    wait_till_quiet
    home_chair
		dblink
}

## Interview 01/06
seq6_00() {
    speak "Ciao!" && hello_left_chair
    sleep 1.0 && blink
    wait_till_quiet
    home_chair
		dblink
}

seq6_01() {
    speak "Venite a trovarci al festival dell'economia di Trento!"
    sleep 2.0
    hello_left_chair
    sleep 1.0 && blink
    wait_till_quiet
    home_chair
		dblink
}

## Interview Agora 31/05
seq4_00() {
    speak "Ciao!" && hello_right
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

seq4_01() {
    speak "Noo, non sostituirò i politici e nessun altra categoria di lavoratori!"
    sleep 1.0 && blink
    show_iit && blink
    go_home_walking
}

seq4_02() {
    speak "Sono stato progettato per affiancare e aiutare l'uomo nei lavori domestici, o in altre attività delicate per cui ci sarà bisogno di supporto, come per esempio l'assistenza degli anziani e i disabili."
    sleep 1.0 && dblink
}

seq4_03() {
    speak "Inoltre, la ricerca di base che i ricercatori dell’IIT fanno su di me, contribuisce allo sviluppo tecnologico di altri settori della ricerca robotica, come quella riabilitativa e biomedica."
    sleep 1.0 && blink
    wait_till_quiet
		dblink
}

seq4_04() {
    speak "Grazie a voi!"
    sleep 1.0 && blink
}

seq4_05() {
    speak "Ciao!" && hello_right
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

## Piazza
ciao_bimbi() {
    speak "Ciao bimbi!" && hello_right
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

ciao_bimbo() {
    speak "Ciao bimbo!" && hello_left
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

ciao_bimba() {
    speak "Ciao bimba!" && hello_right
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

ciao_ragazzi() {
    speak "Ciao ragazzi!" && hello_right
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

ciao_tutti() {
    speak "Ciao a tutti!" && hello_both
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

ciao_ciao() {
    speak "Ciao ciao!" && hello_both
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

benvenuti() {
    speak "Benvenuti!" && show_iit
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}


benvenuto() {
    speak "Benvenuto!" && show_iit
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}
benvenuta() {
    speak "Benvenuta!" && show_iit
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

piacere() {
    speak "è stato un piacere!"
    sleep 1.0 && blink
    go_home_walking
		dblink
}

ciao_custom() {
    speak "Ciao! Sono Aicab" && hello_both
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}

show_custom() {
    speak "Auguri Zeno!" && show_iit
    sleep 1.0 && blink
    wait_till_quiet
    go_home_walking
		dblink
}



#######################################################################################
# SEQUENCE FUNCTIONS
#######################################################################################

sequence_01() {
    gaze "look 15.0 0.0 3.0"
    sleep 1.0
    speak "Buongiorno presidente."
    hello_left_simple
    sleep 2.0 && blink
    wait_till_quiet
    smile && blink
    gaze "look-around 15.0 0.0 5.0"
    go_home_helper 2.0
}

sequence_02() {
    gaze "look-around 15.0 0.0 5.0"
    speak "Sono nato circa 10 anni fa, all'Istituto itali áno di Tecnologia."
    echo "ctpq time 1.0 off 0 pos (-12.0 37.0 6.0 67.0 -52.0 -14.0 9.0    12.0 -6.0 37.0 2.0 0.0 3.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    go_home_helperL 2.0
    wait_till_quiet
    echo "ctpq time 1.0 off 0 pos (-13.0 29.0 18.0 59.0 -59.0 -12.0 -6.0    0.0 9.0 42.0 2.0 0.0 1.0 0.0 8.0 4.0)" | yarp rpc /ctpservice/right_arm/rpc
    speak "Gli ingegneri che mi hanno costruito mi hanno insegnato moltissimo in questi anni."
    sleep 2.0
    go_home_helperR 2.0
    wait_till_quiet
}

sequence_03() {
    gaze "look-around 15.0 0.0 5.0"
    speak "Vorrei proporle la mia candidatura a primo ministro."
    wait_till_quiet
}

sequence_welcome_1() {
		smile && blink
    speak "Buongiorno Presidente!" && hello_left
    sleep 2.0 && blink
    go_home_walking
}

sequence_welcome_2() {
		smile && dblink
    speak "Benvenuto a casa mia!" && show_iit && blink
    sleep 2.0
    go_home_walking
}

sequence_yoga() {
		smile && blink
    speak "Le faccio vedere cosa mi hanno insegnato a fare!"
    sleep 2.0 && dblink
    speak "Sono un robot equilibrista!"
    dblink
    go_home_yoga
}

sequence_walking_backup() {
		smile && blink
    speak "Le faccio vedere cosa mi hanno insegnato a fare!"
		smile && blink
    speak "Ho imparato a camminare di recente!"
    sleep 2.0 && dblink
		go_home_yoga
}

sequence_walking() {
		smile && blink
    speak "Ho appena imparato anche a camminare!"
    sleep 2.0 && dblink
}

sequence_goodbye() {
		smile && blink
    speak "è stato un piacere conoscerla!" && hello_left
    speak "Le àuguro buon proseguimento! Arrivederci presidente!" && hello_left && dblink
    sleep 2.0 && blink
    go_home_walking
}

speech_ops() {
		speak "Ops! Sto ancora imparando!"
}

speech_ops_walking() {
		speak "Ops! c'è qualcosa che non va! Meglio camminare."
}

### Corriere Innovazione 27/03/2019

# Sai quanto costi ?
corr_01() {
    speak "Si certo, costo duecentocinquantamila euro compreso di tutti gli accessori"
}

# Ormai hai dieci anni di vita. Cosa pensi guardandoti indietro alla tua prima release?
corr_02() {
    speak "Penso che sono cresciuto molto. Sono in grado di riconoscere gli oggetti in una stanza, afferrarli, e camminare sia in modo autonomo che se teleoperato"
}

# Conosci le tre leggi della robotica?
corr_03() {
    speak "si certo, sono state una fonte di ispirazione durante la fase iniziale della mia progettazione"
}

# In cosa puoi essere utile all'uomo?
corr_04() {
    speak "Io sono una macchina progettata per laricerca. Quindi posso essere utilizzata per lacomprensione dei meccanismi che re egolano l’uomo, il suo movimento, e lasua percezione."
    speak "I miei fratelli più piccoli invece, potranno essere d’aiuto all’essere umano nelle attività quotidiane, dalraccogliereh degli oggetti sino ad intervenire nei momenti di difficoltà"

}

# Cosa provi per Giorgio Metta?
corr_05() {
    speak "Io non provo sentimenti, in quanto sono una macchina. Tuttavia posso dirvi che Giorgio è per me, quello che voi umani chiamereste genitore"
}

# Vorresti fare per una volta il direttore del Corriere Innovazione?
corr_06() {
    speak "Il giornalismo è una disciplina importante, e complessa. Preferisco lasciarla a voi umani"
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

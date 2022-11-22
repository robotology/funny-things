#!/bin/bash
#######################################################################################
# FLATWOKEN ICON THEME CONFIGURATION SCRIPT
# Copyright: (C) 2022 FlatWoken icons
# Author:  Nicolo' Genesio
# email:   nicogenesio91@gmail.com
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
Author:  Nicolo' Genesio <nicolo.genesio@iit.it>

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

look_down() {
    echo "ctpq time 1 off 0 pos (-29.8609 0.0659181 1.6095 -10)" | yarp rpc /ctpservice/head/rpc
}

look_up() {
    echo "ctpq time 1 off 0 pos (1.07666 0.0659181 1.69739 10)" | yarp rpc /ctpservice/head/rpc
}

look_left_down() {
    echo "ctpq time 1 off 0 pos (-29.8609 0.0659181 20 -10)" | yarp rpc /ctpservice/head/rpc
}

look_right_up() {
    echo "ctpq time 1 off 0 pos (1.07666 0.0659181 -20 10)" | yarp rpc /ctpservice/head/rpc
}

look_left_up() {
    echo "ctpq time 1 off 0 pos (-29.8609 0.0659181 20 10)" | yarp rpc /ctpservice/head/rpc
}

look_right_down() {
    echo "ctpq time 1 off 0 pos (1.07666 0.0659181 -20 -10)" | yarp rpc /ctpservice/head/rpc
}


look_around() {
    look_left_down
    look_right_up
    look_left_up
    look_right_down
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


set_up_left_arm(){
    echo "ctpq time 1.5 off 7 pos (23.3295 30.7783 -3.06519 53.8881 49.0925 58.8869 45.9779 83.2985 140.312)" | yarp rpc /ctpservice/left_arm/rpc
}

open_left_hand() {
    echo "ctpq time 2.0 off 7 pos (20.0 35.0 17.0 1.0 1.0 1.0 1.0 1.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}


open_right_hand() {
    echo "ctpq time 2.0 off 7 pos (20.0 30.0 0.0 1.0 1.0 1.0 1.0 1.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

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


###################################################################
#               ACTIONS FOR RUNWAY                                #
###################################################################
home_left_arm()
{
    echo "ctpq time 2.5 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
}

home_right_arm()
{
    echo "ctpq time 2.5 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
}
home_torso(){
    echo "ctpq time 2 off 0 pos (0 0 0)" | yarp rpc /ctpservice/torso/rpc
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

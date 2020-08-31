
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
# HELPER FUNCTIONS
#######################################################################################
close_eyes() {
    echo "set eli sad" | yarp rpc /icub/face/emotions/in
}

open_eyes() {
    echo "set eli hap" | yarp rpc /icub/face/emotions/in
}

squint() {
    echo "set eli sur" | yarp rpc /icub/face/emotions/in
}

point_forehead() {
    echo "ctpq time 2 off 0 pos (-25.0 127.0 -3.0 105.0 -22.0 28.0 -6.0 21.0 55.0 30.0 33.0 4.0 9.0 58.0 113.0 192.0)" | yarp rpc /ctpservice/$1/rpc
}

gaze() {
    echo "$1" | yarp write ... /gaze
}

take_pen() {
    echo "ctpq time 3.0 off 7 pos (27.0 47.0 22.0 123.0 66.0 100.0 35.0 90.0 240.0)" | yarp rpc /ctpservice/$1/rpc  
}

blink() {
    echo "blink" | yarp rpc /iCubBlinker/rpc
    sleep 0.5
}

go_home() {
    # This is with the arms over the table
    echo "ctpq time $1 off 0 pos (-12.0 24.0 23.0 64.0 -7.0 -5.0 10.0    12.0 -6.0 37.0 2.0 0.0 3.0 2.0 1.0 0.0)" | yarp rpc /ctpservice/$2/rpc
    # This is with the arms close to the legs
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/$2/rpc
}

#######################################################################################
# SEQUENCE FUNCTIONS
#######################################################################################
scene_1() {
    echo "Scena 1"
    close_eyes
    sleep 1.0    
    squint
    sleep 1.0
    open_eyes
    sleep 1.0
    squint
    sleep 1.0
    gaze "look-around 0.0 0.0 5.0"
    sleep 2.0
}

scene_8() {
    echo "Scena 8" 
    point_forehead $1
    sleep 5.0
    go_home 2.0 $1
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
    echo "Scena 14"
}

scene_15() {
    echo "Scena 15"
}

scene_17() {
    echo "Scena 17"
}

scene_19() {
    echo "Scena 19"
}

scene_20() {
    echo "Scena 20"
}

scene_22() {
    echo "Scena 22"
}

#######################################################################################
# "MAIN" FUNCTION:                                                                    #
#######################################################################################
echo "********************************************************************************"
echo ""

$1 "$2 $3"

if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi

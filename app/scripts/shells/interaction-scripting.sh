usage() {
cat << EOF
***************************************************************************************
Italia Digitale SCRIPTING
Author:  Vaidm Tikhanoff   <vadim.tikhanoff@iit.it>

This script scripts through the commands available for the navigation of R1

USAGE:
        $0 options

***************************************************************************************
OPTIONS:

***************************************************************************************
EXAMPLE USAGE:

$./interaction-scripting.sh runAll

***************************************************************************************
EOF
}

#######################################################################################
# HELPER FUNCTIONS EMOTIONS
#######################################################################################
smile() {
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}

surprised() {
    echo "set mou sur" | yarp rpc /icub/face/emotions/in
    echo "set leb sur" | yarp rpc /icub/face/emotions/in
    echo "set reb sur" | yarp rpc /icub/face/emotions/in
}

neutral() {
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    echo "set leb neu" | yarp rpc /icub/face/emotions/in
    echo "set reb neu" | yarp rpc /icub/face/emotions/in
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

#######################################################################################
# HELPER FUNCTIONS GAZE
#######################################################################################

track_gaze() {
    echo "set track 1" | yarp rpc /iKinGazeCtrl/rpc
}

untrack_gaze() {
    echo "set track 0" | yarp rpc /iKinGazeCtrl/rpc
}

#######################################################################################
# HELPER FUNCTIONS GAZE
#######################################################################################

look_at() {
    echo "$1 $2 $3" | yarp write ... /iKinGazeCtrl/xd:i
}

home_gaze() {
    look_at -0.5 0.0 0.34
}

gaze_person() {
    look_at -0.5 0.0 0.24
}

idle_gaze() {
    echo "idle head" | yarp rpc /actionsRenderingEngine/cmd:io
}

block_eyes() {
    echo "bind eyes 2.0" | yarp rpc /iKinGazeCtrl/rpc
}

clear_eyes() {
    echo "clear eyes" | yarp rpc /iKinGazeCtrl/rpc
}

attend_right() {
    track_gaze
    look_at -0.4 0.15 -0.05
}

attend_left() {
    track_gaze
    look_at -0.4 -0.15 -0.05
}

#######################################################################################
# HELPER FUNCTIONS BLINK
#######################################################################################

blink() {
    echo "blink" | yarp rpc /iCubBlinker/rpc
    sleep 0.5
}

#######################################################################################
# HELPER FUNCTIONS ACTIONS
#######################################################################################

point_right() {
    echo "point (-0.430766 0.204718 -0.127849) right no_head" | yarp rpc /actionsRenderingEngine/cmd:io &    
    sleep 4.0     
    home_gaze
    sleep 2.0
    gaze_person
}

point_left() {
    echo "point (-0.430766 -0.204718 -0.127849) left no_head" | yarp rpc /actionsRenderingEngine/cmd:io &    
    sleep 4.0     
    home_gaze
    sleep 2.0
    gaze_person
}

expect_right() {
    look_hand_right
    echo "expect right near" | yarp rpc /actionsRenderingEngine/cmd:io
}

expect_left() {
    look_hand_left
    echo "expect left near" | yarp rpc /actionsRenderingEngine/cmd:io   
}

look_hand_right() {
    echo "look hand right" | yarp rpc /actionsRenderingEngine/cmd:io   
}

look_hand_left() {
    echo "look hand left" | yarp rpc /actionsRenderingEngine/cmd:io 
}

return_home() {
    smile
    gaze_person
    echo "home arms" | yarp rpc /actionsRenderingEngine/cmd:io
}

#######################################################################################
# HELPER FUNCTIONS RUN THE DEMO
#######################################################################################

run_all_right() {
    track_gaze
    neutral
    home_gaze
    sleep 2.0
    look_at -0.5 0.0 0.24
    sleep 4.0
    attend_right
    sleep 2.0
    point_right
    sleep 3.0
    expect_right
    return_home
}

run_all_left() {
    track_gaze
    neutral
    home_gaze
    sleep 2.0
    look_at -0.5 0.0 0.24
    sleep 4.0
    attend_left
    sleep 2.0
    point_left
    sleep 3.0
    expect_left
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

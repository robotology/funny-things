
 #!/bin/bash

#######################################################################################
# HELP
#######################################################################################
usage() {
cat << EOF
***************************************************************************************
R1 Interaction SCRIPTING
Author:  Vadim Tikhanoff   <vadim.tikhanoff@iit.it>

This script scripts through the commands available for the navigation of R1

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

speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}

go_home_helper() {
    go_home_helperR $1
    go_home_helperL $1
}

go_home_helperL()
{
    echo "ctpq time $1 off 0 pos (-10.0 10.0 10.0 45.0 -1.6 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

go_home_helperR()
{
    echo "ctpq time $1 off 0 pos (-10.0 10.0 10.0 45.0 -1.6 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

go_home()
{
    go_home_helper 5.0
}

#######################################################################################
# SEQUENCE FUNCTIONS
#######################################################################################

down_arms() {
   speak "I am going through the corridors"
   echo "ctpq time 2.0 off 0 pos (-10.0 5.0 -6.0 45.0 -3.2 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
   echo "ctpq time 2.0 off 0 pos (-10.0 5.0 -6.0 45.0 -3.2 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

torso_up() {
    echo "ctpq time 4.0 off 0 pos (0.15 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

torso_down() {
    echo "ctpq time 4.0 off 0 pos (0.01 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

home_right() {
   echo "(parameters ((mode full_pose+no_torso_no_heave)) ) (target (0.366637 -0.277564 0.857717 -0.982174 -0.187205 -0.016979 1.662991))" | yarp write .... /cer_reaching-controller/right/target:i
}

home_left() {
   echo "(parameters ((mode full_pose+no_torso_no_heave)) ) (target (0.367518 0.273386 0.850667 -0.97539 -0.014684 -0.219999 1.515129))" | yarp write .... /cer_reaching-controller/left/target:i
}

point_left() {
 
    echo "(parameters ((mode full_pose+no_torso_no_heave)) ) (target (0.5 0.303386 0.750667 -0.996393 0.065846 0.053525 1.47289))" | yarp write .... /cer_reaching-controller/left/target:i    
}

point_right() {
    echo "(parameters ((mode full_pose+no_torso_no_heave)) ) (target (0.5 -0.303386 0.750667 -0.996393 0.065846 0.053525 1.47289))" | yarp write .... /cer_reaching-controller/right/target:i    
}

head_rest() {
    echo "(control-frame depth) (target-type angular) (target-location (0.0 -10.0)) " | yarp write .... /cer_gaze-controller/target:i
}

head_left() {
    echo "(control-frame depth) (target-type angular) (target-location (20.0 -20.0)) " | yarp write .... /cer_gaze-controller/target:i
}

head_right() {
    echo "(control-frame depth) (target-type angular) (target-location (-20.0 -20.0)) " | yarp write .... /cer_gaze-controller/target:i
}

close_thumb_left() {
    echo "pointing left " | yarp rpc /superquadric-grasp/rpc
}

close_thumb_right() {
    echo "pointing right" | yarp rpc /superquadric-grasp/rpc
}

open_thumb_left() {
    echo "rest left" | yarp rpc /superquadric-grasp/rpc
}

open_thumb_right() {
    echo "rest right" | yarp rpc /superquadric-grasp/rpc
}

stop() {
    echo "stop" | yarp rpc /cer_reaching-controller/left/rpc
    echo "stop" | yarp rpc /cer_reaching-controller/right/rpc
}


#######################################################################################

sequence_setup() {

    torso_up
    head_rest
    sleep 6.0
    home_left
    home_right
    
}

sequence_rest() {

    torso_down
    head_rest
    sleep 3.0
    down_arms
    
}

print() {
echo "stop"

}

sequence() {
    
 ################################################ head left   
    head_left
    sleep 2.0
########################  return  
    head_rest
    sleep 2.0
################################################  head + point left 
    head_left
    point_left
    close_thumb_left
                        sleep 4.0
    stop
    sleep 0.5
########################  return    
    home_left
    head_rest
    open_thumb_left
                        sleep 4.0
    stop
    sleep 0.5
################################################ head + point right 
    head_right
    close_thumb_right
    point_right
                        sleep 4.0
    stop
    sleep 0.5
########################  return
    home_right
    head_rest
    open_thumb_right
                        sleep 4.0
    stop
    sleep 0.5
################################################ head right
    head_right
    sleep 2.0
########################  return  
    head_rest
    sleep 2.0
################################################  point left 
    
    point_left
    close_thumb_left
                        sleep 4.0
    stop
    sleep 0.5
########################  return    
    home_left
    
    open_thumb_left
                        sleep 4.0
    stop
    sleep 0.5
################################################  point right 
    
    point_right
    close_thumb_right
                        sleep 4.0
    stop
    sleep 0.5
########################  return    
    home_right
    
    open_thumb_right
                        sleep 4.0
    stop
    sleep 0.5
}


sequence_long() {

        
    sequence
    sleep 1.0
    sequence
    
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

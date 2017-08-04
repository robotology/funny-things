
 #!/bin/bash

#######################################################################################
# HELP
#######################################################################################
usage() {
cat << EOF
***************************************************************************************
Italia Digitale SCRIPTING
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

livingRoom() {
    speak "I am in the living room"
    go_home
}

corridors() {
   speak "I am going through the corridors"
   echo "ctpq time 2.0 off 0 pos (-10.0 5.0 -6.0 45.0 -3.2 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
   echo "ctpq time 2.0 off 0 pos (-10.0 5.0 -6.0 45.0 -3.2 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

corridors_full_left() {
   speak "I am going through the corridors"
   echo "ctpq time 2.0 off 0 pos (-8.8 5.4 -11.9 92.0 9.6 0.0 -13.0 11.0)" | yarp rpc /ctpservice/left_arm/rpc
   echo "ctpq time 2.0 off 0 pos (-10.0 5.0 -6.0 45.0 -3.2 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

corridors_full_right() {
   speak "I am going through the corridors"
   echo "ctpq time 2.0 off 0 pos (-8.8 5.4 -11.9 92.0 9.6 0.0 -13.0 11.0)" | yarp rpc /ctpservice/right_arm/rpc
   echo "ctpq time 2.0 off 0 pos (-10.0 5.0 -6.0 45.0 -3.2 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

test() {
    speak "this is a test"
}

torso_up() {
    echo "ctpq time 4.0 off 0 pos (0.17 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

torso_down() {
    echo "ctpq time 4.0 off 0 pos (0.01 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

table_right() {
   speak "getting ready to approach the table"
   #echo "ctpq time 2.0 off 0 pos (8.0 16.0 6.7 94.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
   #echo "ctpq time 2.0 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/right_wrist_tripod/rpc
   echo "(parameters ((mode full_pose+no_torso_no_heave)) ) (target (0.376637 -0.277564 0.907717 -0.982174 -0.187205 -0.016979 1.662991))" | yarp write .... /cer_reaching-controller/right/target:i
}

table_left() {
   speak "getting ready to approach the table"
   #echo "ctpq time 2.0 off 0 pos (8.0 16.0 6.7 94.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
   #echo "ctpq time 2.0 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/left_wrist_tripod/rpc
   echo "(parameters ((mode full_pose+no_torso_no_heave)) ) (target (0.377518 0.273386 0.900667 -0.97539 -0.014684 -0.219999 1.515129))" | yarp write .... /cer_reaching-controller/left/target:i
}

provide_object_left() {
 
    echo "(parameters ((mode full_pose+no_torso_no_heave)) ) (target (0.5 0.203386 0.750667 -0.996393 0.065846 0.053525 1.47289))" | yarp write .... /cer_reaching-controller/left/target:i    
}

provide_object_right() {
 
    echo "(parameters ((mode full_pose+no_torso_no_heave)) ) (target (0.5 -0.203386 0.750667 -0.996393 0.065846 0.053525 1.47289))" | yarp write .... /cer_reaching-controller/right/target:i    
}

provide_torso_up() {
    echo "ctpq time 4.0 off 0 pos (0.10 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

provide_stop() {
    echo "stop" | yarp rpc /cer_reaching-controller/left/rpc
    echo "stop" | yarp rpc /cer_reaching-controller/right/rpc
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

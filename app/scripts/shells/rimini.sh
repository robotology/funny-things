#!/bin/bash
#######################################################################################
# ERGOCUB SPEECH DEMO SCRIPT
# Description: This script contains the YARP commands to animate ergoCub during
#              its welcome speech.
#######################################################################################


#######################################################################################
# HELP
#######################################################################################
usage() {
cat << EOF
***************************************************************************************
ERGOCUB SCRIPTING
This script executes the movements designed for the ergoCub welcome speech.

USAGE:
        $0 [COMMANDS]

***************************************************************************************
COMMANDS:
    --- HOME POSITIONS ---
        home_arms             Moves both arms to the home position.
        home_torso            Moves the torso to the home position.
        home_head             Moves the head to the home position.

    --- 1. WELCOME & CLOSURE ---
        open_welcoming_arms   Opens arms wide to greet the audience.
        bow                   A respectful bow with torso and head.
        passing_the_floor     Extends right arm to pass the word to the President.

    --- 2. TEMPORAL & NARRATIVE ---
        timeline_sweep        A horizontal sweep with the right arm to indicate time.
        weighing_hands        Moves hands up and down to compare concepts.
        synergy_integration   Brings both hands together in front of the chest.

    --- 3. EMPHASIS & EXPLANATION ---
        making_a_point        Raises the right arm with an implied index finger point.
        calming_stability     Lowers both arms gently to indicate stability/safety.

    --- 4. AUTO-REFERENTIAL ---
        self_reference        Brings the right hand to the robot's chest.
        displaying_self       Slightly opens arms along the hips to show the body.

    --- 5. HEAD & GAZE ---
        room_scan             Slowly rotates the head left and right to look at the audience.
        nodding               Nods the head up and down to confirm a point.

        usage                 Displays this help message.
***************************************************************************************
EXAMPLE USAGE:
$0 open_welcoming_arms
***************************************************************************************
EOF
}

#######################################################################################
# HOME POSITIONS
#######################################################################################
home_left_arm() {
    # Arms close to the legs
    echo "ctpq time 1.5 off 0 pos (0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

home_right_arm() {
    # Arms close to the legs
    echo "ctpq time 1.5 off 0 pos (0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

home_arms() {
    home_left_arm
    home_right_arm
} 

home_torso() {
    echo "ctpq time 1.5 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

home_head() {
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
}


#######################################################################################
# 1. WELCOME & CLOSURE MOVEMENTS
#######################################################################################
open_welcoming_arms() {
    # Opens both arms wide with palms facing somewhat upwards
    # "Benvenute e benvenuti, autorità..."
    echo "ctpq time 2.0 off 0 pos (-30.0 60.0 -30.0 40.0 0.0 -20.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-30.0 60.0 -30.0 40.0 0.0 -20.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    home_arms
}

bow() {
    # Slightly bends torso forward and pitches head down
    echo "ctpq time 1.5 off 0 pos (0.0 0.0 20.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.5 off 0 pos (-20.0 0.0 0.0 0.0 )" | yarp rpc /ctpservice/head/rpc
    sleep 2.0
    home_torso
    home_head
}

passing_the_floor() {
    # Extends the right arm to the side to introduce the President
    # "...passo la parola al Presidente dell'Inail..."
    echo "ctpq time 2.0 off 0 pos (-20.0 45.0 -45.0 30.0 -45.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (0.0 0.0 -30.0 0.0 )" | yarp rpc /ctpservice/head/rpc
}


#######################################################################################
# 2. TEMPORAL & NARRATIVE MOVEMENTS
#######################################################################################
timeline_sweep() {
    # Right arm moves horizontally to represent a timeline or history
    # "...un percorso che attraversa cento anni di storia..."
    
    # Start position (arm to the left/center)
    echo "ctpq time 1.5 off 0 pos (-20.0 20.0 45.0 60.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5
    # Sweep to the right
    echo "ctpq time 2.5 off 0 pos (-20.0 50.0 -45.0 40.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    home_right_arm
}

weighing_hands() {
    # Alternates moving hands up and down, as if weighing two eras/options
    echo "ctpq time 1.5 off 0 pos (-30.0 30.0 0.0 60.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-10.0 30.0 0.0 80.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time 1.5 off 0 pos (-10.0 30.0 0.0 80.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-30.0 30.0 0.0 60.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    home_arms
}

synergy_integration() {
    # Brings both hands together in front of the chest to show collaboration
    # "...una sinergia tra l'esperienza sul campo..."
    echo "ctpq time 2.0 off 0 pos (-20.0 20.0 30.0 80.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-20.0 20.0 30.0 80.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 7.0
    home_arms
}


#######################################################################################
# 3. EMPHASIS & EXPLANATION MOVEMENTS
#######################################################################################
making_a_point() {
    # Raises the right arm with elbow bent, as if pointing a finger upward
    # "Con il nuovo millennio si è affermato un principio chiave..."
    echo "ctpq time 1.5 off 0 pos (-60.0 20.0 0.0 90.0 0.0 0.0 0.0 0.0 0.0 40.0 0.0 40.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 7.0
    home_right_arm
}

calming_stability() {
    # Arms slightly raised, then pushed down with palms facing down to convey safety
    echo "ctpq time 1.5 off 0 pos (-20.0 30.0 0.0 60.0 -90.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-20.0 30.0 0.0 60.0 -90.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5
    echo "ctpq time 1.0 off 0 pos (0.0 20.0 0.0 30.0 -90.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (0.0 20.0 0.0 30.0 -90.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    home_arms
}


#######################################################################################
# 4. AUTO-REFERENTIAL MOVEMENTS
#######################################################################################
self_reference() {
    # Brings the right hand towards the center of the chest
    # "Ed è qui che entra in gioco anche la mia presenza."
    echo "ctpq time 1.5 off 0 pos (-20.0 10.0 45.0 100.0 -45.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (15.0 0.0 0.0 0.0 )" | yarp rpc /ctpservice/head/rpc
    sleep 3.0
    home_right_arm
    home_head
}

displaying_self() {
    # Opens arms slightly downwards and outwards to show its own structure
    # "La tecnologia che incarno..."
    echo "ctpq time 2.0 off 0 pos (-10.0 40.0 0.0 20.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-10.0 40.0 0.0 20.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    home_arms
}


#######################################################################################
# 5. HEAD & GAZE MOVEMENTS
#######################################################################################
room_scan() {
    # Slowly pans the head from left to right to look at the audience
    echo "ctpq time 2.5 off 0 pos (0.0 0.0 30.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 3.0
    echo "ctpq time 5.0 off 0 pos (0.0 0.0 -30.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 5.5
    home_head
}

nodding() {
    # A single, deliberate nod to give emphasis
    echo "ctpq time 0.8 off 0 pos (-15.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.0
    echo "ctpq time 0.8 off 0 pos (5.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.0
    home_head
}


#######################################################################################
# "MAIN" FUNCTION                                                                     #
#######################################################################################
echo "********************************************************************************"
echo ""

if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi

# Execute the passed command
$1 $2 $3
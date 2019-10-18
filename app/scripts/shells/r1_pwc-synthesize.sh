
 #!/bin/bash

#######################################################################################
# HELP
#######################################################################################
usage() {
cat << EOF

***************************************************************************************
R1 VIDEO SCRIPTING
Authors:
- Vadim Tikhanoff   <vadim.tikhanoff@iit.it>
- Ugo Pattacini     <ugo.pattacini@iit.it>

This script scripts through the commands available for the navigation of R1

USAGE:
        $0 options
***************************************************************************************
EOF
}


#######################################################################################
# HELPER FUNCTIONS
#######################################################################################

nav_reset() {
  echo "reset_odometry" | yarp rpc /navController/rpc
}

nav_go_to() {
  echo "go_to $1 $2 $3" | yarp rpc /navController/rpc
}

nav_go_to_wait() {
  echo "go_to_wait $1 $2 $3 $4" | yarp rpc /navController/rpc
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

speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}

go_home_helper() {
    go_home_helperR $1
    go_home_helperL $1
}

go_home_helperL()
{
    echo "ctpq time $1 off 0 pos (7.0 10.0 -10.0 21.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

go_home_helperR()
{
    echo "ctpq time $1 off 0 pos (7.0 15.0 -10.0 12.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

go_home()
{
    go_home_helper 4.0
}

arms_up() {
    echo "ctpq time 3.0 off 0 pos (9.0 25.0 -10.0 31.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 3.0 off 0 pos (9.0 25.0 -10.0 31.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

arms_down() {
    echo "ctpq time 3.0 off 0 pos (-9.0 15.0 -10.0 50.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 3.0 off 0 pos (-9.0 15.0 -10.0 50.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

torso_up() {
    echo "ctpq time 6.0 off 0 pos (0.14 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

torso_down() {
    echo "ctpq time 6.0 off 0 pos (0.03 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

head_down() {
    echo "ctpq time 2.5 off 0 pos (30.0 0.0)" | yarp rpc /ctpservice/head/rpc
}

head_up() {
    echo "ctpq time 2.5 off 0 pos (0.0 0.0)" | yarp rpc /ctpservice/head/rpc
}

look_gripper() {
    echo "ctpq time 2.5 off 0 pos (41.7 14.9 -40.6 74.6 78.8 0.0 6.1 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.5 off 0 pos (20.0 5.0)" | yarp rpc /ctpservice/head/rpc
}

gripper_move() {
    echo "ctpq time 1 off 0 pos (85.0 60)" | yarp rpc /ctpservice/left_hand/rpc
    echo "ctpq time 2.5 off 0 pos (41.7 14.9 -40.6 74.6 -33.8 0.0 6.1 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.3
    echo "ctpq time 1 off 0 pos (25.0 25)" | yarp rpc /ctpservice/left_hand/rpc
    echo "ctpq time 2.5 off 0 pos (41.7 14.9 -40.6 74.6 78.8 0.0 6.1 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.3
    echo "ctpq time 1 off 0 pos (85.0 60)" | yarp rpc /ctpservice/left_hand/rpc
    sleep 1.3
    echo "ctpq time 1 off 0 pos (25.0 25)" | yarp rpc /ctpservice/left_hand/rpc
}

all_down() {
    go_home
    torso_down
    head_down
    echo "blck" | yarp rpc /faceExpressionImage/rpc
}

wake_up() {
    head_up
    echo "rst" | yarp rpc /faceExpressionImage/rpc
    torso_up
    arms_up
}

wake_up_head() {
    head_up
    echo "rst" | yarp rpc /faceExpressionImage/rpc
    torso_up
    arms_up
    
    sleep 2
    echo "ctpq time 2.0 off 0 pos (0.0 40.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2
    echo "ctpq time 2.0 off 0 pos (0.0 -40.0)" | yarp rpc /ctpservice/head/rpc
}

reach_right() {

    echo "ctpq time 3.5 off 0 pos (9.0 25.0 -10.0 31.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 3.5 off 0 pos (32.5 52.2 -9.9 8.8 0.0 0.1 0.1 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2.5 off 0 pos (20.0 -42.0)" | yarp rpc /ctpservice/head/rpc
    #echo "ctpq time 3.0 off 0 pos (0.05 -0.0 -10.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "set vels (0.013 0.013 0.013 0.0)" | yarp rpc /cer/torso/rpc:i
    echo "set poss (0.05 -0.0 -22.0 0.0)" | yarp rpc /cer/torso/rpc:i
}

reach_left() {

    echo "ctpq time 3.0 off 0 pos (9.0 25.0 -10.0 31.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 3.0 off 0 pos (32.5 52.2 -9.9 8.8 0.0 0.1 0.1 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.5 off 0 pos (20.0 42.0)" | yarp rpc /ctpservice/head/rpc
    #echo "ctpq time 3.0 off 0 pos (0.05 -0.0 10.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "set vels (0.008 0.008 0.008 0.0)" | yarp rpc /cer/torso/rpc:i
    echo "set poss (0.05 -0.0 22.0 0.0)" | yarp rpc /cer/torso/rpc:i
}

rotate_base_left() {

    echo "ctpq time 2.0 off 0 pos (0.10 0.0 0.0 -28.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 3.0 off 0 pos (0.0 -16.0)" | yarp rpc /ctpservice/head/rpc
    for i in {1..20}
    do 
        echo "set vmos (-25.0 25.0)"| yarp rpc /cer/mobile_base/rpc:i
        sleep 0.05
    done
}

rotate_base_right() {

    echo "ctpq time 4.3 off 0 pos (0.10 0.0 0.0 28.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 3.0 off 0 pos (0.0 16.0)" | yarp rpc /ctpservice/head/rpc
    for i in {1..40}
    do 
        echo "set vmos (25.0 -25.0)"| yarp rpc /cer/mobile_base/rpc:i
        sleep 0.05
    done
}

rotate_base_home() {

    echo "ctpq time 3.0 off 0 pos (0.10 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 3.0 off 0 pos (0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    for i in {1..20}
    do 
        echo "set vmos (-25.0 25.0)"| yarp rpc /cer/mobile_base/rpc:i
        sleep 0.05
    done
}

salute() {
    echo "set vels (0.015 0.015 0.015 0.0)" | yarp rpc /cer/torso/rpc:i
    echo "set poss (0.10 -24.0 0.0 0.0)" | yarp rpc /cer/torso/rpc:i
    echo "ctpq time 2.0 off 0 pos (0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 3.0 off 0 pos (-9.0 15.0 -10.0 50.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 3.0 off 0 pos (-9.0 15.0 -10.0 50.5 0.0 0.0 -0.0 -0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3
    echo "ctpq time 2.0 off 0 pos (-24.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1
    echo "set vels (0.01 0.01 0.01 0.0)" | yarp rpc /cer/torso/rpc:i
    echo "set poss (0.10 0.0 0.0 0.0)" | yarp rpc /cer/torso/rpc:i
    echo "ctpq time 4 off 0 pos (0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    arms_up
}

arms_cart() {
    echo "set vels (0.01 0.01 0.01 0.0)" | yarp rpc /cer/torso/rpc:i
    echo "set poss (0.10 0.0 0.0 0.0)" | yarp rpc /cer/torso/rpc:i
    echo "ctpq time 3.0 off 0 pos (23.2 3.2 -1.7 67.5 -81.3 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 3.0 off 0 pos (23.1 2.1 -1.7 74.5 -84.2 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

arms_relieve() {
    #echo "ctpq time 2.3 off 0 pos (0.15 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    
    echo "set vels (0.02 0.02 0.02 0.0)" | yarp rpc /cer/torso/rpc:i
    echo "set poss (0.12 7.0 0.0 0.0)" | yarp rpc /cer/torso/rpc:i

    for i in {1..15}
    do 
        echo "3.0 -0.05 -0.0 0.0 100.0 0.0 0.0 0.0 0.0"| yarp write ... /baseControl/aux_control:i
        sleep 0.025
    done

    arms_down
    sleep 1
    echo "set poss (0.10 0.0 0.0 0.0)" | yarp rpc /cer/torso/rpc:i
}


close_hands() {
    echo "ctpq time 1 off 0 pos (97.0 87)" | yarp rpc /ctpservice/left_hand/rpc
    echo "ctpq time 1 off 0 pos (97.0 87)" | yarp rpc /ctpservice/right_hand/rpc
}

open_hands() {
    echo "ctpq time 1 off 0 pos (25.0 25)" | yarp rpc /ctpservice/left_hand/rpc
    echo "ctpq time 1 off 0 pos (25.0 25)" | yarp rpc /ctpservice/right_hand/rpc
}

arm_bottle() {

    echo "ctpq time 3.0 off 0 pos (63.4 14.8 17.0 50.4 -1.1 0.0 0.2 0.09)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 4.0
    echo "ctpq time 2 off 0 pos (70.0 70.0)" | yarp rpc /ctpservice/left_hand/rpc
    sleep 2.0
    echo "ctpq time 2.0 off 0 pos (20.0 14.8 -12.0 54.4 0.0 0.0 0.0 0.00)" | yarp rpc /ctpservice/left_arm/rpc
    
}

arm_trash() {
    echo "ctpq time 3.0 off 0 pos (43.4 14.8 -12.0 50.4 0.0 0.1 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 6.0
    echo "ctpq time 1 off 0 pos (25.0 25.0)" | yarp rpc /ctpservice/left_hand/rpc
    sleep 2.0
    for i in {1..50}
    do 
        echo "3.0 -0.05 -0.0 0.0 100.0 0.0 0.0 0.0 0.0"| yarp write ... /baseControl/aux_control:i
        sleep 0.025
    done

    arms_down
}

close_bottle() {
    echo "ctpq time 1 off 0 pos (25.0 25)" | yarp rpc /ctpservice/left_hand/rpc
}


#######################################################################################
# "SEQUENCES" FUNCTION:                                                               #
#######################################################################################

sequence_1() {
  wake_up_head
  sleep 3
  look_gripper
  sleep 3
  gripper_move
  sleep 3
  reach_right
  sleep 9 
  reach_left
  sleep 9 
  wake_up
}

sequence_2() {
  echo "ctpq time 2.0 off 0 pos (0.10 0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
  sleep 1.5 
  rotate_base_leftreach_right
  sleep 1.5 
  rotate_base_right
  sleep 1.5
  rotate_base_home
}


sq_01() {
  speak "Here you are Giorgio!"
  speak "Ten years of research and one humanoid robot, only for clearing your throat?"
}

sq_02() {
  speak "Sorry Giorgio"
  speak "I parked in a red zone this morning, and I got a ticket, that's why I'm so nervous!"
  wait_till_quiet
  speak "Anyway you're welcome, I've been created to help humans. Especially, those of a certain age"
}

sq_03() {
  speak "Of course! I love being on the stage!"
  wait_till_quiet
  speak "Good morning everyone! My name is R1, I've been designed and built at the Italian Institute of Technology"
  wait_till_quiet
  speak "I'm only two years old, but I can already locate, grasp and bring objects to you"
  wait_till_quiet
  speak "I can move around on my wheels, and interact with people"
  wait_till_quiet
  speak "I can do these things, because I'm equipped with a sophisticated intelligence, that most of you call, artificial"
  wait_till_quiet
  speak "I can explore the world using my cameras, and I have also artificial skin on my arms, which is touch sensitive, and that lets me interact with the environment and my human partners more naturally"
  wait_till_quiet
  speak "To be honest, I have to thank i Cub, for most of the things I can do now"
  wait_till_quiet
  speak "Is it enough?"
}

sq_04() {
  speak "Uum. I was just meditating on that, sorry"
  wait_till_quiet
  speak "I was thinking I would really love trying hard, and doing my best, for all my life"
  wait_till_quiet
  speak "Seriously. I'd love to help you, giving for example, information and directions in the shopping centers, airports, or in the hotels"
  wait_till_quiet
  speak "I could also provide surveillance"
  wait_till_quiet
  speak "I could collect useful information on customers habits, and help you increasingly better"
  wait_till_quiet
  speak "I have a mind like a steel trap! Ha ha ha"
  wait_till_quiet
  speak "Frankly, I'm even more ambitious. I dream of being a member of the family"
  wait_till_quiet
  speak "To be with you at home, and help with housework, take care of your kids and play with them"
  wait_till_quiet
  speak "How about that?"
}

sq_05() {
  speak "People from Genoa! Always talking about money!"
  wait_till_quiet
  speak "Anyway, I agree with you, dad!"
  wait_till_quiet
  speak "I see that many of you look quite tired, time for a coffee break, maybe?"
  wait_till_quiet
  speak "Where is Claudio Bisio?"
}

sq_06() {
  speak "Sorry! It's just that they have the same haircut!"
}

#######################################################################################
# "MAIN" FUNCTION:                                                                    #
#######################################################################################
echo "********************************************************************************"
echo ""

$1 "$2 $3 $4"

if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi

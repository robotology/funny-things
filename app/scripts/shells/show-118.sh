 #!/bin/bash

#######################################################################################
# HELP
#######################################################################################
usage() {
cat << EOF
***************************************************************************************
Italia Digitale SCRIPTING
Author:  Vaidm Tikhanoff   <vadim.tikhanoff@iit.it>

This script scripts through the commands available for the show 118 

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

display-text() {
    echo "\"$1\"" | yarp write ... /textimage/txt:i
}

display-sun() {
    echo "set file RobotE_PNG_80x32_16bit_Sole.bmp" | yarp write ... /robot/faceDisplay/rpc
}

display-ticked() {
    echo "set file RobotE_PNG_80x32_16bit_spuntaVerse01.bmp" | yarp write ... /robot/faceDisplay/rpc
}

display-happy() {
    echo "set face hap" | yarp write ... /robot/faceDisplay/rpc
}

display-phone() {
    python /home/r1-user/Desktop/R1Images/cicle-ordered.py /home/r1-user/Desktop/R1Images/toccatadipalle/112Green png &
}

display-heart() {
    python /home/r1-user/Desktop/R1Images/cicle-ordered.py /home/r1-user/Desktop/R1Images/toccatadipalle/battiti png &
}

go_home_helper() {
    #go_home_helperR $1
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

sequence_01() {
    speak "Ciao Giulia! bentornata a casa"
    echo "ctpq time 2.0 off 0 pos (50.0 11.0 8.5 90.0 -70.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
   # echo "ctpq time 1.0 off 0 pos (50.0 11.0 8.5 90.0 -70.0 0.0 0.0 15.0)" | yarp rpc /ctpservice/left_arm/rpc
   # echo "ctpq time 1.0 off 0 pos (50.0 11.0 8.5 90.0 -70.0 0.0 0.0 -15.0)" | yarp rpc /ctpservice/left_arm/rpc
   # echo "ctpq time 1.0 off 0 pos (50.0 11.0 8.5 90.0 -70.0 0.0 0.0 15.0)" | yarp rpc /ctpservice/left_arm/rpc
   # echo "ctpq time 1.0 off 0 pos (50.0 11.0 8.5 90.0 -70.0 0.0 0.0 -15.0)" | yarp rpc /ctpservice/left_arm/rpc
   # echo "ctpq time 1.0 off 0 pos (50.0 11.0 8.5 90.0 -70.0 0.0 0.0 15.0)" | yarp rpc /ctpservice/left_arm/rpc
   # echo "ctpq time 1.0 off 0 pos (50.0 11.0 8.5 90.0 -70.0 0.0 0.0 -15.0)" | yarp rpc /ctpservice/left_arm/rpc

    go_home
}

sequence_08() {

   echo "ctpq time 2.0 off 0 pos (35.0 9.0 -13.0 45.0 -54.0 0.0 -15.0 -1.0)" | yarp rpc /ctpservice/left_arm/rpc
}

sequence_02() {
    speak "Giulia come stai?"
    wait_till_quiet
    speak "Hai bisogno di aiuto?"
    wait_till_quiet
}

sequence_03() {
    display-phone
    speak "Pronto? pronto? sei proprio tu?"
    wait_till_quiet
    speak "Pàssami qualcuno di intelligente"
}

#112: Confermi la localizzazione in via pincopallo n°0?
sequence_04() {
    speak "confermo l’indirizzo via pincopallo n°0"
    wait_till_quiet
}

#112: Confermi la localizzazione in via pincopallo n°0?
sequence_05() {
    speak "confermo l’indirizzo via pincopallo numero 0"
    wait_till_quiet
}

#112: Cosa succede?
sequence_06() {
    speak "La signora Giulia si sente male. Emergenza."
    wait_till_quiet
}

#118: Mi dica esattamente cosa sta succedendo?
sequence_07() {
    speak "Sono R1. Giulia Pastorino, 48 anni. Paziente Sveglio. Soggetto ad alto rischio di infarto."
    wait_till_quiet
    speak "Ultimo infarto registrato: 28 Giugno 2016. Farmaci in uso: anti coagulanti, beta bloccanti, ace inibitori."
    wait_till_quiet
}

#118: I soccorsi stanno arrivando. Grazie R1.


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

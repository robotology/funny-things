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
    echo "\"$1\"" | yarp write ... /gaze
}

speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}

blink() {
    echo "blink" | yarp rpc /iCubBlinker/rpc
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
    echo "ctpq time $1 off 0 pos (-30.0 36.0 0.0 60.0 0.0 0.0 0.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
    # This is with the arms close to the legs
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
}

go_home_helperR() {
    # This is with the arms over the table
    echo "ctpq time $1 off 0 pos (-30.0 36.0 0.0 60.0 0.0 0.0 0.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
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

fonzie() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos ( -3.0 57.0   3.0 106.0 -9.0 -8.0 -10.0 22.0 10.0 10.0 20.0 62.0 146.0 90.0 130.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos ( -3.0 57.0   3.0 106.0 -9.0 -8.0 -10.0 22.0 10.0 10.0 20.0 62.0 146.0 90.0 130.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5
    smile
    go_home
    breathers "start"
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
    go_home
    smile    
    #breathers "start"
}

show_musles() {
    #breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    smile
    go_home_helper 2.0
    breathers "start"
}

show_musles_left() {
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
    gaze "look 20.0 10.0 5.0"
    sleep 1.0
    speak "Buonasera Adele. Grazie per l'invito."
    hello_left_simple
    sleep 2.0 && blink
    wait_till_quiet
    smile && blink
    gaze "look-around 0.0 0.0 10.0"
}

sequence_02() {
    speak "Vengo da Genova"
    wait_till_quiet
    speak "Aicub vuol dire cucciolo di robot. Infatti, ho le dimensioni e la forma di un bambino, e come i bambini posso imparare cose nuove."
    wait_till_quiet
}

sequence_03() {
    speak "Sono nato circa 10 anni fa, all'Istituto Italiano di Tecnologia."
    wait_till_quiet
    speak "Gli ingegneri che mi hanno costruito mi hanno insegnato moltissimo in questi anni."
    wait_till_quiet
}

sequence_04() {
    speak "Posso riconoscere gli oggetti intorno a me ed afferrarli, e posso usarli per svolgere alcuni semplici compiti."
    wait_till_quiet
    speak "Da poco, ho imparato a stare in equilibrio senza cadere, e presto imparero' a camminare, proprio come voi."
    wait_till_quiet 
    speak "E poi sono l'unico robot al mondo dotato di una pelle sensibile, che mi permette di sentire quando vengo toccato, spinto o se mi fanno il solletico."
    wait_till_quiet
}

sequence_05() {
    speak "Si', pero', grazie ai ricercatori dell'Istituto Italiano di Tecnologia, ho 33 fratelli sparsi per il mondo, dagli Stati Uniti al Giappone, su cui lavorano scienziati di tutte le nazionalita'."
    wait_till_quiet
}

sequence_06() {
    speak "Potro' aiutarvi nei lavori domestici, o in altre attivita' delicate per cui avrete bisogno di supporto."
    wait_till_quiet
    speak "Come per esempio, l'assistenza degli anziani, o a persone disabili."
    wait_till_quiet
}

sequence_07() {
    speak "In questo momento, costo 250 mila euro, ma il mio progetto e' open sours."
    wait_till_quiet
    speak "Su internet si trovano i disegni per costruire il mio corpo, e il softuer per la base della mia intelligenza."
    wait_till_quiet
    speak "Anche se non e' facile costruirmi in casa."
    wait_till_quiet
    sleep 1.0
    smile
    sleep 1.5
    speak "In futuro costero' meno, come una piccola automobile, e potro' davvero aiutare le persone a casa e sul lavoro."
    wait_till_quiet
}

sequence_08() {
    speak "Si', Adele. Molto interessanti."
    wait_till_quiet
}

sequence_09() {
    speak "Grazie a te."
    wait_till_quiet
    speak "E un saluto a tutti i telespettatori del TG2!"
    hello_both
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



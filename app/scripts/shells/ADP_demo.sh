!/bin/bash
#######################################################################################
# ADP DEMO 10 OTT 2017
# Copyright: (C) 2017
# Author: Tanis Mar
# email:   tanis.mar@iit.it.com
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
# USEFUL FUNCTIONS:                                                                  #
#######################################################################################
usage() {
cat << EOF
***************************************************************************************
ADP_DEMO SCRIPTING
Author:  Alessandro Roncone   <tanis.mar@iit.it>

This script scripts through the commands available for the ADP_DEMO video.

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
# FUNCTIONS:                                                                         #
#######################################################################################
speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}

blink() {
    echo "blink" | yarp rpc /iCubBlinker/rpc
    sleep 0.5
}

breathers() {
    # echo "$1"  | yarp rpc /iCubBlinker/rpc
    echo "$1" | yarp rpc /iCubBreatherH/rpc:i
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

head() {
    echo "$1" | yarp rpc /iCubBreatherH/rpc:i
}

stop_breathers() {
    breathers "stop"
}

start_breathers() {
    breathers "start"
}

go_home_helper() {
    # This is with the arms close to the legs
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
    # This is with the arms over the table
    go_home_helperR $1
    go_home_helperL $1
    # echo "ctpq time 1.0 off 0 pos (0.0 0.0 10.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    go_home_helperH $1
}

go_home_helperL()
{
    # echo "ctpq time $1 off 0 pos (-30.0 36.0 0.0 60.0 0.0 0.0 0.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
}

go_home_helperR()
{
    # echo "ctpq time $1 off 0 pos (-30.0 36.0 0.0 60.0 0.0 0.0 0.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
}

go_home_helperH()
{
    echo "ctpq time $1 off 0 pos (0.0 0.0 5.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
}

go_homeH() {
    head "stop"
    go_home_helperH 1.5
    sleep 2.0
    head "start"
}

go_home() {
    breathers "stop"
    go_home_helper 2.0
    sleep 2.5
    breathers "start"
}

greet_with_right_thumb_up() {
    breathers "stop"
    echo "ctpq time 1.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home_helper 1.5
    sleep 2.0
    breathers "start"
}

greet_with_left_thumb_up() {
    breathers "stop"
    echo "ctpq time 2.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home_helperL 1.5
    breathersL "start"
    head "start"
}

greet_like_god() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.0
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    # speak "Buongiorno capo!"
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc

    # echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    # echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc

    # echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/right_arm/rpc
    # echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc
    # sleep 1.5 && smile
    sleep 1.0 && smile

    go_home_helper 2.0
}

hold_pennello() {
    echo "TODO"
}

smolla_pennello() {
    echo "TODO"
}

grasp_apple() {
    echo "ctpq time 1.5 off 0 pos (-46.0 27.0 -2.0 65.0 -80.0 -24.0 11.0 17.0 87.0 0.0 52.0 14.0 77.0 13.0 73.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
}

release_apple() {
    echo "release_apple TODO"
}

mostra_muscoli() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    speak "Dei supereroi"
    sleep 3.0
    smile
    go_home_helper 2.0
    breathers "start"
}

graspa_volante() {
    # echo "ctpq time 1.5 off 0 pos (-45.0 19.0 11.0 55.0 2.0 -3.0 -17.0 12.0 53.0 0.0 91.0  61.0 106.0 71.0 114.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    # echo "ctpq time 1.5 off 0 pos (-45.0 19.0 11.0 58.0 2.0 -5.0 -9.0  10.0 54.0 2.0 106.0 64.0 111.0 61.0 100.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc

    breathers "stop"

    echo "ctpq time 1.5 off 0 pos (0.0 -15.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.5 off 0 pos (0.0 -15.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1.5 off 0 pos (0.0  15.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.5 off 0 pos (0.0  15.0 0.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 1.5 off 0 pos (0.0  0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 1.5 off 0 pos (0.0  0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2.0 && blink
    sleep 2.0 && blink
    smile
    head "start"
}


buongiorno_capo() {
    # speak "Buongiorno? capo!"
    speak "Bentornato. capo!"
    sleep 1.0 # && blink
    sleep 0.5 && smile
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

ciao() {
    speak "Ciao! Mi chiamo aicab."
}

vai_nello_spazio() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-42.0 36.0 -12.0 101.0 -5.0 -5.0 -4.0 17.0 57.0 87.0 140.0 0.0 0.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    smile
    go_home
}

meteo_bot() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-55.0 49.0 -4.0 77.0 73.0   0.0 15.0 21.0 40.0 30.0 91.0 5.0 35.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 30.0 0.0 -10.0 10.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2.0
    echo "ctpq time 0.8 off 0 pos (-70.0 47.0 -3.0 55.0 81.0 -11.0  5.0 21.0 40.0 30.0 91.0 5.0 35.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 30.0 0.0 -10.0 5.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.8 off 0 pos (-55.0 49.0 -4.0 77.0 73.0   0.0 15.0 21.0 40.0 30.0 91.0 5.0 35.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.0 && blink
    smile
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 0.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    blink
    go_home
}

saluta() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0 # && speak "Salve colleghi."
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    go_home
    smile
}

closing_remarks() {
    meteo_bot
    speak "Da aicab e' tutto. Fascicolo $1 terminato."
    sleep 1.5 && blink
    sleep 3.0 && blink && smile
    speak "In bocca al lupo meikers"
    smile
    greet_with_right_thumb_up
    smile
}

no_testa() {
    head "stop"
    echo "ctpq time 0.5 off 0 pos (0.0 0.0  15.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (0.0 0.0  -5.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (0.0 0.0  15.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (0.0 0.0  -5.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time 0.5 off 0 pos (0.0 0.0   5.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    head "start"
    go_home
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


show_iit() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-27.0 64.0 -30.0 62.0 -58.0 -32.0 4.0 17.0 11.0 21.0 29.0 8.0 9.0 5.0 11.0 1.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-27.0 64.0 -30.0 62.0 -58.0 -32.0 4.0 17.0 11.0 21.0 29.0 8.0 9.0 5.0 11.0 1.0)" | yarp rpc /ctpservice/left_arm/rpc

    sleep 3.0
    smile

    go_home
    breathers "start"
}

attacco_grafica() {
    head "stop"
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 30.0 0.0 -10.0 5.0)" | yarp rpc /ctpservice/head/rpc
    speak "$1"
    sleep 2.0
    go_homeH
}

look_you_old() {
    breathers "stop"
    echo "set track 0" | yarp rpc /iKinGazeCtrl/rpc
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    echo "set reb neu" | yarp rpc /icub/face/emotions/in
    echo "set leb neu" | yarp rpc /icub/face/emotions/in
    echo "ctpq time 0.2 off 7 pos (38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-46.0 16.0 25.0 100.0 -44.0 0.0 0.0 38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5
    echo "ctpq time 0.7 off 0 pos (-13.0 -1.0 0.0 19.0 0.0 9.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.5
    echo "set track 1" | yarp rpc /iKinGazeCtrl/rpc
    echo "set all ang" | yarp rpc /icub/face/emotions/in
    echo "ctpq time 1.0 off 0 pos (-77.0 16.0 10.0 47.0 82.0 -23.0 7.0 38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}

look_you() {
    breathers "stop"

    echo "ctpq time 1.2 off 0 pos (-50.0 0.0 18.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 1.4
    #echo "set track 0" | yarp rpc /iKinGazeCtrl/rpc
    echo "set mou neu" | yarp rpc /icub/face/emotions/in
    echo "set reb neu" | yarp rpc /icub/face/emotions/in
    echo "set leb neu" | yarp rpc /icub/face/emotions/in
    echo "ctpq time 0.2 off 7 pos (38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-24.0 24.0 -9.0 106.0 -43.0 16.0 -10.0 38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.0
    look_at -0.15 -0.7 0.12
    sleep 0.5
    #echo "set track 1" | yarp rpc /iKinGazeCtrl/rpc
    echo "set all ang" | yarp rpc /icub/face/emotions/in
    echo "ctpq time 1.0 off 0 pos (-61.0 37.0 -16.0 52.0 87.0 -28.0 11.0 38.0 61.0 44.0 138.0 43.0 2.0 46.0 2.0 240.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5
    echo "set all hap" | yarp rpc /icub/face/emotions/in
    sleep 1.0
    echo "ctpq time 1.5 off 0 pos (0.0 34.0 4.0 69.0 9.0 0.0 -1.0 54.0 30.0 9.0 49.0 33.0 49.0 30.0 26.0 73.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.6
}

cun() {
    echo "set reb cun" | yarp rpc /icub/face/emotions/in
    echo "set leb cun" | yarp rpc /icub/face/emotions/in
}

angry() {
    echo "set all ang" | yarp rpc /icub/face/emotions/in
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

#######################################################################################
# SEQUENCE:                                                                         #
#######################################################################################
buongiorno(){
  greet_like_god
  "Buongiorno a tutti e benvenuti alla conferenza A D P 5.0; Verso un nuovo equilibrio tra lavoro, tecnologia e persone!"
  breathers "start"
}

sono_icub(){
  fonzie
  speak "Io sono aicab, un robot umanoide ideato dall’Istituto italiano di tecnologia."
  breathers "start"

}

noi_robot(){
  show_iit
  speak "Oggi mi piacerebbe mostrarvi come noi robot collaboriamo e cooperiamo con voi umani."
  breathers "start"
}

questo_film(){
  look_you_old
  speak "In questo breve filmato vi mostrerò come le mie capacità si siano evolute nel corso degli anni e come man mano ho imparato a relazionarmi col vostro mondo per potervi assistere in futuro."
  breathers "start"
}

buon_prosegui() {
  saluta
  speak "Buon proseguimento, e arrivederci!"
  breathers "start"
}

sequence(){
  greet_like_god  
  "Buongiorno a tutti e benvenuti alla conferenza A D P 5.0; Verso un nuovo equilibrio tra lavoro, tecnologia e persone!"
  wait_till_quiet

  fonzie
  speak "Io sono aicab, un robot umanoide ideato dall’Istituto italiano di tecnologia."
  wait_till_quiet

  show_iit
  speak "Oggi mi piacerebbe mostrarvi come noi robot collaboriamo e cooperiamo con voi umani."
  wait_till_quiet

  look_you_old
  speak "In questo breve filmato vi mostrerò come le mie capacità si siano evolute nel corso degli anni e come man mano ho imparato a relazionarmi col vostro mondo per potervi assistere in futuro."
  wait_till_quiet

  speak "La visita preseguirà con una dimostrazione di collaborazione reale tra uomo e macchina in una attività di lavoro manuale, ed infine con un' applicazione in ambito medicale, dove la macchina supporta l’uomo in tutti i sensi!"
  wait_till_quiet

  saluta
  speak "Buon proseguimento, e arrivederci!"
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

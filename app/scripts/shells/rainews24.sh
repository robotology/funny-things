#!/bin/bash
#######################################################################################
# FLATWOKEN ICON THEME CONFIGURATION SCRIPT
# Copyright: (C) 2014 FlatWoken icons
# Authors:  Tanis Mar and Raffaello Camoriano
# email:   tanis.mar@iit.it
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
# FUNCTIONS:                                                                         #
#######################################################################################

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


speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}


guarda_bisio_on() {
    stop_breathers
    #guardare
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 10.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
}
guarda_bisio_off() {
    go_home_helperH 2.0
    start_breathers
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

go_home_helper_nohead() {
    # This is with the arms close to the legs
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
    # This is with the arms over the table
    go_home_helperR $1
    go_home_helperL $1
    # echo "ctpq time 1.0 off 0 pos (0.0 0.0 10.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    echo "ctpq time $1 off 0 pos (0.0 0.0 15.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
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
    echo "ctpq time $1 off 0 pos (0.0 0.0 0.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
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
    sleep 4.5
    breathers "start"
}

go_home_nohead() {
    breathers "stop"
    go_home_helper_nohead 2.0
    sleep 2.5
    breathers "start"
}

greet_with_left_thumb_up() {
    echo "ctpq time 2.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home_helperL 1.5
}

greet_with_right_thumb_up() {
    echo "ctpq time 2.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home_helperR 1.5
}

greet_like_god() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    speak "Bentornato. capo!"
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc

    sleep 1.0 && smile

    go_home_helper 2.0
    breathers "start"
}

mostra_muscoli() {
    breathers "stop"
    echo "ctpq time 3.5 off 0 pos (-27.0 75.0 -20.0 93.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
   # echo "ctpq time 3.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    read -p "waiting for enter"
    speak "Ballaro!" 
    echo "ctpq time 2.0 off 0 pos (-27.0 75.0 -20.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
 #   echo "ctpq time 4.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.5
    go_home_helper 2.5
    sleep 3.0    
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


#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
sieteArrivati() {
    speak "Finalmente siete arrivati!"
    go_home
}

ciaoClaudio() {
    breathers "stop"
    sleep 0.5
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 15.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    speak "Ciao Claudio."
    #go_home
    sleep 0.5
    breathers "start"
}

cosaComune() {
    #speak "Si. E io e te abbiamo anche un altra cosa in comune!"
    speak "Parlo con te, perche' abbiamo una cosa in comune!"
}


laTesta() {
    speak "No ...  Lo stesso taglio di capelli!"
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-17.0 77.0 -31.0 105.0 -33.0 30.0 -24.0 0.0 0.0 0.0 0.0 0.0 15.0 60.0 105.0 170.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0      
    smile
    sleep 1.0
    go_home_nohead
    breathers "start"
}

rispostaNome() {
    speak "Aicab!"
}

rispostaAnni() {
    speak "Dieci."
}

soGiaTuttoAI() {
    speak "Io so gia tutto. Sono un'intelligenza artificiale!"
}

rispostaCalcolo() {
    speak "Quattordici milioni cinquecentoquattordicimila e settecento" #14.514.700 - 14 514 700
}

pirla() {
    speak "Mi hai preso per pirla?"
}

capitaleParaguay() {
    speak "Asun sion'!"
    go_home_nohead
}

daGenova() {
    speak "Veramente io, vengo da Genova. Bel in!"
}

istituto() {
    speak "No. dall'istituto italiano di tecnologia"
}

sfida() {
    speak "Sono qui per sfidarti"
}

sfidaTaiChi() {
    speak "No. sono qui per sfidarti, a  TAI CI!"
}

sali() {
    speak "E allora, sali, se hai coraggio!"
}

seiPronto() {
    speak "Sei pronto?"
}


nostreParti() {
    speak "Dalle nostre parti si dice" 
#    sleep 3.0 
#    speak "Tutti attendono" 
}

ufo() {
    speak "Oggetto non identificato" 
}


intuito() {
    speak "Beh, l'avevo intuito"
}



rispostaTalento() {
    speak "Per dimostrare il mio talento!"
}

rispostaTaiChi() {
    speak "No. Il Tai-ci! La mia passione!"
}

nonSoloTaiChi() {
    speak "Ma questo non e' solo TAI CI, e' una posizione che permette di entrare in contatto con l'origine dell'Universo!!"
}

salite() {
    speak "E allora salite ... perche'  fatti non foste a vivere come bruti, ma per seguir  virtute e canoscenza!!"
}

risposta() {
    speak "Si, anche noi robot ogni tanto ci facciamo male..."
    sleep 4.3
    sad
    sleep 1.0
    smile
    speak "ma non e' nulla di grave, spero di guarire presto"
    sleep 4.5
    smile
    
}



#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################





saluta() {
    breathers "stop"
    echo "ctpq time 2.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 2.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
#    sleep 2.0
#    speak "Ciao a tutti gli amici di Rai nius ventiquattro!"
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    sleep 0.5
    speak "Si, anche noi robot ogni tanto ci facciamo male..."
    breathers "stop"
    go_home_helper 2.0
    sleep 6.8
    sad
    sleep 1.0
    smile
    speak "ma non e' nulla di grave, spero di guarire presto"
    sleep 4.5
    smile
}

saluta_muto() {
    breathers "stop"
    echo "ctpq time 2.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    sleep 0.5
    go_home
    smile
}

saluta_loop() {
for i in `seq 1 100`;
        do
    breathers "stop"
    echo "ctpq time 2.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    sleep 0.5
    go_home
    smile
    breathers "stop"
    echo "ctpq time 2.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile
    sleep 0.5
    go_home
    smile
    breathers "stop"
    echo "ctpq time 2.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile
    sleep 0.5
    go_home
    smile
sleep 15
done
}

        

        \  


saluta_muto_destro() {
    breathers "stop"
    echo "ctpq time 2.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile
    sleep 0.5
    go_home
    smile
}

saluta_finale() {
    breathers "stop"
    echo "ctpq time 2.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    speak "Arrivederci a tutti . linea allo studio!"
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile
    sleep 0.5
    go_home
    smile
}



#######################################################################################
# Story board                                                                       #
#######################################################################################

scene_pause() 
{

    read -p "waiting for enter (saluta e risposta)"
    salutaRisposta
    read -p "waiting for enter (saluta_finale)"
    saluta_finale
}

salutaRisposta()
{
    saluta
}

scene_end() {
    mostra_muscoli
    saluta
}

scene_all() 
{
    scene_0
    scene_1
    sleep 5.0 && scene_2
    scene_3
    sleep 5.0 && scene_4
    sleep 2.0 && scene_5
    sleep 4.0 && scene_6
    sleep 1.0 && scene_7
    sleep 3.0 && scene_8
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




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
speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}

blink() {
    echo "blink_single" | yarp rpc /iCubBlinker/rpc
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
    speak "Bentornato. capo!"
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

graspa_pallina() {
    breathers "stop"
    echo "ctpq time 2.0 off 0 pos (-38.0 25.0 25.0 45.0 59.0 -11.0 -20.0 30.0 28.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.75 off 0 pos (-30.0 0.0 -15.0 -10.0 0.0 10.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2.5
    echo "ctpq time 1.5 off 0 pos (-38.0 25.0 25.0 45.0 59.0 -11.0 -20.0 30.0 90.0 0.0 70.0 60.0 80.0 60.0 80.0 215.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5
    speak "$1"
    echo "ctpq time 1.5 off 0 pos (-38.0 48.0 7.0 71.0 -11.0 0.0  2.0 30.0 90.0 0.0 70.0 60.0 80.0 60.0 80.0 215.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-20.0 0.0 -25.0 -10.0 10.0 10.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2.0
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 0.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
}

smolla_pallina() {
    echo "ctpq time 1.5 off 0 pos (-38.0 25.0 25.0 45.0 59.0 -11.0 -20.0 30.0 90.0 0.0 70.0 60.0 80.0 60.0 80.0 215.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile && sleep 1.5 && smile
    echo "ctpq time 1.5 off 0 pos (-38.0 25.0 25.0 45.0 59.0 -11.0 -20.0 30.0 28.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    go_home_helper 2.0
    smile
    breathers "start"
}

passa_e_chiudi() {
    speak "aicab passa e chiude."
    sleep 2.0 && blink
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
    sleep 2.0 && speak "Salve colleghi."
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

attacco_grafica() {
    head "stop"
    echo "ctpq time 1.0 off 0 pos (0.0 0.0 30.0 0.0 -10.0 5.0)" | yarp rpc /ctpservice/head/rpc
    speak "$1"
    sleep 2.0
    go_homeH
}

cun() {
    echo "set reb cun" | yarp rpc /icub/face/emotions/in
    echo "set leb cun" | yarp rpc /icub/face/emotions/in
}

angry() {
    echo "set all ang" | yarp rpc /icub/face/emotions/in
}

#######################################################################################
# RUBRICA  1:                                                                         #
#######################################################################################
    rubrica1_1() {
        greet_like_god
        breathers "start"
        speak "Oggi, aicab e' andato a caccia di novita' sulle quattro ruote."
        sleep 1.0 && blink
        sleep 2.5 && blink
        sleep 1.0 && smile
    }

    rubrica1_2() {
        speak "Capo? ci pensi?"
        sleep 1.0 && blink
        sleep 1.0 && smile
        speak "E' stata usata una stampante 3D? proprio come quelle del laboratorio degli X meikers!"
        sleep 4.0 && blink
        speak " Solo? Un po' piu' grande."
        sleep 6.0 && smile # && blink
    }

    rubrica1_3a() {
        speak "Cosi', anche chi guida potra' schiacciare un pisolino durante il viaggio."
        graspa_volante
    }

    rubrica1_3b() {
        speak "Per oggi dal dipartimento ricerca e' tutto."
        sleep 2.0 # && blink
        passa_e_chiudi
        sleep 1.0
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  2:                                                                         #
#######################################################################################
    rubrica2_1() {
        greet_like_god
        breathers "start"
        speak "Oggi, aicab ha fatto un corso accelerato di cucina? per saperne di piu' su quello che voi chiamate cibo."
        speak "Preparatevi? Resterete? a bocca aperta!"
        sleep 1.0 && blink
        sleep 2.5 && blink
        sleep 4.0 && blink
        go_home
        breathers "stop"
        sleep 0.5 && surprised
        sleep 1.5 && smile
        breathers "start"
    }

    rubrica2_2() {
        speak "aicab ha sentito dire? che voi umani andate matti per questa cioccolata..."
        sleep 4.0 && blink
        sleep 2.0 && smile
    }

    rubrica2_3() {
        speak "Pensa capo, un giorno questa mela potrebbe avere il gusto di ba na na!"
        breathers "stop"
        echo "ctpq time 1.0 off 0 pos (-20.0 0.0 -30.0 0.0 10.0 10.0)" | yarp rpc /ctpservice/head/rpc
        sleep 3.0
        echo "ctpq time 1.0 off 0 pos (0.0 0.0 0.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        sleep 3.0
        speak "Anche per oggi, dal reparto Ricerca e Innovazione e' tutto."
        head "stop"
        go_home_helperH 1.5
        passa_e_chiudi
        greet_with_left_thumb_up
        sleep 1.5 && smile
    }

#######################################################################################
# RUBRICA  3:                                                                         #
#######################################################################################
    rubrica3_1() {
        greet_like_god
        breathers "start"
        speak "Oggi, aicab ha scovato delle novita' che nel giro di qualche anno renderanno voi umani"
        sleep 3.0 # && blink
        mostra_muscoli
    }

    rubrica3_2() {
        speak "E ora Capo. il potere che tutti vorrebbero."
        sleep 4.0 && blink
        speak "La telecinesi. La capacita' di controllare gli oggetti con la mente."
        sleep 2.0 && blink
    }

    rubrica3_3() {
        speak "Certo che a quel punto, perdersi tra i pensieri potrebbe diventare un problema."
        sleep 6.0 # && blink
        speak "Anche per oggi, dal reparto Ricerca e Innovazione e' tutto."
        sleep 4.0 # && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  4:                                                                         #
#######################################################################################
    rubrica4_1() {
        greet_like_god
        speak "Oggi, aicab e' andato a caccia di primati robotici!"
        sleep 2.0 # && blink
        breathers "start"
    }

    rubrica4_2() {
        speak "Peraltro, non e' il solo ad aver battuto ogni record. Vi presento altri due fuoriclasse."
        sleep 1.0 && blink
    }

    rubrica4_3() {
        speak "Anche per questa volta e' tutto."
        sleep 3.0 # && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  5:                                                                         #
#######################################################################################
    rubrica5_1() {
        greet_like_god
        speak "Oggi aicab vi presentera' alcuni colleghi robotici che hanno delle doti da veri artisti."
        sleep 2.0 # && blink
        breathers "start"
    }

    rubrica5_2() {
        speak "Strepitosi. Ma ora si cambia disciplina."
        sleep 1.5 && blink
    }

    rubrica5_3() {
        speak "aicab e' gia' innamorato."
        sleep 3.0
        smile && sleep 1.0
        speak "Anche per questa volta e' tutto? capo."
        sleep 3.0 # && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  6:                                                                         #
#######################################################################################
    rubrica6_1() {
        greet_like_god
        speak "Oggi, aicab vi portera' alla scoperta delle citta' del futuro."
        sleep 2.0 # && blink
        breathers "start"
    }

    rubrica6_2() {
        speak "Ed ora un'innovazione che e' gia' diventata realta'."
        sleep 4.0 # && blink
    }

    rubrica6_3() {
        speak "Anche per questa volta e' tutto? capo."
        sleep 3.0 # && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  7:                                                                         #
#######################################################################################
    rubrica7_1() {
        greet_like_god
        breathers "start"
        speak "Oggi, aicab ha preparato un fascicolo sulle innovazioni nel mondo dello sport."
        sleep 1.0 && blink
        sleep 4.0 && blink
        sleep 1.0 && smile
    }

    rubrica7_2() {
        graspa_pallina "Lo scopo e' correggere gli errori e migliorare? partita dopo partita."
        smile && sleep 2.0 && smile
        smolla_pallina
        speak "Per finire, aicab vuole presentarvi alcuni amici."
        sleep 2.0 && blink
        sleep 3.0 && smile
    }

    rubrica7_3() {
        speak "Capo, anche per oggi e' tutto."
        sleep 3.0 # && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  8:                                                                         #
#######################################################################################
    rubrica8_1() {
        greet_like_god
        speak "Oggi, aicab ha analizzato a fondo alcuni problemi di voi umani. e ha scoperto ottime soluzioni tecnologiche. Un esempio? Come riparare oggetti rotti ed evitare sprechi."
        sleep 1.0 && blink
        breathers "start"
        sleep 4.0 && blink
        sleep 4.0 && blink
    }

    rubrica8_2() {
        speak "Capo. c'e' un'altra cosa che aicab ha scoperto, studiando le abitudini di voi umani."
        sleep 6.0 # && blink
        speak "C'e' un passatempo che accomuna generazioni e generazioni di studenti. Gli aereoplanini di carta."
        sleep 6.0 # && blink
        speak "Beh, ci sono buone novita'"
    }

    rubrica8_3() {
        speak "Dal reparto ricerca e innovazione, e' tutto."
        sleep 3.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  9:                                                                         #
#######################################################################################
    rubrica9_1() {
        greet_like_god
        speak "Oggi, aicab vi dimostrera' che arte e tecnologia non sono due mondi poi cosi' distanti."
        sleep 1.0 && blink
        breathers "start"
    }

    rubrica9_2() {
        speak "Come un vero artista? Anche i- deevid firma le sue opere."
        sleep 2.0 && blink
        sleep 2.0 && blink
        speak "Per finire, una curiosita' sull'arte della parola"
        sleep 1.0 && blink
        sleep 2.0 && smile
    }

    rubrica9_3() {
        speak "Anche per oggi e' tutto."
        sleep 2.0 # && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA 10:                                                                         #
#######################################################################################
    rubrica10_1() {
        greet_like_god
        speak "Oggi, aicab vi porta nello spazio."
        sleep 1.0 && blink
        vai_nello_spazio
    }

    rubrica10_2() {
        speak "Ed ora? arriva il bello. Capo? hai mai pensato di fare le vacanze nello spazio?"
        sleep 2.0 && blink
        sleep 3.0 && blink
        speak "In America esistono diversi progetti di turismo spaziale."
        sleep 4.0 && blink
    }

    rubrica10_3() {
        speak "Dal reparto ricerca e innovazione, e' tutto."
        sleep 3.0 # && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# PUNTATA  1:                                                                         #
#######################################################################################
    puntata1_1() {
        saluta
        speak "aicab ha svolto una ricerca in rete. e ha intervistato centinaia di ragazzi per capire cosa desiderino e quali siano i loro problemi con i monopattini."
        sleep 3.0 && blink
        sleep 4.0 && blink
        sleep 2.5 && blink
        speak "Ecco i risultati."
        meteo_bot
    }

    puntata1_2() {
        speak "Ecco i risultati."
        meteo_bot
        speak "Il 40 percento dei ragazzi? vorrebbe avere un monopattino speciale diverso da tutti gli altri. Quasi tutti vorrebbero che raccontasse qualcosa di loro."
        sleep 2.0 && blink
        sleep 3.0 && blink
        sleep 3.0 && blink
        sleep 2.0 && smile
    }

    puntata1_3() {
        attacco_grafica "Il 70% dei ragazzi ha rilevato? nei normali monopattini, un grosso difetto: utilizzarli a lungo e' molto faticoso."
        sleep 3.0 && blink
        sleep 3.0 && blink
        speak "aicab non conosce la fatica? ma ha capito che non e' una cosa bella."
        no_testa
        sleep 3.0 && sad
        sleep 2.0 && smile
    }

    puntata1_4() {
        attacco_grafica "Infine? il 60% degli intervistati vorrebbe un monopattino piu' ricco di funzionalita'. Alcuni vorrebbero addirittura che fosse vivo come un animale domestico. O, un robot."
        sleep 2.0 && blink
        sleep 3.0 && blink
        sleep 3.0 && blink
        smile
        fonzie
        smile
        meteo_bot
    }

    puntata1_c() {
        closing_remarks "02 X 2 3"
    }

#######################################################################################
# PUNTATA  2:                                                                         #
#######################################################################################
    puntata2_1() {
        saluta
        speak "aicab ha chiesto a tutti i suoi amici sui social network d'immaginare come saranno i vestiti del futuro. E ha raccolto molti dati interessanti:"
        sleep 3.0 && blink
        sleep 4.0 && blink
        sleep 2.5 && blink
        speak "Ecco i risultati."
        meteo_bot
    }

    puntata2_2() {
        speak "Ecco i risultati."
        meteo_bot
        speak "Il 55 percento di loro? pensa che ogni abito sara' unico e speciale. Avra' degli accessori in grado di distinguere chi lo indossa! Insomma, nel futuro tutti si vestiranno come aicab!"
        sleep 4.0 && blink
        sleep 3.0 && blink
        sleep 3.0 && blink
        fonzie
    }

    puntata2_3() {
        attacco_grafica "Il 60 percento spera, in futuro? di indossare vestiti intelligenti? Capaci di cambiare e modificarsi in risposta agli stimoli dell'ambiente esterno."
        sleep 2.0 && blink
        sleep 2.0 && blink
        sleep 5.0 && blink
    }

    puntata2_4() {
        attacco_grafica "Infine? il 70 percento dei ragazzi? pensa che i vestiti di oggi siano troppo noiosi. Gli indumenti di domani dovranno essere interattivi e divertenti!"
        sleep 3.0 && blink
        sleep 2.0 && blink
        sleep 2.0 && blink
    }

    puntata2_5() {
        breathers "stop"
        echo "ctpq time 1.5 off 0 pos (-42.0 36.0 -12.0 101.0 85.0 -45.0 -4.0 17.0 57.0 87.0 140.0 0.0 0.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
        sleep 2.5
        go_home_helperR 2.0
        speak "Divertimento. Operazione mediante cui un essere umano trascorre il suo tempo in modo piacevole."
        sleep 1.0 && blink
        sleep 4.0 && blink
        echo "set leb cun" | yarp rpc /icub/face/emotions/in
        echo "set reb cun" | yarp rpc /icub/face/emotions/in
        sleep 0.5 && smile
        sleep 0.5 && smile
        echo "set leb cun" | yarp rpc /icub/face/emotions/in
        echo "set reb cun" | yarp rpc /icub/face/emotions/in
        smile
        go_home
    }

    puntata2_c() {
        closing_remarks "0 3 FT2"
    }

    puntata2_total() {
        puntata2_2
        puntata2_3
        puntata2_4
        puntata2_5
        puntata2_c
    }

#######################################################################################
# PUNTATA  3:                                                                         #
#######################################################################################
    puntata3_1() {
        saluta
        speak "aicab ha svolto una ricerca molto approfondita sulle macchine telecomandate; e ha scoperto alcuni punti deboli che possono essere migliorati."
        sleep 3.0 && blink
        sleep 3.0 && blink
        sleep 1.0 && blink
        speak "Ecco i risultati."
        meteo_bot
    }

    puntata3_2() {
        speak "Ecco i risultati."
        meteo_bot
        speak "Le macchinine si bloccano quando affrontano alcuni tipi di terreno, come la ghiaia, il fango? o i tappeti. Il 67% dei ragazzi lo trova insopportabile."
        sleep 4.0 && blink
        sleep 2.0 && blink
        sleep 6.0 && blink
    }

    puntata3_3() {
        attacco_grafica "Secondo l'82% dei ragazzi? pero'? il problema piu' grande sono le scale. Davanti a una scala, anche i modelli piu' avanzati devono fermarsi."
        sleep 2.0 && blink
        sleep 3.0 && blink
        sleep 1.0 && blink
        sleep 3.0 && blink
        speak "Forse dovrebbero avere un sistema motorio avanzato come aicab!"
        sleep 3.0
        fonzie
        echo "set leb cun" | yarp rpc /icub/face/emotions/in
        echo "set reb cun" | yarp rpc /icub/face/emotions/in
        sleep 0.5 && smile
        sleep 0.5 && smile
        echo "set leb cun" | yarp rpc /icub/face/emotions/in
        echo "set reb cun" | yarp rpc /icub/face/emotions/in
        sleep 0.5 && smile
    }

    puntata3_4() {
        attacco_grafica "Infine? secondo le analisi di aicab! il 60 percento dei ragazzi vorrebbe giocare con la macchina telecomandata anche di sera, E pilotarla senza perderla mai di vista."
        sleep 1.0 && blink
        sleep 1.0 && blink
        sleep 3.0 && blink
    }

    puntata3_c() {
        closing_remarks "3 6 TL 2 4"
    }

    puntata3_total() {
        puntata3_2
        puntata3_3
        puntata3_4
        puntata3_5
        puntata3_c
    }

#######################################################################################
# PUNTATA  4:                                                                         #
#######################################################################################
    puntata4_1() {
        saluta
        speak "aicab ha svolto un'indagine molto approfondita tra i ragazzi; e ha scoperto che la maggior parte di loro ha un televisore in cameretta. I vostri sforzi devono concentrarsi li'."
        sleep 3.0 && blink
        sleep 3.0 && blink
        sleep 2.5 && blink
        meteo_bot
    }

    puntata4_2() {
        meteo_bot
        speak "Il 50 percento dei ragazzi vorrebbe un televisore meno anonimo, piu' colorato? piu' giocoso? piu' adatto allo stile delle loro camerette."
        sleep 4.0 && blink
        sleep 4.0 && blink
    }

    puntata4_3() {
        attacco_grafica "Il 60 percento invece ha confessato di aver sempre paura che la mamma li sorprenda a guardare la tv di nascosto."
        sleep 3.0 && blink
        breathers "stop"
        echo "ctpq time 1.5 off 0 pos (-42.0 36.0 -12.0 101.0 85.0 -45.0 -4.0 17.0 57.0 87.0 140.0 0.0 0.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
        sleep 2.5
        speak "A quanto pare, la specie mamma? e' ostile ai guardatori di tv."
        go_home_helperR 2.0
        go_home_helperH 2.0
        sleep 2.0
        breathers "start"
    }

    puntata4_4() {
        attacco_grafica "Infine, il 60 percento dei ragazzi perde il telecomando almeno una volta al giorno. La percentuale sale al 90 percento tra i ragazzi particolarmente disordinati che lasciano vestiti e giocattoli in giro."
        sleep 3.0 && blink
        sleep 6.0 && blink
    }

    puntata4_c() {
        closing_remarks "0 5 ics, 1 2"
    }

#######################################################################################
# PUNTATA  5:                                                                         #
#######################################################################################
    puntata5_1() {
        saluta
        speak "aicab ha confrontato migliaia di data beisz, e analizzato milioni di interviste. I dati? indicano che nei tablet ci sono ancora diverse cose che possono essere migliorate."
        sleep 3.0 && blink
        sleep 4.0 && blink
        sleep 3.0 && blink
        meteo_bot
    }

    puntata5_2() {
        meteo_bot
        speak "Il 70 percento degli umani vorrebbe un taabl-et in grado di distinguersi dalla massa. Dovrebbe farsi notare anche quando non lo si usa."
        sleep 3.0 && blink
        sleep 7.0 && blink
    }

    puntata5_3() {
        attacco_grafica "Il dato piu' sorprendente, e' che il 90 percento degli intervistati sogna un taabl-et capace di comunicare con il mondo esterno. I ragazzi vorrebbero che il gioco uscisse dallo schermo. Digitale e analogico allo stesso tempo. Vorrebbero che il tabl-et fosse come aicab"
        echo "set leb cun" | yarp rpc /icub/face/emotions/in
        echo "set reb cun" | yarp rpc /icub/face/emotions/in
        sleep 2.0 && smile
        sleep 10.0
        fonzie
    }

    puntata5_4() {
        attacco_grafica "Infine? il 79% vorrebbe poter condividere quello che c'e' sullo schermo con i propri amici, anche quando gli amici sono tanti e sono tutti nello stesso posto."
        sleep 1.0 && blink
        sleep 3.0 && blink
    }

    puntata5_c() {
        closing_remarks "1 9 t 6 2"
    }

#######################################################################################
# PUNTATA  6:                                                                         #
#######################################################################################
    puntata6_1() {
        saluta
        speak "aicab ha svolto; la sua ricerca in rete? e ha intervistato migliaia di bambini, per la precisione 8306? per capire come debba essere la bicicletta ideale. Ecco i risultati."
        sleep 3.0 && blink
        sleep 4.0 && blink
        sleep 5.5 && blink
        meteo_bot
    }

    puntata6_2() {
        speak "Ecco i risultati."
        meteo_bot
        speak "Il 70 percento dei ragazzi vorrebbe una bicicletta aggressiva, simile a una moto. I ragazzi la definiscono tosta? anche se aicab non capisce il significato di questa parola."
        sleep 5.0 && blink
        sleep 4.0 && no_testa
        echo "set reb cun" | yarp rpc /icub/face/emotions/in
        echo "set leb cun" | yarp rpc /icub/face/emotions/in
        sleep 3.0 && smile
    }

    puntata6_3() {
        attacco_grafica "Secondo la meta' degli intervistati? la bici perfetta dovrebbe essere imbattibile e super accessoriata. Piu' o meno come la macchina di zero zero sette, ma in versione bici."
        sleep 2.0 && blink
        sleep 3.0 && blink
    }

    puntata6_4() {
        attacco_grafica "L'ultimo dato? il 60 percento dei ragazzi vorrebbe una bicicletta che riconosca il suo padrone. Una bici intelligente. Un po' come aicab."
        sleep 2.0 && blink
        sleep 2.0 && smile && sleep 0.5 && blink
    }

    puntata6_c() {
        closing_remarks "0 4 y 5 4"
    }

#######################################################################################
# PUNTATA  7:                                                                         #
#######################################################################################
    puntata7_1() {
        saluta
        speak "aicab ha raccolto milioni di Tera di dati? riguardo all'oggetto zzaino. E' uno degli oggetti piu' utilizzati dai ragazzi di tutto il mondo, e per molti e' come una seconda pelle."
        sleep 3.0 && blink
        sleep 4.0 && blink
        sleep 3.5 && blink
        meteo_bot
    }

    puntata7_2() {
        meteo_bot
        speak "Il 90 percento di loro vorrebbe che lo zaino fosse un oggetto divertente? e pieno di sorprese, come quello di Babbo Natale."
        sleep 2.0 && blink
    }

    puntata7_3() {
        speak "aicab non conosce questo Babbo Natale. Ma dev'essere un ciccione molto simpatico."
        sleep 0.5 && cun
        sleep 3.0 && smile
    }

    puntata7_4() {
        attacco_grafica "L'85 percento dei ragazzi dice che gli zaini di scuola sono troppo pesanti da portare in spalla e da trascinare. Il tragitto da casa a scuola? e' troppo faticoso."
        sleep 2.0 && blink
    }

    puntata7_5() {
        attacco_grafica "Per finire? il 65 percento sogna uno zaino da supereroe in grado di proteggerli dagli scherzi dei compagni, e soprattutto, dai bulli della scuola."
        sleep 2.0  && blink
        sleep 3.0  && angry
        sleep 2.25 && angry
        sleep 2.0  && smile
    }

    puntata7_c() {
        closing_remarks "s 3 uno t 4"
    }

#######################################################################################
# PUNTATA  8:                                                                         #
#######################################################################################
    puntata8_1() {
        saluta
        speak "aicab ha raccolto migliaia di tera baait di dati? e ha analizzato miliardi di siti specializzati per aiutarvi nella vostra missione."
        sleep 3.0 && blink
        sleep 3.5 && blink
        sleep 1.5 && blink
        meteo_bot
    }


    puntata8_2() {
        meteo_bot
        speak "Il sogno del 65 percento dei ragazzi e' possedere un giocattolo che assomigli a ciascuno di loro. E' per questo che, quando giocano, spesso fanno finta di essere un personaggio."
        sleep 3.0 && blink
        sleep 3.0 && blink
        sleep 3.0 && blink
    }

    puntata8_3() {
        attacco_grafica "Secondo i miei dati, tra i giocattoli piu' diffusi al mondo ci sono le macchinine. I ragazzi si sfidano in continuazione, e l'80 percento di loro vorrebbe avere tra le mani delle auto super veloci."
        sleep 3.0 && blink && sleep 3.0 && blink
    }

    puntata8_4() {
        attacco_grafica "Infine, vi segnalo un problema. Il 90 percento dei ragazzi ha avuto esperienze di giocattoli rotti o rubati da fratellini e amici dispettosi."
        sleep 7.0
        speak "Qui, c'e' un problema di sicurezza."
        breathersR "stop"
        echo "ctpq time 1.5 off 0 pos (-42.0 36.0 -12.0 101.0 85.0 -45.0 -4.0 17.0 57.0 87.0 140.0 0.0 0.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
        sleep 3.0 && cun
        go_home_helperR 1.5
        sleep 2.0 && smile
        breathersR "start"
    }

    puntata8_c() {
        closing_remarks "r 3 b 7 2"
    }

#######################################################################################
# PUNTATA  9:                                                                         #
#######################################################################################
    puntata9_1() {
        saluta
        speak "aicab ha svolto una ricerca in rete? e ha intervistato centinaia di ragazzi, per capire cosa vogliono veramente da una sveglia."
        sleep 3.0 && blink
        sleep 3.5 && blink
        sleep 1.5 && blink
        speak "Ecco i risultati."
        meteo_bot
    }

    puntata9_2() {
        speak "Ecco i risultati."
        meteo_bot
        speak "Il 55 percento vorrebbe che fosse bella, divertente, funzionale, simile a un robot. Ma attenzione, aicab non e' una sveglia!"
        sleep 10.0 && angry
        sleep 3.0 && smile
    }

    puntata9_3() {
        attacco_grafica "Il 70 percento dei ragazzi invece ha detto che la sveglia dovrebbe letteralmente buttarli giu' dal letto! Altrimenti e' troppo facile riaddormentarsi. E non va bene."
        sleep 6.0 && blink
        no_testa
    }

    puntata9_4() {
        attacco_grafica "Per finire, il 60 percento dei ragazzi vorrebbe una sveglia? intelligente. La mattina sono mezzi addormentati? e hanno bisogno di un aiuto per pianificare la giornata."
        sleep 3.0 && blink
        sleep 3.0 && blink
    }

    puntata9_c() {
        closing_remarks "0 5 ics p2 3"
    }

#######################################################################################
# PUNTATA 10:                                                                         #
#######################################################################################
    puntata10_1() {
        saluta
        speak "aicab ha trovato molte lamentele sui siti e sui forum dei campeggiatori. A quanto pare, nelle tende piu' comuni ci sono molti difetti da migliorare."
        sleep 3.0 && blink
        sleep 3.5 && blink
        sleep 1.5 && blink
        meteo_bot
    }

    no_campeggio() {
        breathers "stop"
        echo "ctpq time 1.5 off 0 pos (-40.0 38.0 -11.0 84.0 -46.0 -56.0 -20.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
        echo "ctpq time 1.5 off 0 pos (-40.0 38.0 -11.0 84.0 -46.0 -56.0 -20.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
        cun
        sleep 1.5
        go_home
        smile
    }

    puntata10_2() {
        meteo_bot
        speak "Il 70 percento dei ragazzi dice che la cosa piu' bella del campeggio e' stare a contatto con la natura? e che le tende troppo vistose rovinano l'atmosfera."
        sleep 4.0 && blink
        sleep 6.0 && blink
    }

    puntata10_3() {
        attacco_grafica "Il 90 percento? invece, e' stufo di portare con se' batterie e lampadine di ricambio per la luce. Una tenda dovrebbe avere l'elettricita'."
        sleep 6.5
        speak "Altrimenti aicab come fa ad andare in campeggio?"
        no_campeggio
        speak "Nessuno pensa a aicab?"
        head "stop"
        echo "ctpq time 1.5 off 0 pos (-15.0 0.0 5.0 15.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        sad && sleep 2.5 && sad
        sleep 3.0 && smile
        go_homeH
    }

    puntata10_4() {
        attacco_grafica "Infine, aicab ha scoperto che gli umani amano le sorprese. Ma non in campeggio. Il 65 percento infatti ha paura che ragni, insetti? e altri animali entrino di nascosto nella tenda."
        sleep 1.0 && blink
        sleep 3.0 && blink
    }

    puntata10_c() {
        closing_remarks "r 3 t 9"
    }

#######################################################################################
# SIGLA:                                                                              #
#######################################################################################
    sigla_1() {
        breathers "stop"
        echo "ctpq time 2.0 off 0 pos (-20.0 0.0 -30.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        sleep 4.0
        echo "ctpq time 2.0 off 0 pos (  0.0 0.0  25.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        sleep 1.0 && blink
        sleep 1.0 && blink
    }

    sigla_2() {
        breathers "stop"
        echo "ctpq time 2.0 off 0 pos (-20.0 0.0 -30.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        sleep 4.0
        echo "ctpq time 1.0 off 0 pos (  0.0 0.0  25.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        sleep 0.5 && blink
        sleep 0.5 && blink
    }

    sigla_3() {
        breathers "stop"
        echo "ctpq time 2.0 off 0 pos (-20.0 0.0 -30.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        sleep 4.0
        echo "ctpq time 4.0 off 0 pos (  0.0 0.0  25.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        sleep 2.0 && blink
        sleep 2.0 && blink
    }

    sigla_4() {
        echo "set mou neu" | yarp rpc /icub/face/emotions/in
        echo "set leb neu" | yarp rpc /icub/face/emotions/in
        echo "set reb neu" | yarp rpc /icub/face/emotions/in
        go_home_helperL 4.0
        go_home_helperR 4.0
        echo "ctpq time 2.5 off 0 pos (20.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
        sleep 10.0
        echo "ctpq time 2.0 off 0 pos (-20.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
        echo "ctpq time 2.0 off 0 pos (-44.0 36.0 44.0 81.0 -75.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/left_arm/rpc
        echo "ctpq time 2.0 off 0 pos (10.0 67.0 75.0 106.0 -18.0 -20.0 5.0 20.0 26.0 7.0 28.0 28.0 38.0 48.0 42.0 150.0)" | yarp rpc /ctpservice/right_arm/rpc
        sleep 1.0 && blink
        smile
        sleep 1.0 && blink
        sleep 1.0 && blink
    }

#######################################################################################
# CHIUSURA:                                                                           #
#######################################################################################
    chiusura() {
        head "stop"
        echo "ctpq time 3.0 off 0 pos (-47.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
        echo "ctpq time 3.0 off 0 pos (0.0 0.0 30.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        sleep 5.0
        echo "ctpq time 2.5 off 0 pos (-10.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
        echo "ctpq time 1.0 off 0 pos (0.0 0.0 -10.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
        echo "ctpq time 1.0 off 0 pos (0.0 0.0   0.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc

        sleep 2.0
        speak "Un altro oggetto ordinario e' diventato qualcosa di straordinario."
        speak "$1"
        sleep 0.5
        # speak "Rimarra' a disposizione di tutti gli aspiranti meikers? nella galleria dei prototipi? sul sito vuvuvu punto dea kidz punto it"
        speak "Rimarra' a disposizione di tutti gli aspiranti meikers? nella galleria dei prototipi sul nostro sito."

        head "start"
        sleep 16.0
        breathers "stop"
        echo "ctpq time 1.2 off 0 pos (-62.0 20.0 11.0 86.0 89.0 -41.0 -4.0 17.0 90.0 0.0 163.0 0.0 0.0 0.0 0.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
        speak "aicab passa e chiude."
        sleep 2.0
        go_home_helperR 1.2
        sleep 1.5
        breathers "start"
    }

    chiusura_1() {
        chiusura "Il protocollo? Super Monopattino e' chiuso e archiviato."
    }

    chiusura_2() {
        chiusura "Il protocollo? Vestiti del Futuro e' chiuso e archiviato."
    }

    chiusura_3() {
        chiusura "Il protocollo? Ultra Macchina e' chiuso e archiviato."
    }

    chiusura_4() {
        chiusura "Il protocollo? Super TV e' chiuso e archiviato."
    }

    chiusura_5() {
        chiusura "Il protocollo? Social? Taabl-et? e' chiuso e archiviato."
    }

    chiusura_6() {
        chiusura "Il protocollo? ics Baaicc? e' chiuso e archiviato."
    }

    chiusura_7() {
        chiusura "Il protocollo? X Pacc? e' chiuso e archiviato."
    }

    chiusura_8() {
        chiusura "Il protocollo? X Tois? e' chiuso e archiviato."
    }

    chiusura_9() {
        chiusura "Il protocollo? Robot Sveglia? e' chiuso e archiviato."
    }

    chiusura_10() {
        chiusura "Il protocollo? Tenda Perfetta e' chiuso e archiviato."
    }

#######################################################################################
# CUSTOM KAMMO
#######################################################################################
    gesto_kammo() {
        go_home
        #saluta
        #speak "aicab ha svolto una ricerca in rete. e ha intervistato centinaia di ragazzi per capire cosa desiderino e quali siano i loro problemi con i monopattini."
        #sleep 3.0 && blink
        #sleep 4.0 && blink
        #sleep 2.5 && blink
        speak "Ecco i risultati."
        meteo_bot
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



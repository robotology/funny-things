#!/bin/bash
##########################################################################################
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
##########################################################################################


##########################################################################################
# USEFUL FUNCTIONS:                                                                      #
##########################################################################################
usage() {
cat << EOF
******************************************************************************************
DEA SCRIPTING
Author:  Alessandro Roncone   <alessandro.roncone@iit.it> 

This script scripts through the commands available for the DeA Kids videos.

USAGE:
        $0 options

******************************************************************************************
OPTIONS:
    -p -> Panel icons (and any 22x22px icon that is not explicitly handled by the gtk theme)
    -f -> Folder colors (currently 7 different colors are available!)
    -r -> Restore configs
    -u -> update repository (WARNING: it will remove any customization)

******************************************************************************************
EXAMPLE USAGE:

******************************************************************************************
EOF
}

##########################################################################################
# FUNCTIONS:                                                                             #
##########################################################################################
speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}

blink() {
    echo "blink" | yarp rpc /iCubBlinker/rpc
}

greet_with_right_thumb_up() {
    echo "Thumb Up TODO"
}

greet_like_god() {
    echo "God TODO"
}

grasp_apple() {
    echo "grasp_apple TODO"
}

mostra_muscoli() {
    echo "mostra_muscoli TODO"
}

passa_e_chiudi() {
    speak "aicab passa e chiude."
    sleep 2.0
    blink
}

buongiorno_capo() {
    speak "Buongiorno capo!"
    sleep 2.0
    blink
}

ciao() {
    speak "Ciao! Mi chiamo aicab."
}

script_1() {
    buongiorno_capo
    greet_like_god
    speak "Oggi, aicab e' andato a caccia di novità sulle quattro ruote."
    sleep 2.0
    blink
}

script_2() {
    speak "Capo, ci pensi?"
    sleep 2.0
    blink
    sleep 1.0
    speak "E' stata usata una stampante 3D, proprio come quelle del laboratorio degli Xmeikers!"
    sleep 7.0
    blink 
    speak "Solo..."
    sleep 1.0
    speak "Un po' piu' grande."
    sleep 2.0
    blink
}

script_3() {
    speak "Cosi', anche chi guida potrà schiacciare un pisolino durante il viaggio."
    sleep 4.0
    speak "Per oggi dal dipartimento ricerca e' tutto."
    sleep 3.0
    blink
    passa_e_chiudi
    greet_with_right_thumb_up
}

script_4() {
    buongiorno_capo
    greet_like_god
    speak "Oggi, aicab ha fatto un corso accelerato di cucina"
    sleep 4.0
    blink
    speak "per saperne di piu' su quello che voi chiamate cibo."
    sleep 4.0
    blink
    speak "Preparatevi a restare a bocca aperta!"
    sleep 4.0
    blink
}

script_5() {
    speak "aicab ha sentito dire che voi umani andate matti per questa cioccolata..."
    sleep 6.0
    blink
}

script_6() {
    grasp_apple
    speak "Pensa capo, un giorno questa mela potrebbe avere il gusto di ba na na!"
    sleep 2.0
    speak "Anche per oggi, dal reparto Ricerca e Innovazione e' tutto."
    sleep 6.0
    blink
    passa_e_chiudi
    greet_with_right_thumb_up
}

script_7() {
    buongiorno_capo
    greet_like_god
    speak "Oggi, aicab ha scovato delle novita' che nel giro di qualche anno renderanno voi umani"
    sleep 3.0
    blink
    mostra_muscoli
    speak "Dei supereroi"
}

script_8() {
    speak "E ora Capo. il potere che tutti vorrebbero."
    sleep 4.0
    blink
    speak "La telecinesi. La capacita' di controllare gli oggetti con la mente."
    sleep 4.0
    blink
}

script_9() {
    speak "Certo che a quel punto, perdersi tra i pensieri potrebbe diventare un problema."
    sleep 6.0 && blink
    speak "Anche per oggi, dal reparto Ricerca e Innovazione e' tutto."
    sleep 4.0 && blink
    passa_e_chiudi
}

##########################################################################################
# "MAIN" FUNCTION:                                                                       #
##########################################################################################
echo "***********************************************************************************"
echo ""

echo "stop"  | yarp rpc /iCubBlinker/rpc
$1
#echo "start" | yarp rpc /iCubBlinker/rpc

if [[ $# -eq 0 ]] ; then 
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi

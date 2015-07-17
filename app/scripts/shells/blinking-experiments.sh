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
BLINKING EXPERIMENTS
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
    echo "[BlinkingScript] Speaking: \"$1\""
}

blink() {
    echo "blink" | yarp rpc /iCubBlinker/rpc
}

wait_till_quiet() {
    isSpeaking=$(echo "stat" | yarp rpc /iSpeak/rpc)
    # echo $isSpeaking
    while [ "$isSpeaking" == "Response: speaking" ]; do
        isSpeaking=$(echo "stat" | yarp rpc /iSpeak/rpc)
        # echo $isSpeaking
        sleep 0.01
    done
    echo "[BlinkingScript] I'm not speaking any more"
}

speak_hri() {
    # blink
    speak "$1"
    sleep 0.15
    wait_till_quiet
    # blink    
}

#do a blink only at the beginning (onset)
speak_hri_b() {
    # blink
    speak "$1"
    sleep 0.15
    wait_till_quiet
}

#do not blink at all at onset/offset
speak_hri_n() {
    speak "$1"
    sleep 0.15
    wait_till_quiet
}

#do a blink only at the end (offset)
speak_hri_e() {
    speak "$1"
    sleep 0.15
    wait_till_quiet
    # blink
}


#######################################################################################
# FUNCTION TO CALL
#######################################################################################

run() {
    speak_hri "Hello!"
    sleep 2.0
    speak_hri "Fine thanks, how about yourself?"
    sleep 8.0
    speak_hri "Sure, go ahead. What would you like to know?"
    sleep 4.5
    speak_hri_b "Hmmm, let's see."
    speak_hri_n "So, typically, one of the humans working with me, stands on the other side of a table located between the two of us."
    speak_hri_n "Then, I am shown different objects on the table, and the human asks me: 'Where is the octopus?'"
    speak_hri_e "I then point to one of the objects, that resembles an octopus and say: 'I think this is the octopus.'."
    sleep 4.0
    speak_hri "Well, it is more like recognizing different shapes and changes in my surroundings."
    sleep 4.0
    speak_hri_b "The humans working with me, usually tell them to me while pointing at the objects."
    speak_hri_e "They do this quite often and repetitively."
    sleep 7.0
    speak_hri_b "Not really? We also shuffle the objects on the table around, so I can restart looking for the octopus."
    speak_hri_e "Sometimes, if the humans feel very adventurous, I am also shown new objects, and then I can start looking for them on the table."
    sleep 5.0
    speak_hri "No problem. my pleasure."
    sleep 1.6
    speak_hri "Okay. Bye, see you next time."
}

#######################################################################################
# "MAIN" FUNCTION:                                                                    #
#######################################################################################
echo "********************************************************************************"
echo ""

$1 "$2"

if [[ $# -eq 0 ]] ; then 
    echo "[BlinkingScript] No options were passed!"
    echo ""
    usage
    exit 1
fi



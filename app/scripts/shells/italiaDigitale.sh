 #!/bin/bash

#######################################################################################
# HELP
#######################################################################################
usage() {
cat << EOF
***************************************************************************************
Italia Digitale SCRIPTING
Author:  Vaidm Tikhanoff   <vadim.tikhanoff@iit.it>

This script scripts through the commands available for the italia digitale event 

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

#######################################################################################
# SEQUENCE FUNCTIONS
#######################################################################################
sequence_01() {
    speak "Bene Giorgio, è sempre un piacere vedere il mio papà. Vedo che c’è tanta gente a sentirti. Non saranno venuti per vedere me?"
    display-text "Bene Giorgio, è sempre un piacere vedere il mio papà. Vedo che c’è tanta gente a sentirti. Non saranno venuti per vedere me?"
    wait_till_quiet
}

sequence_02() {
    speak "Okey Giorgio, ne sono felice. Quando mi togliete dalla scatola in cui viaggio, e smetto di dormire, vorrei parlare con tutti."
    display-text "Ok Giorgio, ne sono felice. Quando mi togliete dalla scatola in cui viaggio, e smetto di dormire, vorrei parlare con tutti."
    wait_till_quiet
    
    display-sun
    sleep 2.0
    display-happy
}

sequence_03() {
    speak "Per ora, come tu sai, posso riconoscere gli oggetti, spostarli, ricevere ordini, fare compiti elementari. Sto studiando, come direste voi."
    display-text "Per ora, come tu sai, posso riconoscere gli oggetti, spostarli, ricevere ordini, fare compiti elementari. Sto studiando, come direste voi."
    wait_till_quiet
}

sequence_04() {
    speak "Tante cose a seconda di chi mi comprerà. Sarò il vostro assistente personale, una presenza quotidiana, sul lavoro ma anche a casa."
    display-text "Tante cose a seconda di chi mi comprerà. Sarò il vostro assistente personale, una presenza quotidiana, sul lavoro ma anche a casa."
    wait_till_quiet
}

sequence_05() {
    speak "Come faccio a sostituire il mio creatore? Non arrivo lontanamente a fare quello che fate voi: posso aiutarvi ma non sostituirvi."
    display-text "Come faccio a sostituire il mio creatore? Non arrivo lontanamente a fare quello che fate voi: posso aiutarvi ma non sostituirvi."
    wait_till_quiet
}

sequence_06() {
    speak "Prego papà."
    display-text "Prego papà."
    wait_till_quiet
    
    display-ticked
    sleep 2.0
    display-happy
}

sequence_07() {
    speak "Farò quello che mi chiederete nel modo in cui me lo chiederete."
    display-text "arò quello che mi chiederete nel modo in cui me lo chiederete."
    wait_till_quiet
}
 
sequence_08() {
    speak "Mi piace imparare e guardare il mondo, perché il vostro mondo è anche il mio, e vorrei che mi insegnaste tante cose"
    display-text "Mi piace imparare e guardare il mondo, perché il vostro mondo è anche il mio e vorrei che mi insegnaste tante cose"
    wait_till_quiet
}

sequence_09() {
    speak "Il sonno, perché il mio è un sonno senza sogni. "
    display-text "Il sonno, perché il mio è un sonno senza sogni. "
    wait_till_quiet
}

sequence_10() {
    speak "No Giorgio, lo sai, i miei sistemi non sono così sofisticati, e forse mai lo saranno. Magari voi le provate parlando con me."
    display-text "No Giorgio, lo sai, i miei sistemi non sono così sofisticati e forse mai lo saranno. Magari voi le provate parlando con me."
    wait_till_quiet
}

sequence_11() {
    speak "Ciao Giorgio, a presto."
    display-text "Ciao Giorgio, a presto."
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

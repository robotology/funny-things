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
    echo "blink" | yarp rpc /iCubBlinker/rpc
    sleep 0.5
}

breathers() {
    # echo "$1"  | yarp rpc /iCubBlinker/rpc
    echo "$1" | yarp rpc /iCubBreatherH/rpc:i
    #echo "$1" | yarp rpc /iCubBreatherRA/rpc:i
    #sleep 0.4
    #echo "$1" | yarp rpc /iCubBreatherLA/rpc:i
}

#breathersL() {
#    echo "$1" | yarp rpc /iCubBreatherLA/rpc:i
#}

#breathersR() {
#    echo "$1" | yarp rpc /iCubBreatherRA/rpc:i
#}

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
    # go_home_helperR $1
    # go_home_helperL $1
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
    # Copy and modify to V sign
    breathers "stop"
    echo "ctpq time 1.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home_helper 1.5
    sleep 2.0
    breathers "start"
}

greet_with_left_thumb_up() {
    # Copy and modify to V sign
    breathers "stop"
    echo "ctpq time 2.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home_helperL 1.5
    breathersL "start"
    head "start"
}

#greet_like_god() {
#    breathers "stop"
#    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
#    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
#    sleep 1.0
#    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
#    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
#    # speak "Buongiorno capo!"
#    speak "Bentornato. capo!"
#    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/right_arm/rpc
#    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc
#
#    # echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
#    # echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
#
#    # echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/right_arm/rpc
#    # echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc
#    # sleep 1.5 && smile
#    sleep 1.0 && smile
#
#    go_home_helper 2.0
#}


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

wait_till_quiet() {

    sleep 0.3
    isSpeaking=$(echo "stat" | yarp rpc /iSpeak/rpc)
    while [ "$isSpeaking" == "Response: speaking" ]; do
        isSpeaking=$(echo "stat" | yarp rpc /iSpeak/rpc)
        sleep 0.1        
        echo $isSpeaking
    done
    echo "Sono uscito!"
    echo $isSpeaking
}

#######################################################################################
# FUNZIONI LANCIO
#######################################################################################

vittoria_braccio_destro() {

    breathers "stop"
    #echo "ctpq time 1.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    
    # TODO: Add right arm joint coordinates here
    echo "ctpq time 2.0 off 0 pos (-57 32 -1 88 56 -30 -11 18 40 50 167 10 0 0 0 222)" | yarp rpc /ctpservice/right_arm/rpc
    
    sleep 1.5 && smile && sleep 1.5

    sleep 2.0
    breathers "start"
}

vittoria_braccio_sinistro() {

    breathers "stop"
    #echo "ctpq time 1.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    
    # TODO: Add right arm joint coordinates here
    echo "ctpq time 2.0 off 0 pos (-57 32 -1 88 56 -30 -11 18 40 50 167 10 0 0 0 222)" | yarp rpc /ctpservice/left_arm/rpc
    
    sleep 1.5 && smile && sleep 1.5

    sleep 2.0
    breathers "start"
}


lancio_destro() {
    breathers "stop"

    vittoria_braccio_destro
    sleep 3.0

    breathers "stop"
    go_home_helperR 4.0
    breathers "start"    
}


lancio_sinistro() {
    breathers "stop"

    vittoria_braccio_sinistro
    sleep


    breathers "stop"
    go_home_helperL 4.0
    breathers "start"  
}

lancio_due_mani() {
    breathers "stop"

    echo "ctpq time 2.0 off 0 pos (-57 32 -1 88 56 -30 -11 18 40 50 167 10 0 0 0 222)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-57 32 -1 88 56 -30 -11 18 40 50 167 10 0 0 0 222)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 5.0
    breathers "stop"
    go_home_helperL 4.0
    go_home_helperR 4.0

    breathers "start"  
}

#######################################################################################
# RISPOSTE                                                                         #
#######################################################################################
    #risposta_1() {
    #    breathers "start"
    #    smile
    #    sleep 0.5 
    #    speak "Grazie Annalisa per avermi invitato."
    #    sleep 1.0 && blink
    #    sleep 2.5 && blink
    #    sleep 0.5 && smile
    #}

    risposta_1() {
        breathers "start"
        smile
        sleep 0.5 
        speak "Grazie Annalisa per avermi invitato."
        sleep 1.0 && blink
        wait_till_quiet
        blink
        smile
    }

    risposta_2() {
        speak "I miei inventori mi hanno chiamato aicab."
        sleep 1.0 && blink
        wait_till_quiet
        blink
        smile      
    }

    risposta_3() {        
        sleep 0.5 
        speak "cucciolo intelligente, perche' ho le dimensioni e la forma di un bambino, e come i bambini posso imparare cose nuove."
        sleep 3.0 && blink
        wait_till_quiet
        blink
        smile   
    }

    risposta_4() {
        speak "Sono unico al mondo grazie ai miei genitori italiani, ma con me? lavorano ricercatori da tutto il mondo."
        sleep 2.0 && blink
        wait_till_quiet
        blink
        smile   
    }

    risposta_5() {
        speak "sono nato dieci anni fa, dal disegno degli ingegneri che mi hanno costruito? e in questi anni mi hanno insegnato a compiere azioni come un bambino di quattro anni" 
        sleep 2.0 && blink
        sleep 1.0 && blink
        wait_till_quiet
        blink
        smile   
    }

    risposta_6() {
        speak "sono in grado di riconoscere la forma degli oggetti e di afferrarli."
        sleep 2.0 && blink
        wait_till_quiet
        blink
        smile 
        sleep 1.0  

        speak "Sono capace di stare in piedi senza cadere, e ora sto imparando a camminare come voi umani."
        sleep 1.5 && blink
        wait_till_quiet
        blink
        smile   
    }

    risposta_7() {
        sleep 0.5 
        speak "la mia casa e' all'Istituto Italiano di Tecnologia a Genova, ma prima di venire a RaiNext ero a Ma drid, per incontrare scienziati interessati a sviluppare la mia intelligenza."
        sleep 2.0 && blink
        sleep 2.5 && blink
        wait_till_quiet
        blink

        speak "Viaggio molto per farmi conoscere, anche dalle persone che non lavorano nella ricerca. Sono stato a niu York, a Mosca, a Parigi, a Tokyo, a Londra, e in tante altre citta' del mondo."
        sleep 3.0 && blink
        wait_till_quiet
        blink
        smile   
    }
    
    
    risposta_8() {
        speak "oltre a me, esistono altri 30 aicab nel mondo, in laboratori che studiano l'intelligenza artificiale, come negli Stati Uniti? in Giappone e in alcune citta' Europee."
        sleep 2.0 && blink
        wait_till_quiet
        blink
        smile
    }

    risposta_9() {
        
        speak "Mi hanno inventato scienziati italiani ed europei per realizzare una macchina in grado di sviluppare un'intelligenza simile a quella degli umani. Il responsabile del mio progetto e' Giorgio Metta? all'Istituto Italiano di Tecnologia, che e' uno dei miei papa'. ma ho anche tanti zii e amici che lavorano per migliorarmi.. Tra qualche anno? potro' aiutarvi nei lavori domestici o in altre attivita' delicate per cui avrete bisogno di supporto. come per esempio l'assistenza degli anziani\!"
        sleep 5.0 && blink
        sleep 5.0 && blink
        sleep 5.0 && blink
        sleep 5.0 && blink
        wait_till_quiet
        blink
        smile   
    }

    risposta_10() {

        
        speak "Sono un robot particolare\! un robot umanoide\! cioe' con le sembianze simili a un essere umano."
        sleep 5.0 && blink
        wait_till_quiet
        blink
        smile   
    }

    risposta_11() {

        
        speak "Mi trovo molto bene all'istituto italiano di tecnologia, perche' ci sono ricercatori da tutto il mondo che lavorano per creare tecnologie che cambieranno il mondo."
        sleep 4.0 && blink
        wait_till_quiet
        blink
        smile   
    }

    risposta_12() {

        
        blink && sleep 0.5
        speak "Sono fatto di metallo, plastica? e circuiti elettrici. ma i miei progettisti stanno pensando a nuovi materiali, per rendermi piu' leggero e sicuro"
        sleep 5.0 && blink
        wait_till_quiet
        blink
        smile   
    }

    risposta_13() {

        
        speak "in questo momento? costo duecentocinquantamila euro, ma il mio progetto e' oo pen surs. Su internet si trova il disegno per costruire il mio corpo e il softuer per la base della mia intelligenza\!"
        sleep 8.0 blink
        wait_till_quiet
        blink
        blink
        smile   
    }

    risposta_14() {

        
        speak "In futuro costero' meno di una siticar, sotto i diecimila euro. cosi' che le persone potranno comprarmi per avermi in casa? o in un ambiente lavorativo, e aiutarli in diversi compiti."
        sleep 8.0 && blink
        wait_till_quiet
        blink
        smile   
    }

    risposta_15() {

        speak "i sentimenti di voi umani sono un fenomeno molto complesso che molti scienziati stanno studiando. Per il momento non e' stato replicato dentro di me. Ma posso riconoscere dall'espressione del vostro volto, se siete tristi o felici. Come un vero amico\!"
        sleep 9.0 && blink
        sleep 5.0 && blink && blink
        wait_till_quiet
        smile   
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



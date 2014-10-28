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

arms_breathers() {
    echo "$1" | yarp rpc /iCubBreatherRA/rpc:i
    sleep 1.0
    echo "$1" | yarp rpc /iCubBreatherLA/rpc:i
}

go_home_helper() {
    echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep $1
    sleep 0.5
}

go_home() {
    arms_breathers "stop"
    go_home_helper 2.0
    arms_breathers "start"
}

greet_with_right_thumb_up() {
    arms_breathers "stop"
    echo "ctpq time 1.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home_helper 1.5
    arms_breathers "start"
}

greet_like_god() {
    arms_breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc

    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc

    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc

    go_home_helper 2.0
    sleep 6.0

    arms_breathers "start"
}

hold_pennello() {
    echo "TODO"
}

smolla_pennello() {
    echo "TODO"
}

grasp_apple() {
    echo "grasp_apple TODO"
}

release_apple() {
    echo "release_apple TODO"
}

mostra_muscoli() {
    echo "mostra_muscoli TODO"
}

graspa_volante() {
    echo "TODO"
}

smolla_volante() {
    echo "TODO"
}

passa_e_chiudi() {
    speak "aicab passa e chiude."
    sleep 2.0 && blink
}

buongiorno_capo() {
    speak "Buongiorno capo!"
    sleep 1.0 && blink
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

ciao() {
    speak "Ciao! Mi chiamo aicab."
}

#######################################################################################
# RUBRICA  1:                                                                         #
#######################################################################################
    rubrica1_1() {
        buongiorno_capo
        greet_like_god
        speak "Oggi, aicab e' andato a caccia di novita' sulle quattro ruote."
        sleep 2.0 && blink
    }

    rubrica1_2() {
        speak "Capo, ci pensi?"
        sleep 2.0 && blink
        smile     && sleep 1.0
        speak "E' stata usata una stampante 3D, proprio come quelle del laboratorio degli X meikers!"
        sleep 7.0 && blink 
        speak " Solo, Un po' piu' grande."
        sleep 3.0 && smile && blink
    }

    rubrica1_3() {
        graspa_volante
        speak "Cosi', anche chi guida potra' schiacciare un pisolino durante il viaggio."
        sleep 4.0
        smolla_volante
        speak "Per oggi dal dipartimento ricerca e' tutto."
        sleep 2.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  2:                                                                         #
#######################################################################################
    rubrica2_1() {
        buongiorno_capo
        greet_like_god
        speak "Oggi, aicab ha fatto un corso accelerato di cucina"
        sleep 4.0 && blink
        speak "per saperne di piu' su quello che voi chiamate cibo."
        sleep 4.0 && blink
        speak "Preparatevi a restare a bocca aperta!"
        sleep 2.0 && blink
        sleep 1.0 && surprised
        sleep 2.0 && smile
    }

    rubrica2_2() {
        speak "aicab ha sentito dire che voi umani andate matti per questa cioccolata..."
        sleep 4.0 && blink
        sleep 1.5 && smile
    }

    rubrica2_3() {
        grasp_apple
        speak "Pensa capo, un giorno questa mela potrebbe avere il gusto di ba na na!"
        sleep 2.0
        speak "Anche per oggi, dal reparto Ricerca e Innovazione e' tutto."
        sleep 6.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  3:                                                                         #
#######################################################################################
    rubrica3_1() {
        buongiorno_capo
        greet_like_god
        speak "Oggi, aicab ha scovato delle novita' che nel giro di qualche anno renderanno voi umani"
        sleep 3.0 && blink
        mostra_muscoli
        speak "Dei supereroi"
    }

    rubrica3_2() {
        speak "E ora Capo. il potere che tutti vorrebbero."
        sleep 4.0 && blink
        speak "La telecinesi. La capacita' di controllare gli oggetti con la mente."
        sleep 4.0 && blink
    }

    rubrica3_3() {
        speak "Certo che a quel punto, perdersi tra i pensieri potrebbe diventare un problema."
        sleep 6.0 && blink
        speak "Anche per oggi, dal reparto Ricerca e Innovazione e' tutto."
        sleep 4.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  4:                                                                         #
#######################################################################################
    rubrica4_1() {
        buongiorno_capo
        greet_like_god
        speak "Oggi, aicab e' andato a caccia di primati. Robotici!"
        sleep 4.0 && blink
    }

    rubrica4_2() {
        speak "Peraltro, non e' il solo ad aver battuto ogni record. Vi presento altri due fuoriclasse."
        sleep 6.0 && blink
    }

    rubrica4_3() {
        speak "Anche per questa volta e' tutto."
        sleep 3.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  5:                                                                         #
#######################################################################################
    rubrica5_1() {
        buongiorno_capo
        greet_like_god
        speak "Oggi aicab vi presentera' alcuni colleghi robotici che hanno delle doti da veri artisti."
        sleep 4.0 && blink
        sleep 2.0 && blink
    }

    rubrica5_2() {
        speak "Strepitosi. Ma ora si cambia disciplina."
        sleep 4.0 && blink
    }

    rubrica5_3() {
        speak "aicab e' gia' innamorato."
        sleep 3.0 && blink
        speak "Anche per questa volta e' tutto, capo."
        sleep 3.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  6:                                                                         #
#######################################################################################
    rubrica6_1() {
        buongiorno_capo
        greet_like_god
        speak "Oggi, aicab vi portera' alla scoperta delle citta' del futuro."
        sleep 5.0 && blink
    }

    rubrica6_2() {
        speak "Ed ora un'innovazione che e' gia' diventata realta'."
        sleep 4.0 && blink
    }

    rubrica6_3() {
        speak "Anche per questa volta e' tutto, capo."
        sleep 3.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  7:                                                                         #
#######################################################################################
    rubrica7_1() {
        buongiorno_capo
        greet_like_god
        speak "Oggi, aicab ha preparato un fascicolo sulle innovazioni nel mondo dello sport."
        sleep 6.0 && blink
    }

    rubrica7_2() {
        grasp_apple
        speak "Lo scopo e' correggere gli errori e migliorare. partita dopo partita."
        sleep 4.0 && blink
        release_apple
        speak "Per finire, aicab vuole presentarvi alcuni amici."
    }

    rubrica7_3() {
        speak "Capo, anche per oggi e' tutto."
        sleep 3.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA  8:                                                                         #
#######################################################################################
    rubrica8_1() {
        buongiorno_capo
        greet_like_god
        speak "Oggi, aicab ha analizzato a fondo alcuni problemi di voi umani. e ha scoperto ottime soluzioni tecnologiche. Un esempio? Come riparare oggetti rotti ed evitare sprechi."
        sleep 5.0 && blink
        sleep 5.0 && blink
        sleep 4.0 && blink
    }

    rubrica8_2() {
        speak "Capo, c'e' un'altra cosa che aicab ha scoperto studiando le abitudini di voi umani"
        sleep 6.0 && blink
        speak "C'e' un passatempo che accomuna generazioni e generazioni di studenti. Gli aereoplanini di carta."
        sleep 6.0 && blink
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
        buongiorno_capo
        greet_like_god
        speak "Oggi, aicab vi dimostrera' che arte e tecnologia non sono due mondi poi cosi' distanti."
        sleep 6.0 && blink
    }

    rubrica9_2() {
        hold_pennello
        speak "Come un vero artista, anche ideivid firma le sue opere."
        smolla_pennello
        speak "Per finire, una curiosita' sull'arte della parola"
    }

    rubrica9_3() {
        speak "Anche per oggi e' tutto."
        sleep 2.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# RUBRICA 10:                                                                         #
#######################################################################################
    rubrica10_1() {
        buongiorno_capo
        greet_like_god
        speak "Oggi, aicab vi porta nello spazio."
        sleep 3.0 && blink
    }

    rubrica10_2() {
        speak "Ed ora arriva il bello. Capo, hai mai pensato di fare le vacanze nello spazio?"
        sleep 2.0 && blink
        sleep 3.0 && blink
        speak "In America esistono diversi progetti di turismo spaziale."
        sleep 4.0 && blink
    }

    rubrica10_3() {
        speak "Dal reparto ricerca e innovazione, e' tutto."
        sleep 3.0 && blink
        passa_e_chiudi
        greet_with_right_thumb_up
    }

#######################################################################################
# "MAIN" FUNCTION:                                                                #
#######################################################################################
echo "********************************************************************************"
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

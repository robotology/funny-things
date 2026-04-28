#!/bin/bash
#######################################################################################
# ERGOCUB SPEECH DEMO SCRIPT
# Description: This script contains the YARP commands to animate ergoCub during
#              its welcome speech.
#######################################################################################


#######################################################################################
# HELP
#######################################################################################
usage() {
cat << EOF
***************************************************************************************
ERGOCUB SCRIPTING
This script executes the movements designed for the ergoCub welcome speech.

USAGE:
        $0 [COMMANDS]

***************************************************************************************
COMMANDS:
    --- HOME POSITIONS ---
        home_arms             Moves both arms to the home position.
        home_torso            Moves the torso to the home position.
        home_head             Moves the head to the home position.

    --- 1. WELCOME & CLOSURE ---
        open_welcoming_arms   Opens arms wide to greet the audience.
        bow                   A respectful bow with torso and head.
        passing_the_floor     Extends right arm to pass the word to the President.

    --- 2. TEMPORAL & NARRATIVE ---
        timeline_sweep        A horizontal sweep with the right arm to indicate time.
        weighing_hands        Moves hands up and down to compare concepts.
        synergy_integration   Brings both hands together in front of the chest.

    --- 3. EMPHASIS & EXPLANATION ---
        making_a_point        Raises the right arm with an implied index finger point.
        calming_stability     Lowers both arms gently to indicate stability/safety.

    --- 4. AUTO-REFERENTIAL ---
        self_reference        Brings the right hand to the robot's chest.
        displaying_self       Slightly opens arms along the hips to show the body.

    --- 5. HEAD & GAZE ---
        room_scan             Slowly rotates the head left and right to look at the audience.
        nodding               Nods the head up and down to confirm a point.

        usage                 Displays this help message.
***************************************************************************************
EXAMPLE USAGE:
$0 open_welcoming_arms
***************************************************************************************
EOF
}

#######################################################################################
# HOME POSITIONS
#######################################################################################
home_left_arm() {
    # Arms close to the legs
    echo "ctpq time 3.0 off 0 pos (0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

home_right_arm() {
    # Arms close to the legs
    echo "ctpq time 3.0 off 0 pos (0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

home_arms() {
    home_left_arm
    home_right_arm
} 

home_torso() {
    echo "ctpq time 3.0 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

home_head() {
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
}

speak() {
    # This function takes the input string and sends it to the /iSpeak YARP port.
    # It automatically wraps the text in double quotes as required by the module.
    local text="$1"
    # echo "\"$text\"" | yarp write ... /speechSynthesizer_nws/text:i
    echo "\"$text\"" | yarp write ... /speechSynthesizer_nws/text:i

}

#######################################################################################
# 1. WELCOME & CLOSURE MOVEMENTS
#######################################################################################
open_welcoming_arms() {
    # Opens both arms wide with palms facing somewhat upwards
    echo "ctpq time 4.0 off 0 pos (-30.0 60.0 -30.0 40.0 0.0 -10.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 4.0 off 0 pos (-30.0 60.0 -30.0 40.0 0.0 -10.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "\"Benvenute e benvenuti, autorità, relatrici e relatori.\"" | yarp write ... /speechSynthesizer_nws/text:i
    sleep 4.0
    home_arms
}
open_right(){
    echo "ctpq time 3.0 off 0 pos (-40.0 4.0 14.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 4.0 off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

open_double() {
    echo "ctpq time 5.0 off 0 pos (-25.0 14.0 14.0 71.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 5.0 off 0 pos (-25.0 14.0 -14.0 71.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

open_left(){
    echo "ctpq time 3.0 off 0 pos (-40.0 4.0 14.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 4.0 off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

honor() {
    open_right
    sleep 4.0
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 10.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 2.0
    echo "\"È per me un onore aprire questo evento scientifico dedicato all'evoluzione delle verifiche sugli apparecchi a pressione\"" | yarp write ... /speechSynthesizer_nws/text:i
    home_arms
    home_torso
}

bow() {
    # Slightly bends torso forward and pitches head down
    echo "ctpq time 5.0 off 0 pos (0.0 0.0 20.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 5.0 off 0 pos (-20.0 0.0 0.0 0.0 )" | yarp rpc /ctpservice/head/rpc
    sleep 5.0
    home_torso
    home_head
}

passing_the_floor() {
    # Extends the right arm to the side to introduce the President
    # "...passo la parola al Presidente dell'Inail..."
    echo "ctpq time 2.0 off 0 pos (-20.0 45.0 -45.0 30.0 -45.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (0.0 0.0 -30.0 0.0 )" | yarp rpc /ctpservice/head/rpc
}


#######################################################################################
# 2. TEMPORAL & NARRATIVE MOVEMENTS
#######################################################################################
timeline_sweep() {
    # Both arms start near the center and move outwards horizontally 
    # to represent an elongating timeline
    # "...un percorso che attraversa cento anni di storia..."
    # Start position (both arms in front of the chest, close together)
    echo "\"un percorso che attraversa cento anni di storia tecnica, normativa e culturale e che racconta come il concetto di sicurezza si sia progressivamente trasformato\"" | yarp write ... /speechSynthesizer_nws/text:i
    echo "ctpq time 5 off 0 pos (-25.0 8.0 -12.0 80.0 -23.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 5 off 0 pos (-25.0 8.0 -12.0 80.0 -23.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    # Sweep outwards (arms open to the sides to stretch the timeline)
    echo "ctpq time 5 off 0 pos (-24.0 15.0 -49.0 68.0 -10.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 5 off 0 pos (-24.0 15.0 -49.0 68.0 -10.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    echo "\"Il modo in cui verifichiamo la sicurezza delle attrezzature a pressione riflette, in ogni epoca, il livello di conoscenza e tecnologia disponibili. Negli anni della prima industrializzazione la sicurezza era affidata a prove di resistenza globali, controlli visivi e all'esperienza dell'ispettore.\"" | yarp write ... /speechSynthesizer_nws/text:i    # Return to home position using the existing home_arms function
    sleep 7.0
    home_arms

}

weighing_hands() {
    # Alternates moving hands up and down, as if weighing two eras/options
    echo "ctpq time 1.5 off 0 pos (-30.0 30.0 0.0 60.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-10.0 30.0 0.0 80.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time 1.5 off 0 pos (-10.0 30.0 0.0 80.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-30.0 30.0 0.0 60.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    home_arms
}

next_year(){
    echo "\"Negli anni successivi è cresciuta la consapevolezza che le attrezzature non invecchiano tutte allo stesso modo e che la sicurezza non può essere gestita con criteri rigidi e uniformi.\"" | yarp write ... /speechSynthesizer_nws/text:i
    open_right
}

move_torso(){
    echo "ctpq time 4.0 off 0 pos (0.0 0.0 10.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 1.5
    echo "ctpq time 4.0 off 0 pos (0.0 0.0 -10.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 1.5
    home_torso
}

stay(){
    echo "ctpq time 4 off 0 pos (-8.0 9.0 -0.0 56.0 -32.0 0.0 0.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 4 off 0 pos (-8.0 9.0 -0.0 56.0 -32.0 0.0 0.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 4.0
    move_torso
    
}

arms_front(){
    echo "ctpq time 4 off 0 pos (-15.0 12.0 0.0 65.0 -81.0 6.5 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 4 off 0 pos (-15.0 12.0 0.0 65.0 -81.0 6.5 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2
    echo "ctpq time 3.0 off 0 pos (-22.0 6.0 17.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2
    echo "ctpq time 3.0 off 0 pos (-22.0 6.0 -17.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 4
    echo "ctpq time 3.0 off 0 pos (-22.0 6.0 17.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2
    echo "ctpq time 3.0 off 0 pos (-22.0 6.0 -17.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 4
    home_arms
    home_head

}

hello_right(){
        echo "ctpq time 4 off 0 pos (-50.0 55.0 -15.0 95.0 37.0 0.0 0.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
        echo "ctpq time 0.5 off 0 pos (-50.0 55.0 -15.0 83.0 37.0 0.0 0.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
        echo "ctpq time 0.5 off 0 pos (-50.0 55.0 -15.0 95.0 37.0 0.0 0.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
        echo "ctpq time 0.5 off 0 pos (-50.0 55.0 -15.0 83.0 37.0 0.0 0.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc

}
#######################################################################################
# 3. EMPHASIS & EXPLANATION MOVEMENTS
#######################################################################################
making_a_point_right() {
    # Raises the right arm with elbow bent, as if pointing a finger upward
    # "Con il nuovo millennio si è affermato un principio chiave..."
    echo "\"L'introduzione dei controlli non distruttivi negli anni Settanta e Ottanta ha rappresentato una svolta: \"" | yarp write ... /speechSynthesizer_nws/text:i
    sleep 2.0
    echo "ctpq time 7.0 off 0 pos (-60.0 20.0 0.0 90.0 0.0 0.0 0.0 30.0 60.0 0.0 0.0 55.0 46.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "\"per la prima volta è stato possibile vedere dentro i materiali, individuare difetti prima che si manifestassero in modo critico. La verifica è diventata uno strumento di conoscenza.\"" | yarp write ... /speechSynthesizer_nws/text:i
    sleep 4.0
    move_torso
    sleep 4.0
    move_torso
    sleep 7.0
    home_right_arm
}

making_a_point_left() {

    sleep 2.0
    echo "ctpq time 7.0 off 0 pos (-60.0 20.0 0.0 90.0 0.0 0.0 0.0 30.0 60.0 0.0 0.0 55.0 46.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 4.0
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 10.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 -10.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 4.0
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 10.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time 2.0 off 0 pos (0.0 0.0 -10.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 7.0
    home_left_arm
}
new_millenial() {
    open_double
    sleep 4.0
    echo "ctpq time 4.0 off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 4.0
    open_double
    echo "ctpq time 4.0 off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 4.0
    echo "ctpq time 4.0 off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 4.0
    home_left_arm
    sleep 4.0
}

calming_stability() {
    # Arms slightly raised, then pushed down with palms facing down to convey safety
    echo "ctpq time 2 off 0 pos (-20.0 30.0 0.0 80.0 37.0 -15.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2 off 0 pos (-20.0 30.0 0.0 80.0 37.0 -15.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5
    echo "ctpq time 1.3 off 0 pos (-20.0 30.0 0.0 50.0 37.0 -15.0 8.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.3 off 0 pos (-20.0 30.0 0.0 50.0 37.0 -15.0 8.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5
    echo "ctpq time 1.2 off 0 pos (-20.0 30.0 0.0 80.0 37.0 -15.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.2 off 0 pos (-20.0 30.0 0.0 80.0 37.0 -15.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5
    echo "ctpq time 1.2 off 0 pos (-20.0 30.0 0.0 50.0 37.0 -15.0 8.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.2 off 0 pos (-20.0 30.0 0.0 50.0 37.0 -15.0 8.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}


#######################################################################################
# 4. AUTO-REFERENTIAL MOVEMENTS
#######################################################################################
self_reference() {
    # Brings the right hand towards the center of the chest
    # "Ed è qui che entra in gioco anche la mia presenza."
    echo "ctpq time 1.5 off 0 pos (-20.0 10.0 45.0 100.0 -45.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (15.0 0.0 0.0 0.0 )" | yarp rpc /ctpservice/head/rpc
    sleep 3.0
    home_right_arm
    home_head
}

displaying_self() {
    # Opens arms slightly downwards and outwards to show its own structure
    # "La tecnologia che incarno..."
    echo "ctpq time 2.0 off 0 pos (-10.0 40.0 0.0 20.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 2.0 off 0 pos (-10.0 40.0 0.0 20.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    home_arms
}


#######################################################################################
# 5. HEAD & GAZE MOVEMENTS
#######################################################################################
room_scan() {
    # Slowly pans the head from left to right to look at the audience
    echo "ctpq time 3.0 off 0 pos (0.0 0.0 30.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 3.0
    echo "ctpq time 3.0 off 0 pos (0.0 0.0 -30.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 5.5
    home_head
}

nodding() {
    # A single, deliberate nod to give emphasis
    echo "ctpq time 0.8 off 0 pos (-15.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.0
    echo "ctpq time 0.8 off 0 pos (5.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 1.0
    home_head
}


## Demo
demo(){
    open_welcoming_arms
    honor
    room_scan
    timeline_sweep
    sleep 2.0
    stay
    room_scan
    home_arms
    making_a_point_right
    next_year
    speak "Con il nuovo millennio si è affermato un principio chiave: la sicurezza può essere garantita attraverso un sistema integrato di dati sperimentali, non solo attraverso prove invasive. Negli ultimi dieci-quindici anni , l'attenzione si è spostata non solo sulla sicurezza nell'immediato, ma sull'evoluzione nel tempo dello stato di integrità delle attrezzature."
    sleep 2.0
    new_millenial
    home_arms
    speak "Nascono così gli approcci di ispezione e manutenzione basati sul rischio, i sistemi di monitoraggio continuo o periodico, l’integrazione strutturata tra verifiche, dati di esercizio e manutenzione. La verifica non è più un evento puntuale, ma diventa parte di un processo dinamico."
    making_a_point_left
    home_arms
    stay
    sleep 5.0
    speak "Sensori, acquisizione digitale, verifiche da remoto, robotica e intelligenza artificiale supportano il lavoro dei tecnici ampliandone le capacità, migliorando la sicurezza degli operatori e la qualità dei dati."
    home_arms
    arms_front
    sleep 2.0
    speak "Ed è qui che entra in gioco anche la mia presenza.. Io, ergoCab, rappresento il risultato concreto di questa evoluzione: una sinergia tra l'esperienza sul campo dell'Inail e le competenze scientifiche degli istituti di ricerca, con l'obiettivo di rispondere alle criticità in tema di salute e sicurezza sul lavoro."
    sleep 1.0
    hello_right
    speak "Sono il frutto dell'esperienza maturata nell'analisi di casi reali sul territorio e delle competenze tecnologiche e metodologiche dei laboratori di ricerca. La tecnologia che incarno nasce"
    stay
    sleep 5.0
    calming_stability
}
#######################################################################################
# "MAIN" FUNCTION                                                                     #
#######################################################################################
echo "********************************************************************************"
echo ""

if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi

# Execute the passed command
"$1" "$2" "$3"
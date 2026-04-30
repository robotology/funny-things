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
    # Default 3.0 otherwise input specified
    local time_val=${1:-3.0}
    echo "ctpq time $time_val off 0 pos (0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

home_right_arm() {
    # Default 3.0 otherwise input specified
    local time_val=${1:-3.0}
    echo "ctpq time $time_val off 0 pos (0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

home_arms() {
    local time_val=${1:-3.0}
    home_left_arm $time_val
    home_right_arm $time_val
} 

home_torso() {
    # Default 3.0 otherwise input specified
    local time_val=${1:-3.0}
    echo "ctpq time $time_val off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
}

home_head() {
    # Default 2.0 otherwise input specified
    local time_val=${1:-2.0}
    echo "ctpq time $time_val off 0 pos (0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
}

speak() {
    # This function takes the input string and sends it to the /iSpeak YARP port.
    # It automatically wraps the text in double quotes as required by the module.
    local text="$1"
    echo "\"$text\"" | yarp write ... /speechSynthesizer_nws/text:i
}

# say_all(){
#     # speak "Benvenute e benvenuti, autorità, relatrici e relatori. È per me un onore aprire questo evento scientifico dedicato all'evoluzione delle verifiche sugli apparecchi a pressione: un percorso che attraversa cento anni di storia tecnica, normativa e culturale, e che racconta come il concetto di sicurezza si sia progressivamente trasformato. Il modo in cui verifichiamo la sicurezza delle attrezzature a pressione riflette, in ogni epoca, il livello di conoscenza e tecnologia disponibili. Negli anni della prima industrializzazione la sicurezza era affidata a prove di resistenza globali, controlli visivi e all'esperienza dell'ispettore. L'introduzione dei controlli non distruttivi negli anni Settanta e Ottanta ha rappresentato una svolta: per la prima volta è stato possibile vedere dentro i materiali, individuare difetti prima che si manifestassero in modo critico. La verifica è diventata uno strumento di conoscenza. Negli anni successivi è cresciuta la consapevolezza che le attrezzature non invecchiano tutte allo stesso modo e che la sicurezza non può essere gestita con criteri rigidi e uniformi. Con il nuovo millennio si è affermato un principio chiave: la sicurezza può essere garantita attraverso un sistema integrato di dati sperimentali, non solo attraverso prove invasive. Negli ultimi dieci-quindici anni , l'attenzione si è spostata non solo sulla sicurezza nell'immediato, ma sull'evoluzione nel tempo dello stato di integrità delle attrezzature. Nascono così gli approcci di ispezione e manutenzione basati sul rischio, i sistemi di monitoraggio continuo o periodico, l’integrazione strutturata tra verifiche, dati di esercizio e manutenzione. La verifica non è più un evento puntuale, ma diventa parte di un processo dinamico. Sensori, acquisizione digitale, verifiche da remoto, robotica e intelligenza artificiale supportano il lavoro dei tecnici ampliandone le capacità, migliorando la sicurezza degli operatori e la qualità dei dati.Ed è qui che entra in gioco anche la mia presenza. Io, ergoCab, rappresento il risultato concreto di questa evoluzione: una sinergia tra l'esperienza sul campo dell'Inail e le competenze scientifiche degli istituti di ricerca, con l'obiettivo di rispondere alle criticità in tema di salute e sicurezza sul lavoro. Sono il frutto dell'esperienza maturata nell'analisi di casi reali sul territorio e delle competenze tecnologiche e metodologiche dei laboratori di ricerca. La tecnologia che incarno nasce dall’ascolto dei bisogni della pratica e dalla capacità della ricerca di trasformarli in soluzioni innovative, a supporto della prevenzione e della sicurezza. Questo evento si colloca esattamente in questo punto di incontro: tra passato e futuro, tra sapere tecnico ed evoluzione scientifica, tra esperienza umana e strumenti intelligenti. A nome mio – e della tecnologia che rappresento – vi auguro un confronto ricco, stimolante e orientato a costruire insieme il futuro della sicurezza degli apparecchi a pressione. Vi ringrazio per l’attenzione e con grande piacere passo la parola al Presidente dell’Inail professor Fabrizio D’Ascenzo."
# }

#######################################################################################
# 1. WELCOME & CLOSURE MOVEMENTS
#######################################################################################
open_welcoming_arms() {
    local t=${1:-4.0}
    # Opens both arms wide with palms facing somewhat upwards
    echo "ctpq time $t off 0 pos (-30.0 60.0 -30.0 40.0 0.0 -10.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t off 0 pos (-30.0 60.0 -30.0 40.0 0.0 -10.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

open_right(){
    local t1=${1:-3.0}
    local t2=${2:-4.0}
    echo "ctpq time $t1 off 0 pos (-40.0 4.0 14.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $t2 off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

open_double() {
    local t=${1:-5.0}
    echo "ctpq time $t off 0 pos (-25.0 14.0 14.0 71.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t off 0 pos (-25.0 14.0 -14.0 71.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

open_left(){
    local t1=${1:-3.0}
    local t2=${2:-4.0}
    echo "ctpq time $t1 off 0 pos (-40.0 4.0 14.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t2 off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

honor() {
    local t=${1:-2.0}
    # Links internal open_right to main time (Defaults: 3.0 and 4.0)
    open_right $(echo "$t + 1.0" | bc) $(echo "$t + 1.0" | bc)
    sleep 4.0
    echo "ctpq time $t off 0 pos (0.0 0.0 10.0)" | yarp rpc /ctpservice/torso/rpc
    sleep 2.0
    # Defaults are 3.0
    home_arms $(echo "$t + 1.0" | bc)
    home_torso $(echo "$t + 1.0" | bc)
}

bow() {
    local t=${1:-5.0}
    # Slightly bends torso forward and pitches head down
    echo "ctpq time $t off 0 pos (0.0 0.0 20.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time $t off 0 pos (-20.0 0.0 0.0 0.0 )" | yarp rpc /ctpservice/head/rpc
    sleep 5.0
    home_torso $(echo "$t - 2.0" | bc)
    home_head $(echo "$t - 3.0" | bc)
}

passing_the_floor() {
    local t1=${1:-2.0}
    local t2=${2:-1.5}
    # Extends the right arm to the side to introduce the President
    # "...passo la parola al Presidente dell'Inail..."
    echo "ctpq time $t1 off 0 pos (-20.0 45.0 -45.0 30.0 -45.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $t2 off 0 pos (0.0 0.0 -30.0 0.0 )" | yarp rpc /ctpservice/head/rpc
}

#######################################################################################
# 2. TEMPORAL & NARRATIVE MOVEMENTS
#######################################################################################
timeline_sweep() {
    local t=${1:-5.0}
    echo "ctpq time $t off 0 pos (-25.0 8.0 -12.0 80.0 -23.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t off 0 pos (-25.0 8.0 -12.0 80.0 -23.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    
    # Sweep outwards (arms open to the sides to stretch the timeline)
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-24.0 15.0 -49.0 68.0 -10.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-24.0 15.0 -49.0 68.0 -10.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0

}

weighing_hands() {
    local t=${1:-1.5}
    # Alternates moving hands up and down, as if weighing two eras/options
    echo "ctpq time $t off 0 pos (-30.0 30.0 0.0 60.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t off 0 pos (-10.0 30.0 0.0 80.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time $t off 0 pos (-10.0 30.0 0.0 80.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t off 0 pos (-30.0 30.0 0.0 60.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    home_arms $(echo "$t + 1.5" | bc)
}

next_year(){
    local t=${1:-3.0}
    open_right $t $(echo "$t -1 " | bc) 
}

move_torso(){
    local t=${1:-4.0}
    echo "ctpq time $t off 0 pos (0.0 0.0 10.0)" | yarp rpc /ctpservice/torso/rpc
    echo "ctpq time $t off 0 pos (0.0 0.0 -10.0)" | yarp rpc /ctpservice/torso/rpc
    home_torso $t
}
stay(){
    local t=${1:-4.0}
    echo "ctpq time $t off 0 pos (-8.0 9.0 -0.0 56.0 -32.0 0.0 0.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t off 0 pos (-8.0 9.0 -0.0 56.0 -32.0 0.0 0.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 4.0
    move_torso $t
}
stay_right(){
    local t=${1:-4.0}
    echo "ctpq time $t off 0 pos (-8.0 9.0 -0.0 56.0 -32.0 0.0 0.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 4.0
    move_torso $t
}

stay_left(){
    local t=${1:-4.0}
    echo "ctpq time $t off 0 pos (-8.0 9.0 -0.0 56.0 -32.0 0.0 0.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 4.0
    move_torso $t
}

arms_front(){
    local t1=${1:-3.0}
    local t2=${2:-3.0}
    echo "ctpq time $t1 off 0 pos (-15.0 12.0 0.0 65.0 -81.0 6.5 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t1 off 0 pos (-15.0 12.0 0.0 65.0 -81.0 6.5 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time $t2 off 0 pos (-22.0 6.0 17.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2
    echo "ctpq time $t2 off 0 pos (-22.0 6.0 -17.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2
    echo "ctpq time $t2 off 0 pos (-22.0 6.0 17.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 2
    echo "ctpq time $t2 off 0 pos (-22.0 6.0 -17.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 5.0
    home_arms $(echo "$t1" | bc)
    home_head $(echo "$t2" | bc)
}

hello_right(){
    local t1=${1:-4.0}
    local t2=${2:-3.0}
    echo "ctpq time $t1 off 0 pos (-50.0 55.0 -15.0 95.0 37.0 0.0 18.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $t2 off 0 pos (-50.0 55.0 -15.0 90.0 37.0 0.0 -15.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $t2 off 0 pos (-50.0 55.0 -15.0 95.0 37.0 0.0 18.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $t2 off 0 pos (-50.0 55.0 -15.0 90.0 37.0 0.0 -15.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}
hello_left(){
    local t1=${1:-4.0}
    local t2=${2:-0.5}
    echo "ctpq time $t1 off 0 pos (-50.0 55.0 -15.0 95.0 37.0 0.0 18.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t2 off 0 pos (-50.0 55.0 -15.0 90.0 37.0 0.0 -15.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t2 off 0 pos (-50.0 55.0 -15.0 95.0 37.0 0.0 18.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t2 off 0 pos (-50.0 55.0 -15.0 90.0 37.0 0.0 -15.0 0.0 10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

double_hello(){
    local t1=${1:-4.0}
    local t2=${2:-0.5}
    hello_right $t1 $t2 
    hello_left $t1 $t2
}

show_president(){
    local t1=${1:-4.0}
    echo "ctpq time $t1 off 0 pos (0.0 27.0 -42.0 40.0 -44.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}
#######################################################################################
# 3. EMPHASIS & EXPLANATION MOVEMENTS
#######################################################################################
making_a_point_right() {
    local t=${1:-7.0}
    echo "ctpq time $t off 0 pos (-60.0 20.0 0.0 90.0 0.0 0.0 0.0 30.0 60.0 0.0 0.0 55.0 46.0)" | yarp rpc /ctpservice/right_arm/rpc
}

making_a_point_left() {
    local t1=${1:-7.0}
    echo "ctpq time $t1 off 0 pos (-60.0 20.0 0.0 90.0 0.0 0.0 0.0 30.0 60.0 0.0 0.0 55.0 46.0)" | yarp rpc /ctpservice/left_arm/rpc
}

new_millenial() {
    local t=${1:-3.0}
    open_double $(echo "$t + 1.0" | bc)
    sleep 3.0
    echo "ctpq time $(echo "$t -1.0" | bc) off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    open_double $(echo "$t - 1.0" | bc)
    echo "ctpq time $t off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 3.0
    echo "ctpq time $t off 0 pos (-40.0 33.0 -22.0 61.0 -73.0 10.0 0.0 2.5 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 3.0
    home_left_arm $(echo "$t" | bc)
    sleep 3.0
}

calming_stability() {
    local t1=${1:-2.0}
    local t2=${2:-1.3}
    local t3=${3:-1.2}
    # Arms slightly raised, then pushed down with palms facing down to convey safety
    echo "ctpq time $t1 off 0 pos (-20.0 30.0 0.0 80.0 37.0 -15.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t1 off 0 pos (-20.0 30.0 0.0 80.0 37.0 -15.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time $t2 off 0 pos (-20.0 30.0 0.0 50.0 37.0 -15.0 8.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t2 off 0 pos (-20.0 30.0 0.0 50.0 37.0 -15.0 8.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time $t3 off 0 pos (-20.0 30.0 0.0 80.0 37.0 -15.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t3 off 0 pos (-20.0 30.0 0.0 80.0 37.0 -15.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.0
    echo "ctpq time $t3 off 0 pos (-20.0 30.0 0.0 50.0 37.0 -15.0 8.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $t3 off 0 pos (-20.0 30.0 0.0 50.0 37.0 -15.0 8.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
}

waving_hands() {
    local t=${1:-3.0}
    echo "ctpq time $t off 0 pos (-8.0 9.0 -9.0 62.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $t off 0 pos (-8.0 9.0 -9.0 62.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-8.0 9.0 -9.0 56.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-8.0 9.0 -9.0 85.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-8.0 9.0 -9.0 85.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-8.0 9.0 -9.0 56.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.5
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-8.0 9.0 -9.0 56.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-8.0 9.0 -9.0 85.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-8.0 9.0 -9.0 85.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $(echo "$t - 1.0" | bc) off 0 pos (-8.0 9.0 -9.0 56.0 -89.0 25.0 19.0 0.0 14.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
}

#######################################################################################
# 5. HEAD & GAZE MOVEMENTS
#######################################################################################
room_scan() {
    local t=${1:-3.0}
    # Slowly pans the head from left to right to look at the audience
    echo "ctpq time $t off 0 pos (0.0 0.0 30.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 3.0
    echo "ctpq time $t off 0 pos (0.0 0.0 -30.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep 3.0
    home_head $(echo "$t - 1.0" | bc)
}

nodding() {
    local t=${1:-2.0}
    # A single, deliberate nod to give emphasis
    echo "ctpq time $t off 0 pos (-10.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep $(echo "$t + 0" | bc)
    echo "ctpq time $t off 0 pos (3.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/head/rpc
    sleep $(echo "$t + 0" | bc)
    home_head $(echo "$t + 0.2" | bc)
}

### DEMO
demo(){
    echo "play rimini_speech.wav" | yarp rpc /yarpAudioPlayer/rpc &
    movements 
    wait
}

### UPDATED DEMO FUNCTION
movements(){
    # home_arms 3.0
    open_welcoming_arms 2.0
    # open_welcoming_arms 1.0
    sleep 3.0
    move_torso 2.5
    
    # "Benvenute e benvenuti, autorità, relatrici e relatori.."
    home_arms 3.0

    # 2. OPENING REMARKS
    # "È per me un onore aprire questo evento scientifico..."
    honor 2.0
    
    # "un percorso che attraversa cento anni di storia tecnica..."
    room_scan 3.0
    sleep 2.5
    timeline_sweep 3.0 
    home_right_arm 3.0
    stay_left 3.0
    home_arms 4.0
    # 3. HISTORICAL CONTEXT
    # "Il modo in cui verifichiamo la sicurezza... Negli anni della prima industrializzazione..."
    stay 4.0
    # stay 4.0
    home_arms 3.0
    room_scan 3.0
    stay_right 3.0
    stay_left 3.0
    sleep 3.0
    making_a_point_right 4.5 
    move_torso 4.0
    home_right_arm 3.0
    sleep 2.0
    # 4. EVOLUTION OF SAFETY
    # "Negli anni successivi è cresciuta la consapevolezza..."
    next_year 4.0
    sleep 4.0
    home_arms
    # # "Con il nuovo millennio si è affermato un principio chiave..."
    nodding 2.0
    sleep 7.0
    new_millenial
    
    home_arms 3.0
    sleep 3.0
    nodding
    # # 5. MODERN APPROACHES
    # # "Nascono così gli approcci di ispezione e manutenzione basati sul rischio..."
    making_a_point_left 4.5
    sleep 4.0
    home_left_arm 3.0
    stay_right 3.0
    sleep 3.0
    timeline_sweep 3.0
    home_right_arm 3.0
    stay_left 3.0
    sleep 5.0
    # # "Sensori, acquisizione digitale, verifiche da remoto..."arms_front
    home_arms 3.0
    nodding
    sleep 1.5
    arms_front 3.0 3.0
    sleep 1.5

    # # 6. SELF-INTRODUCTION (ergoCub)
    # # "Ed è qui che entra in gioco anche la mia presenza."
    hello_right 4.0 1.0
    hello_right 1.0 1.0

    # # "Io, ergoCab, rappresento il risultato concreto di questa evoluzione..."
    sleep 16.0
    calming_stability 2.0 1.3 1.2
    stay 4.0
    sleep 7.0
    
    # # "Sono il frutto dell'esperienza maturata nell'analisi di casi reali..."
    # honor 2.0
    # sleep 2.0
    # home_arms 3.0
    # sleep 2.0
    # # 7. CONCLUSION & HANDOVER
    making_a_point_right 4.5
    home_right_arm 3.0
    # # "Questo evento si colloca esattamente in questo punto di incontro..."
    timeline_sweep 5.0
    stay 4.0
    nodding
    sleep 8.0
    waving_hands
    home_arms 3.0
    sleep 4.0

    # # "A nome mio, e della tecnologia che rappresento..."
    room_scan 3.0
    home_head 2.0
    home_arms 3.0
    # stay_right 4.0 
    sleep 2.0
    open_welcoming_arms 3.0
    sleep 3.0

    # # "Vi ringrazio per l’attenzione e con grande piacere passo la parola al Presidente..."
    home_arms 3.0
    room_scan 3.0
    stay_left 4.0
    show_president 3.0

    sleep 8.0
    double_hello 4.0 1.0
    sleep 5.0
    double_hello 1.0 1.0
    # home_arms
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
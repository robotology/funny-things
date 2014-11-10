# HELPERS

vittoria_braccio_destro() {

    breathers "stop"
    #echo "ctpq time 1.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    
    # TODO: Add right arm joint coordinates here
    echo "ctpq time 1.0 off 0 pos ()" | yarp rpc /ctpservice/right_arm/rpc
    
    sleep 1.5 && smile && sleep 1.5
    go_home_helper 1.5
    sleep 2.0
    breathers "start"
}



# RISPOSTE

risposta_9() {
    breathers "start"
    
    speak "Mi hanno inventato scienziati italiani ed europei per realizzare una macchina in grado di sviluppare un'intelligenza simile a quella degli umani. Il responsabile del mio progetto è Giorgio Metta all'Istituto Italiano di Tecnologia, che è uno dei miei papà, ma ho anche tanti zii e amici che lavorano per migliorarmi. Tra qualche anno potrò aiutarvi nei lavori domestici, o in altre attività delicate per cui avrete bisogno di supporto, come per esempio l'assistenza degli anziani."
    sleep 10.0 && blink
    sleep 14.0 && blink
    sleep 12.0 && smile
    sleep 1.0 && blink
}

risposta_10() {
    breathers "start"
    
    speak "Sono un robot particolare, un robot umanoide. cioè con le sembianze simili a un essere umano"
    sleep 5.0 && blink
    sleep 5.0 && blink
    sleep 1.0 && smile
}

risposta_11() {
    breathers "start"
    
    speak "Mi trovo molto bene all'I I T, perché ci sono ricercatori da tutto il mondo che lavorano per creare tecnologie che cambieranno il mondo"
    sleep 4.0 && blink
    sleep 10.0 && smile
    sleep 1.0 && blink
}

risposta_12() {
    breathers "start"
    
    blink && sleep 0.5
    speak "Sono fatto di metallo, plastica e circuiti elettrici. ma i miei progettisti stanno pensando a nuovi materiali per rendermi più leggero e sicuro"
    sleep 5.0 && blink
    sleep 9.0 && smile && blink
}

risposta_13() {
    breathers "start"
    
    speak "in questo momento costo duecentocinquantamila euro, ma il mio progetto è opensource. Su internet si trova il disegno per costruire il mio corpo e il software per la base della mia intelligenza!"
    sleep 8.0 blink
    sleep 10.0 && smile && blink && blink
}

risposta_14() {
    breathers "start"
    
    speak "In futuro costerò di meno, meno di una siticar, sotto i diecimila euro, così che le persone potranno comprarmi per avermi in casa o in un ambiente lavorativo, e aiutarli in diversi compiti"
    sleep 8.0 && blink
    sleep 11.0 && smile
    sleep 0.5 && blink
}

risposta_15() {
    breathers "start"
    
    speak "i sentimenti di voi umani sono un fenomeno molto complesso che molti scienziati stanno studiando. Per il momento non è stato replicato dentro di me. Ma posso riconoscere, dall'espressione del vostro volto, se siete tristi o felici. Come un vero amico"
    sleep 9.0 && blink
    sleep 9.0 && blink && blink
    sleep 4.0 && smile
}

# LANCIO

lancio() {
    breathers "stop"

    vittoria_braccio_destro

    go_home
    breathers "start"    
}

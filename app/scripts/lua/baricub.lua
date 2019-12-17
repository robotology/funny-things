#!/usr/bin/lua

require("yarp")
yarp.Network()

port_events=yarp.Port()
port_speak_ita=yarp.Port()
port_speak_eng=yarp.Port()
port_events:open("/iCubBarMenu/manager/events:i")
port_speak_ita:open("/iCubBarMenu/manager/speak_ita:o")
port_speak_eng:open("/iCubBarMenu/manager/speak_eng:o")

yarp.NetworkBase_connect("/iCubBarMenu/events:o","/iCubBarMenu/manager/events:i")
yarp.NetworkBase_connect("/iCubBarMenu/manager/speak_ita:o","/iSpeak_ita")
yarp.NetworkBase_connect("/iCubBarMenu/manager/speak_eng:o","/iSpeak_eng")

event=yarp.Bottle()
port_events:read(event)
drink=event:tail():toString()
print("drink received: " .. drink)

speech=yarp.Bottle()
speech:addString("ah! bella scelta! allora adesso ti preparo un bel")
port_speak_ita:write(speech)
yarp.delay(4.5)

speech:clear()
speech:addString(drink)
port_speak_eng:write(speech)
yarp.delay(2.0)

print("./baricub.sh run_all")
os.execute("./baricub.sh run_all")

port_events:close()
port_speak_ita:close()
port_speak_eng:close()

yarp.Network_fini()


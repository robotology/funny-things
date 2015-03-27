#!/usr/bin/lua

require("yarp")
yarp.Network()

port_events=yarp.Port()
port_speak=yarp.Port()
port_speak_opt=yarp.Port()
port_events:open("/iCubBarMenu/manager/events:i")
port_speak:open("/iCubBarMenu/manager/speak:o")
port_speak_opt:open("/iCubBarMenu/manager/speak:rpc")

yarp.NetworkBase_connect("/iCubBarMenu/events:o","/iCubBarMenu/manager/events:i")
yarp.NetworkBase_connect("/iCubBarMenu/manager/speak:o","/iSpeak")
yarp.NetworkBase_connect("/iCubBarMenu/manager/speak:rpc","/iSpeak/rpc")

event=yarp.Bottle()
port_events:read(event)
drink=event:tail():toString()
print("drink received: " .. drink)

speech=yarp.Bottle()
speech:addString("ah! bella scelta! allora adesso ti preparo un bel")
port_speak:write(speech)
yarp.Time_delay(2.0)

opt=yarp.Bottle()
rep=yarp.Bottle()

opt:addString("stat")
while true do
    port_speak_opt:write(opt,rep)
    local ret=rep:toString()
    print("iSpeak is " .. ret)
    if ret=="quiet" then break end
    yarp.Time_delay(0.01)
end

opt:clear()
opt:addString("set")
opt:addString("opt")
opt:addString("icub_eng")
port_speak_opt:write(opt,rep)

speech:clear()
speech:addString(drink)
port_speak:write(speech)
yarp.Time_delay(1.0)

opt:clear()
opt:addString("set")
opt:addString("opt")
opt:addString("icub_ita")
port_speak_opt:write(opt,rep)

--print("./baricub.sh run_all")
--os.execute("./baricub.sh run_all")

port_events:close()
port_speak:close()
port_speak_opt:close()

yarp.Network_fini()

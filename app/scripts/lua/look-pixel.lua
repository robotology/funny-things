#!/usr/bin/lua

-- Copyright: (C) 2016 iCub Facility - Istituto Italiano di Tecnologia (IIT)
-- Authors: Ugo Pattacini <ugo.pattacini@iit.it>
--          Ali Paikan <ali.paikan@iit.it>
-- Copy Policy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

-- Dependencies
--
-- To install posix.signal do:
-- sudo apt-get install luarocks
-- sudo luarocks install luaposix


local signal = require("posix.signal")
require("yarp")

interrupting = false
signal.signal(signal.SIGINT, function(signum)
  interrupting = true
end)

signal.signal(signal.SIGTERM, function(signum)
  interrupting = true
end)

yarp.Network()

port_tx = yarp.BufferedPortBottle()
port_rx = yarp.BufferedPortBottle()

port_tx:open("/look-pixel/tx")
port_rx:open("/look-pixel/rx")


while not interrupting do
    local pixel = port_rx:read(false)
    if pixel ~= nil then
        local u = pixel:get(0):asInt()
        local v = pixel:get(1):asInt()

        local cmd = port_tx:prepare()
        cmd:clear()
        cmd:addString("left")
        cmd:addDouble(u)
        cmd:addDouble(v)
        cmd:addDouble(1.0)
        port_tx:write()
        print("looking at ", u,v)
    end
    
    yarp.Time_delay(0.2)
end

port_tx:close()
port_rx:close()

yarp.Network_fini()

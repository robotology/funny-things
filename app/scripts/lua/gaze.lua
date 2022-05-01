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

-- Command line parameters
-- --look-around to start in looking around mode

-- Available commands to be sent to /gaze
--
-- #1: look azi ele ver
-- #2: look-around
-- #3: look-around azi ele ver
-- #4: set-delta azi-delta ele-delta ver-delta
-- #5: idle
-- #6: quit

local signal = require("posix.signal")
require("yarp")

rf = yarp.ResourceFinder()
rf:setVerbose(false)
rf:configure(arg)

if rf:check("look-around") then
    state = "init"
else
    state = "idle"
end

interrupting = false
signal.signal(signal.SIGINT, function(signum)
  interrupting = true
end)

signal.signal(signal.SIGTERM, function(signum)
  interrupting = true
end)

yarp.Network()

port_cmd = yarp.BufferedPortBottle()
port_gaze_tx = yarp.BufferedPortBottle()
port_gaze_rx = yarp.BufferedPortBottle()

port_cmd:open("/gaze")
port_gaze_tx:open("/gaze/tx")
port_gaze_rx:open("/gaze/rx")

while not interrupting and port_gaze_rx:getInputCount() == 0 do
    print("checking yarp connection...")
    yarp.delay(1.0)
end

azi = 0.0
ele = 0.0
ver = 0.0
azi_delta = 2
ele_delta = 2
ver_delta = 1
t0 = yarp.now()


while state ~= "quit" and not interrupting do

    local cmd = port_cmd:read(false)
    if cmd ~= nil then
        local cmd_rx = cmd:get(0):asString()

        if cmd_rx == "look-around" or cmd_rx == "look" or
           cmd_rx == "idle" or cmd_rx == "quit" then

            state = cmd_rx

            if state == "look" then

                azi = cmd:get(1):asFloat64()
                ele = cmd:get(2):asFloat64()
                ver = cmd:get(3):asFloat64()
                print("received: look ", azi,ele,ver)

            elseif state == "look-around" then

                if cmd:size()>1 then

                    azi = cmd:get(1):asFloat64()
                    ele = cmd:get(2):asFloat64()
                    ver = cmd:get(3):asFloat64()

                else

                    local fp = port_gaze_rx:read(true)
                    azi = fp:get(0):asFloat64()
                    ele = fp:get(1):asFloat64()
                    ver = fp:get(2):asFloat64()

                end
                print("received: look around ", azi,ele,ver)

            end

        elseif cmd_rx == "set-delta" then

            azi_delta = cmd:get(1):asFloat64()
            ele_delta = cmd:get(2):asFloat64()
            ver_delta = cmd:get(3):asFloat64()
            print("received: set delta ", azi_delta,ele_delta,ver_delta)

        else

            print("warning: unrecognized command")

        end
    end

    if state == "init" then

        local fp = port_gaze_rx:read(true)
        azi = fp:get(0):asFloat64()
        ele = fp:get(1):asFloat64()
        ver = fp:get(2):asFloat64()
        state = "look-around"

    elseif state == "look" then

        local tx = port_gaze_tx:prepare()
        tx:clear()
        tx:addString("abs")
        tx:addDouble(azi)
        tx:addDouble(ele)
        tx:addDouble(ver)
        port_gaze_tx:write()
        print("looking at ", azi,ele,ver)
        yarp.delay(2.0)
        state = "idle"

    elseif state == "look-around" then

        local t1 = yarp.now()
        if t1-t0 > math.random(2,4) then
            local azi_new = azi + math.random(-azi_delta,azi_delta)
            local ele_new = ele + math.random(-ele_delta,ele_delta)
            local ver_new = ver + math.random(-ver_delta,ver_delta)
            local tx = port_gaze_tx:prepare()
            tx:clear()
            tx:addString("abs")
            tx:addDouble(azi_new)
            tx:addDouble(ele_new)
            tx:addDouble(ver_new)
            port_gaze_tx:write()
            print("looking around at ", azi_new,ele_new,ver_new)
            t0 = t1
        end

    elseif state == "idle" then

        yarp.delay(0.1)

    end
end

port_cmd:close()
port_gaze_tx:close()
port_gaze_rx:close()

yarp.Network_fini()

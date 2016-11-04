--
-- Copyright (C) 2016 IITRBCS
-- Authors: Vadim Tikhanoff
-- CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
--

-- loading lua-yarp binding library
require("yarp")

--
-- create is called when the port monitor is created
-- @return Boolean
--
PortMonitor.create = function(options)
    print("Just created a PM for the gaze!")
    return true;
end

--
-- destroy is called when port monitor is destroyed
--
PortMonitor.destroy = function()
    print("Just destroyed the PM for the gaze!")
end

--
-- accept is called when the port receives new data
-- @param thing The Things abstract data type
-- @return Boolean
-- if false is returned, the data will be ignored
-- and update() will never be called
PortMonitor.accept = function(thing)
    if thing:asBottle() == nil then
        print("bot_modifier.lua: got wrong data type (expected type Bottle)")
        return false
    end
    
    return true
end

--
-- update is called when the port receives new data
-- @param thing The Things abstract data type
-- @return Things
--PortMonitor.update = function(thing)
    
--    bt = thing:asBottle()
--    u = bt:get(0):asInt()
--    v = bt:get(1):asInt()
--    bt:clear()
--    bt:addString("left")
--    bt:addInt(u)
--    bt:addInt(v)
    
--    return thing
--end

PortMonitor.update = function(thing)
    
    bt = thing:asBottle()
    
    px = bt:get(0):asInt()
    py = bt:get(1):asInt()
    
    local tx = yarp.Property()
    th = yarp.Things()
    tx:clear()
    
    tx:put("control-frame","depth")
    tx:put("target-type","image")
    tx:put("image","depth")

    local location = yarp.Bottle()
    local val = location:addList()
    
    val:addDouble(320-px)
    val:addDouble(py)
    
    tx:put("target-location",location:get(0))
    
    print("look_at_pixel:", tx:toString())
    
    th:setPortWriter(tx)
    return th
    
end

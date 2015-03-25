#!/usr/bin/lua

require("yarp")
yarp.Network()

port=yarp.Port()
port:open("/lua")

bottle=yarp.Bottle();
port:read(bottle);
print(bottle:toString());

port:close()

yarp.Network_fini()

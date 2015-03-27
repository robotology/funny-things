#!/usr/bin/lua

require("yarp")
yarp.Network()

port=yarp.Port()
port:open("/lua")

bottle=yarp.Bottle();
port:read(bottle);
drink=bottle:get(1):toString();
print("drink received: " .. drink);
port:close()
yarp.Network_fini()

command="baricub speak ";
print(command .. drink);
os.execute(command .. drink);

print("baricub run_all");
os.execute("baricub run_all");

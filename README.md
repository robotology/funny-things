Funny Things
============

Funny-things is a repository which contains, among other funny things, a set of modules for easy scripting and execution of non-interactive (pre-programmed) demos. These modules (funnyPostures, iCubBlinker and iCubBreather) are devised to perform a set of actions, including moving, “breathing”,  blinking, face expressions, etc, which can be easily called from rpc commands. Ideally though, these calls are not done directly from such rpc commands, but through the use of bash (.sh) scripts, which allow easy synchronization, ordering and test of these calls so that they can be predefined for particular demos. 

Step-by-step guide 
Clone https://github.com/robotology/funny-things
Compile it from the root folder (./funny-things):
- ccmake from root (no ../)
- make
- make install

Open ’icubDemoScripts’ (or ‘icubDemoScriptsSIM’ to work on the simulator) templates, adapt them and save as apps.
Open or create a new script file (.sh) and modify or add any commands to suit your demo needs.
Set environment (start robot or run yarpserver and iCub_SIM on simulator). 
Open the ’icubDemoScripts’ (or ‘icubDemoScriptsSIM’ ) app and launch and connect modules.
On the terminal, go to the ./funny-things/app/scripts folder. 
Run any desired command from the command line as ./<scriptname>.sh <command>
- eg ./isp-movements welcome

For more info, see
- http://robotology.github.io/funny-things/
- https://github.com/robotology/funny-things
- http://robotology.github.io/funny-things/doxygen/doc/html/modules.html


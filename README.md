Funny Things
============

`funny-things` is a repository which contains, among other funny things, a set of modules for easy scripting and execution of non-interactive (pre-programmed) demos. These modules (`funnyPostures`, `iCubBlinker` and `gaze.lua`) are devised to perform a set of actions, including moving, gazing,  blinking, face expressions, etc, which can be easily handled through `rpc` commands. Moreover, these calls can be managed directly through the use of bash (`.sh`) scripts, which allow easy synchronization, ordering and test of these calls so that they can be predefined for particular demos. Several examples are available in the repo.

Step-by-step guide 
------------
  * Clone https://github.com/robotology/funny-things
  * Compile the project
    * `cd` into the repo folder (`./funny-things`)
    * `mkdir build`
    * `ccmake ../`
    * `make`
    * `make install`
  * Open `icubDemoScripts` (or `icubDemoScriptsSIM` to work on the simulator) template, adapt them and save as apps.
  * Open or create a new script file (`.sh`) and modify or add any commands to suit your demo needs.
  * Set robot environment (start robot or run `yarpserver` and `iCub_SIM` on simulator). 
  * If they are not running yet, open the emotions and speech applications:
    * `Face_Expressions`
    * `iCubSpeech`
  * Open the `icubDemoScripts` (or `icubDemoScriptsSIM` ) app and launch and connect modules.
  * On the terminal, go to the `./funny-things/app/scripts/shells` folder.
  * Run any desired command from the command line as `./<scriptname>.sh <command>` - eg `./isp-movements welcome`.
  * If new functionality is required, the easiest procedure is to copy an existing `.sh` with another name (`tg2.sh` can be a good starting point), and modify it to suit your needs.
 

For more info, see:

  * http://robotology.github.io/funny-things/
  * https://github.com/robotology/funny-things
  * http://robotology.github.io/funny-things/doxygen/doc/html/modules.html


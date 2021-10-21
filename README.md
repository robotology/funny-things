Funny Things
============

[![ZenHub](https://img.shields.io/badge/Shipping_faster_with-ZenHub-435198.svg)](https://zenhub.com)

![gh-pages](https://github.com/robotology/funny-things/workflows/GitHub%20Pages/badge.svg)

`funny-things` is a repository which contains, among other funny things, a set of modules for easy scripting and execution of non-interactive (pre-programmed) demos. These modules (`funnyPostures`, `iCubBlinker` and `gaze.lua`) are devised to perform a set of actions, including moving, gazing,  blinking, face expressions, etc, which can be easily handled through `rpc` commands. Moreover, these calls can be managed directly through the use of bash (`.sh`) scripts, which allow easy synchronization, ordering and test of these calls so that they can be predefined for particular demos. Several examples are available in the repo.

## Step-by-step guide
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
### `funnyThingsApp`

Enabling `CREATE_FUNNYTHINGSAPP` at configure time, it is possible to build the `funny-things` [electron](https://www.electronjs.org/) app, that allows to quickly and easily design awesome demos.
Here the dependencies:
 - npm >= 6.14.15
 - nodejs >= 10.19.0
 - electron-builder >= 22.11.7

And here the `funnyThingsApp.AppImage` in action:

https://user-images.githubusercontent.com/4537987/131512979-9686f8a3-7fd7-4d19-ad2c-d72c826d002b.mp4

Moreover, it is possibile to export the demo designed in the `.funnythings` format(that can be loaded and eventually modified through the app), and `.sh` format.

E.g:

https://user-images.githubusercontent.com/31577366/136387679-bfa5ab02-50bb-45bd-b42a-921f6fdf5d77.mp4


This app is just a higher layer for helping the user in designing the interaction with the robot, under the hood each action need that specific excutables are running:
- Movements/posture -> [`cptService`](https://github.com/robotology/icub-main/blob/master/src/modules/ctpService) for the parts involved
- Speak -> [`speech`](https://robotology.github.io/speech/doxygen/doc/html/modules.html) services
- Gaze movements -> [`iKinGazeCtrl`](https://robotology.github.io/robotology-documentation/doc/html/group__iKinGazeCtrl.html)
- Face expressions -> [`emotionInterface`](https://robotology.github.io/robotology-documentation/doc/html/group__icub__faceExpressions.html)

For more info, see:

  * https://robotology.github.io/funny-things
  * https://robotology.github.io/funny-things/doxygen/doc/html/modules.html


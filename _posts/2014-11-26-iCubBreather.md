---
title: iCubBreather
author: Alessandro Roncone
subtitle: A plug-and-play module to simulate the breathing of the iCub.
description: "The iCubBreather is a module that simulates the breathing of the iCub, by not keeping the robot still but instead moving it around a resting position."
layout: post
tags: [module,documentation]
header-bg: abstracts/abstract-10.jpg
category: module

---

The **iCubBreather** is a module developed by *Alessandro Roncone*; it is aimed at simulating the breathing of the iCub as well as providing an easy to use interface for it.

## Input Arguments
* `--context [funnyThings]`   where to find the called resource.
* `--from [iCubBreather.ini]` the name of the .ini file.
* `--name [iCubBreather]`     changes the name of the module. Any port name will be changed accordingly.
* `--robot [icub]`            defines which robot the module will interface with (either `icub` or `iCubSim`).
* `--part [left_arm]`         defines which body part the module will play with.
* `--rate  [4000]`            Period used by the thread.
* `--noiseStd [1.0]`          Standard deviation of the noise.
* `--refSpeeds [5.0]`         Reference speeds at the joints.
* `--verbosity [0]`           Verbosity level. The more the verbosity, the more will be printed out at stdio.
* `--autoStart`               Specifies if the module has to run automatically or not. By default, the `iCubBreather` does not run on its own: the user has to specify this flag in order to make it run.

## Input Ports
* `/iCubBreather/emotions/raw`: it is automatically connected to `/+robot+/face/raw/in`
* `/iCubBreather/rpc` it is an interface for handling the blinking. It accepts the following commands:
  * `start` start the module
  * `stop` stop the module
  * `get` get the module status (either `on` or `off`)
  * `blink` do a single blink
  * `dblink` do a double blink

# How does it work
The iCubBreather is a module that simulates the breathing of the iCub, by not keeping the robot still but instead moving it around a resting position. A single module works for single body part (either `head`, `left_arm`, `right_arm`, `torso`, `left_leg`, `right_leg`), so in order to make it work for the whole body the user has to call multiple modules.

Once called, the **iCubBreather** does nothing but staying silent. When the user starts it (e.g. either through the `autoStart` input argument or the `start` command via `rpc`), it takes the current body part configuration as resting configuration, and it applies a *Gaussian noise* with $\mu=0$. The standard deviation of the noise can be user-defined: by default is $5.0$ for any joint belonging to the body part, but the user has two choices here:

 1. assign a common standard deviation thorugh an input argument, i.e. `--noiseStd [double]`
 2. assign individual standard deviations through the config file. This solution will override the former, i.e. if the user specifies multiple standard deviations via config file.

Similarly, it is also possible to assign joint speeds to either all the body parts (through the input argument `--refSpeeds [double]`, or individually from config file.

# How to Use it

The default config file is the following:

{% highlight ruby %}
name         iCubBreather
rate         4000
robot        icub
verbosity    1
part         left_arm
noiseStd     1.5
refSpeeds    5.0

[left_arm]
noiseStds ( 0.1 4.0 0.1 4.0 2.0 2.0 2.0  5.0  5.0  5.0 10.0  5.0 10.0  5.0 10.0  5.0 )
refSpeeds ( 1.0 5.0 1.0 5.0 5.0 5.0 5.0 25.0 25.0 25.0 25.0 25.0 25.0 25.0 25.0 25.0 )

[right_arm]
noiseStds ( 0.1 4.0 0.1 4.0 2.0 2.0 2.0  5.0  5.0  5.0 10.0  5.0 10.0  5.0 10.0  5.0 )
refSpeeds ( 1.0 5.0 1.0 5.0 5.0 5.0 5.0 25.0 25.0 25.0 25.0 25.0 25.0 25.0 25.0 25.0 )

[head]
noiseStds ( 5.0 5.0 4.0  4.5  7.5  5.0 )
refSpeeds ( 5.0 5.0 5.0 80.0 80.0 50.0 )

[torso]
noiseStds ( 0.5 0.5 0.5 0.5 0.5 0.5 )
refSpeeds ( 5.0 5.0 5.0 5.0 5.0 5.0 )
{% endhighlight %}

By using this file, every body part (at least for the upper body) has a set of predefined **refSpeeds/noiseStds** pairs. The same configuration file accounts for multiple body parts, i.e. regardless of the body part the iCubBreather is called on, the module will pick up the correct configuration.

## iCubBreather with other modules

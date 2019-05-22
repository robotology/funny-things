
Funny Things Scripting :wrench:
=============================

This page contains various scripts that easily allow the robot, or the simulator, to perform pre-scripted movements (ranging from moving one single joint to the whole body). This is typically used for simple demos showcasing the iCub, television footage etc...

## Application template

In this repository you can find a couple of `applications xml templates` used for the funny things scripting:

In the scripts section  `/funny-things/app/scripts` you can find various templates, but the ones relevant are the following:

- `icubDemoScript.xml.template` : this launches the applications needed for the iCub robot
- `icubDemoScriptSIM.xml.template` : this launches the applications needed for the iCub simulator

The applications runs:

**gaze.lua** : lua scripts that connects to the iKinGazeCtrl and accepts some commands to move the head. By default it uses the `--look-around` parameter which randomly produces small movements of the head so that it is not fixed. 

**ctpService** : Module that controls the joints of the various parts needed. The parameters are `--robot icub` for the real robot or `--robot icubSim` and `--part ` that can be `left_arm` `right_arm` `torso` `head` `left_leg` `right_leg`. One instance of the module needs to be executed for each part. 

**iCubBlinker** : Module that controls the eyelids movements. By default the parameters are `--autoStart` which automatically makes them blink periodically. Note that the module will not do anything until the connection from itself `/iCubBlinker/emotions/raw` to the face interface `/icub/face/raw/in` is done. 

## Script examples

Once all the above modules are operational, we need to look into how the scirpts are constructed.
All the scripts are contructed **ad-hoc** for a specific purpose but one can recycle any movement or behaviour made previously in order to achieve his/her goals.
The scripts contains **functions** that will send specific commands to the `ctpService` ports, `emotion interfaces`, `speech ports`.

**For example** 
To make the robot `wave` its `right_arm`  in order to say hello there lets look at one available function called: 'hello_right': (this is available in any of the shell scripts of this repo)

```shell
hello_right() {
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 2.0
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    smile
    go_home
}
```
This contains `rpc commands` to the `ctpService` ports

The parameters here are:

**ctpq** ctpService command using a queue, therefore all the commands are stored in a queue and performed senquencially. 

**time** this determines the speed of the specific action. eg: How long it needs to reach the desired position from its current one.

**off** this specifies the joint offset. In this case the offset is 0, which means that the next parameter, **pos** will contain the full list of joint angles (16). One can specify an offset, eg: 6 which will consider only the joint angles of the hand and not the arm. Therefore the next parameter will contain only the remaining joint angles discarding the first ones offsetted.

**pos** this contains the list of the joint angles needed.

``Side Note``: The easy way to fill in the data for the movement, is by using the `yarpmotorgui` and going to the desired position. Save the joint angles and report them in the scripts. For ease of use, the part can be put in `idle` and moved to the desired position, then activated again.

The behaviour of the above function is:

1. lift the right arm up in 1.5 seconds
1. wait 2 seconds
1. moves the wrist 4 times left to right
1. calls the smile function. This calls another funtion typically in a script that connect to the face expession module and set the emotions to `all hap`. (you will need to have the face expression modules running).

```shell
smile() {
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}
```
5. calls another function to put the arm/arms back to a default `home` position. 


Obviously all the positions can be changed, and we suggest that you copy the structure of a script that you can find useful and create your own one. 


**Speech** 

To have the robot speak from commands within your script you will need to extend the `xml application` above with the following modules:

```xml
    <module>
        <name>yarpdev</name>
        <parameters>--device speech --lingware-context speech --default-language en-GB --robot r1 --pitch 80 --speed 100</parameters>
        <node>console</node>
    </module>

    <module>
        <name>iSpeak</name>
        <parameters>--package speech-dev</parameters>
        <node>console</node>
    </module>
```

and do the following connection:

```xml
    <connection>
        <from>/iSpeak/speech-dev/rpc</from>
        <to>/r1/speech:rpc</to>
        <protocol>tcp</protocol>
    </connection>
```

Once the modules are operational and the connection is made, one can simply run a speech command as such:

```shell
speak "Hello, I am a humanoid robot"
```

this calls the **speak** function that is found in any of the scripts in this repo, and sends the `string` to the iSpeak module

```shell
speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}
```

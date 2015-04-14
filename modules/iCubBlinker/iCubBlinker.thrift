# Copyright: (C) 2015 iCub Facility - Istituto Italiano di Tecnologia
# Authors: Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.
#
# iCubBlinker.thrift

/**
* iCubBlinker_IDL
*
* IDL Interface to \ref iCubBlinker services.
*/
service iCubBlinker_IDL
{
  bool   start();

  bool   stop();

  bool   status();

  bool   blink();

  bool   dblink();

  bool   save();

  bool   load();

  bool   set(1:string param, 2:string val);

  double get (1:string param);
  
  bool   calib();  

  /**
  * Quit the module.
  * @return true/false on success/failure.
  */
  bool   quit();  
}

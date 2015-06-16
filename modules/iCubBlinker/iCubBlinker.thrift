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
  /**
  * Starts the blinking behavior (if it was not started before).
  * @return true/false on success/failure.
  */
  bool start();

  /**
  * Starts the blinking behavior (if it was running).
  * @return true/false on success/failure.
  */
  bool stop();

  /**
  * Provides the status of the module.
  * @return a string with both the blinking status (either on or off),
  *         and the interaction mode in which the blinker is.
  */
  string status();

  /**
  * Performs a single blink.
  * @return true/false on success/failure.
  */
  bool blink();

  /**
  * Performs a double blink.
  * @return true/false on success/failure.
  */
  bool dblink();

  /**
  * Saves the module configuration into a .ini file (default context is
  * funnyThings, default file is iCubBreather.ini)
  * @return a string with the full path of the file it saved on.
  */
  string save();

  /**
  * Loads the calib configuration from a .ini file (default context is
  * funnyThings, default file is iCubBreather.ini)
  * @return a string with the full path of the file it loaded from.
  */
  string load();

  /**
  * Sets the minimum delta T between consecutive blinks.
  * @param val specifies the new value of min_dt
  * @return true/false on success/failure.
  */
  bool set_min_dt(1:double val);

  /**
  * Sets the maximum delta T between consecutive blinks.
  * @param val specifies the new value of max_dt
  * @return true/false on success/failure.
  */
  bool set_max_dt(1:double val);

  /**
  * Sets the interaction mode in which the module will go.
  * @param val specifies the new interaction mode
  *            (either idle or conversation for now).
  * @return true/false on success/failure.
  */
  bool set_interaction_mode(1:string val);

  /**
  * Gets the minimum delta T between consecutive blinks.
  * @return the current value of min_dt.
  */
  double get_min_dt();

  /**
  * Gets the maximum delta T between consecutive blinks.
  * @return the current value of max_dt.
  */
  double get_max_dt();

  /**
  * Gets the interaction mode in which the module is.
  * @return a string with the current interaction mode.
  */
  string get_interaction_mode();

  /**
  * Calibrate the servo of the eyelids.
  * NOT YET IMPLEMENTED
  * @return true/false on success/failure.
  */
  bool calib();
}

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
  bool blink_single();

  /**
  * Performs a fast blink.
  * @return true/false on success/failure.
  */
  bool blink_fast();

  /**
  * Performs a naturalistic blink.
  * @return true/false on success/failure.
  */
  bool blink_naturalistic();

  /**
  * Performs a double blink.
  * @return true/false on success/failure.
  */
  bool dblink();

  /**
  * Saves the module configuration into a .ini file (default context is
  * funnyThings, default file is iCubBlinker.ini)
  * @return a string with the full path of the file it saved on.
  */
  string save();

  /**
  * Loads the calib configuration from a .ini file (default context is
  * funnyThings, default file is iCubBlinker.ini)
  * @return a string with the full path of the file it loaded from.
  */
  string load();

  /**
  * Sets the interaction mode in which the module will go.
  * @param val string that specifies the new interaction mode
  *            (either idle or conversation for now).
  * @return true/false on success/failure.
  */
  bool set_interaction_mode(1:string val);

  /**
  * Gets the interaction mode in which the module is.
  * @return a string with the current interaction mode.
  */
  string get_interaction_mode();

  /**
  * Sets the blinking behavior.
  * @param val string that specifies the new blinking behavior
  *            (either naturalistic or fast).
  * @return true/false on success/failure.
  */
  bool set_blinking_behavior(1:string val);

  /**
  * Gets the blinking behavior used by the module.
  * @return a string with the current blinking behavior.
  */
  string get_blinking_behavior();

  /**
  * Sets the blinking period.
  * @param val string that specifies the new blinking period
  *            (either gaussian or fixed).
  * @return true/false on success/failure.
  */
  bool set_blinking_period(1:string val);

  /**
  * Gets the blinking period used by the module.
  * @return a string with the current blinking period.
  */
  string get_blinking_period();

  /**
  * Sets the double blink to either on or off.
  * @param val string that can be either on or off.
  * @return true/false on success/failure.
  */
  bool set_double_blink(1:string val);

  /**
  * Gets the double blink used by the module.
  * @return a string that is either on or off.
  */
  string get_double_blink();

  /**
  * Prints out the parameters that the iCubBlinker is currently using
  * @return the same string that has been printed out on the terminal window.
  */
  string print_params();

  /**
  * Calibrate the servo of the eyelids.
  * NOT IMPLEMENTED
  * @return true/false on success/failure.
  */
  bool calib();
}

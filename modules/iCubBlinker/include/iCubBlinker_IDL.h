// This is an automatically-generated file.
// It could get re-generated if the ALLOW_IDL_GENERATION flag is on.

#ifndef YARP_THRIFT_GENERATOR_iCubBlinker_IDL
#define YARP_THRIFT_GENERATOR_iCubBlinker_IDL

#include <yarp/os/Wire.h>
#include <yarp/os/idl/WireTypes.h>

class iCubBlinker_IDL;


/**
 * iCubBlinker_IDL
 * IDL Interface to \ref iCubBlinker services.
 */
class iCubBlinker_IDL : public yarp::os::Wire {
public:
  iCubBlinker_IDL();
  /**
   * Starts the blinking behavior (if it was not started before).
   * @return true/false on success/failure.
   */
  virtual bool start();
  /**
   * Starts the blinking behavior (if it was running).
   * @return true/false on success/failure.
   */
  virtual bool stop();
  /**
   * Provides the status of the module.
   * @return a string with both the blinking status (either on or off),
   *         and the interaction mode in which the blinker is.
   */
  virtual std::string status();
  /**
   * Performs a single blink.
   * @return true/false on success/failure.
   */
  virtual bool blink();
  /**
   * Performs a fast blink.
   * @return true/false on success/failure.
   */
  virtual bool blink_fast();
  /**
   * Performs a naturalistic blink.
   * @return true/false on success/failure.
   */
  virtual bool blink_naturalistic();
  /**
   * Performs a double blink.
   * @return true/false on success/failure.
   */
  virtual bool dblink();
  /**
   * Saves the module configuration into a .ini file (default context is
   * funnyThings, default file is iCubBlinker.ini)
   * @return a string with the full path of the file it saved on.
   */
  virtual std::string save();
  /**
   * Loads the calib configuration from a .ini file (default context is
   * funnyThings, default file is iCubBlinker.ini)
   * @return a string with the full path of the file it loaded from.
   */
  virtual std::string load();
  /**
   * Sets the interaction mode in which the module will go.
   * @param val specifies the new interaction mode
   *            (either idle or conversation for now).
   * @return true/false on success/failure.
   */
  virtual bool set_interaction_mode(const std::string& val);
  /**
   * Gets the interaction mode in which the module is.
   * @return a string with the current interaction mode.
   */
  virtual std::string get_interaction_mode();
  /**
   * Calibrate the servo of the eyelids.
   * NOT YET IMPLEMENTED
   * @return true/false on success/failure.
   */
  virtual bool calib();
  virtual bool read(yarp::os::ConnectionReader& connection);
  virtual std::vector<std::string> help(const std::string& functionName="--all");
};

#endif


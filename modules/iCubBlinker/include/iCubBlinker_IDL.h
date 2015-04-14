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
  virtual bool start();
  virtual bool stop();
  virtual bool status();
  virtual bool blink();
  virtual bool dblink();
  virtual bool save();
  virtual bool load();
  virtual bool set_param(const std::string& param, const std::string& val);
  virtual double get_parma(const std::string& param);
  virtual bool calib();
  /**
   * Quit the module.
   * @return true/false on success/failure.
   */
  virtual bool quit();
  virtual bool read(yarp::os::ConnectionReader& connection);
  virtual std::vector<std::string> help(const std::string& functionName="--all");
};

#endif


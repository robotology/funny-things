// This is an automatically-generated file.
// It could get re-generated if the ALLOW_IDL_GENERATION flag is on.

#include <iCubBlinker_IDL.h>
#include <yarp/os/idl/WireTypes.h>



class iCubBlinker_IDL_start : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_stop : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_status : public yarp::os::Portable {
public:
  std::string _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_blink : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_blink_fast : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_blink_naturalistic : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_dblink : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_save : public yarp::os::Portable {
public:
  std::string _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_load : public yarp::os::Portable {
public:
  std::string _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_set_interaction_mode : public yarp::os::Portable {
public:
  std::string val;
  bool _return;
  void init(const std::string& val);
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_get_interaction_mode : public yarp::os::Portable {
public:
  std::string _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_set_blinking_behavior : public yarp::os::Portable {
public:
  std::string val;
  bool _return;
  void init(const std::string& val);
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_get_blinking_behavior : public yarp::os::Portable {
public:
  std::string _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_set_blinking_period : public yarp::os::Portable {
public:
  std::string val;
  bool _return;
  void init(const std::string& val);
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_get_blinking_period : public yarp::os::Portable {
public:
  std::string _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_calib : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

bool iCubBlinker_IDL_start::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(1)) return false;
  if (!writer.writeTag("start",1,1)) return false;
  return true;
}

bool iCubBlinker_IDL_start::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_start::init() {
  _return = false;
}

bool iCubBlinker_IDL_stop::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(1)) return false;
  if (!writer.writeTag("stop",1,1)) return false;
  return true;
}

bool iCubBlinker_IDL_stop::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_stop::init() {
  _return = false;
}

bool iCubBlinker_IDL_status::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(1)) return false;
  if (!writer.writeTag("status",1,1)) return false;
  return true;
}

bool iCubBlinker_IDL_status::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readString(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_status::init() {
  _return = "";
}

bool iCubBlinker_IDL_blink::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(1)) return false;
  if (!writer.writeTag("blink",1,1)) return false;
  return true;
}

bool iCubBlinker_IDL_blink::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_blink::init() {
  _return = false;
}

bool iCubBlinker_IDL_blink_fast::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(2)) return false;
  if (!writer.writeTag("blink_fast",1,2)) return false;
  return true;
}

bool iCubBlinker_IDL_blink_fast::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_blink_fast::init() {
  _return = false;
}

bool iCubBlinker_IDL_blink_naturalistic::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(2)) return false;
  if (!writer.writeTag("blink_naturalistic",1,2)) return false;
  return true;
}

bool iCubBlinker_IDL_blink_naturalistic::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_blink_naturalistic::init() {
  _return = false;
}

bool iCubBlinker_IDL_dblink::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(1)) return false;
  if (!writer.writeTag("dblink",1,1)) return false;
  return true;
}

bool iCubBlinker_IDL_dblink::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_dblink::init() {
  _return = false;
}

bool iCubBlinker_IDL_save::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(1)) return false;
  if (!writer.writeTag("save",1,1)) return false;
  return true;
}

bool iCubBlinker_IDL_save::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readString(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_save::init() {
  _return = "";
}

bool iCubBlinker_IDL_load::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(1)) return false;
  if (!writer.writeTag("load",1,1)) return false;
  return true;
}

bool iCubBlinker_IDL_load::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readString(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_load::init() {
  _return = "";
}

bool iCubBlinker_IDL_set_interaction_mode::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(4)) return false;
  if (!writer.writeTag("set_interaction_mode",1,3)) return false;
  if (!writer.writeString(val)) return false;
  return true;
}

bool iCubBlinker_IDL_set_interaction_mode::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_set_interaction_mode::init(const std::string& val) {
  _return = false;
  this->val = val;
}

bool iCubBlinker_IDL_get_interaction_mode::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(3)) return false;
  if (!writer.writeTag("get_interaction_mode",1,3)) return false;
  return true;
}

bool iCubBlinker_IDL_get_interaction_mode::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readString(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_get_interaction_mode::init() {
  _return = "";
}

bool iCubBlinker_IDL_set_blinking_behavior::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(4)) return false;
  if (!writer.writeTag("set_blinking_behavior",1,3)) return false;
  if (!writer.writeString(val)) return false;
  return true;
}

bool iCubBlinker_IDL_set_blinking_behavior::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_set_blinking_behavior::init(const std::string& val) {
  _return = false;
  this->val = val;
}

bool iCubBlinker_IDL_get_blinking_behavior::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(3)) return false;
  if (!writer.writeTag("get_blinking_behavior",1,3)) return false;
  return true;
}

bool iCubBlinker_IDL_get_blinking_behavior::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readString(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_get_blinking_behavior::init() {
  _return = "";
}

bool iCubBlinker_IDL_set_blinking_period::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(4)) return false;
  if (!writer.writeTag("set_blinking_period",1,3)) return false;
  if (!writer.writeString(val)) return false;
  return true;
}

bool iCubBlinker_IDL_set_blinking_period::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_set_blinking_period::init(const std::string& val) {
  _return = false;
  this->val = val;
}

bool iCubBlinker_IDL_get_blinking_period::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(3)) return false;
  if (!writer.writeTag("get_blinking_period",1,3)) return false;
  return true;
}

bool iCubBlinker_IDL_get_blinking_period::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readString(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_get_blinking_period::init() {
  _return = "";
}

bool iCubBlinker_IDL_calib::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(1)) return false;
  if (!writer.writeTag("calib",1,1)) return false;
  return true;
}

bool iCubBlinker_IDL_calib::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_calib::init() {
  _return = false;
}

iCubBlinker_IDL::iCubBlinker_IDL() {
  yarp().setOwner(*this);
}
bool iCubBlinker_IDL::start() {
  bool _return = false;
  iCubBlinker_IDL_start helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::start()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::stop() {
  bool _return = false;
  iCubBlinker_IDL_stop helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::stop()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
std::string iCubBlinker_IDL::status() {
  std::string _return = "";
  iCubBlinker_IDL_status helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","std::string iCubBlinker_IDL::status()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::blink() {
  bool _return = false;
  iCubBlinker_IDL_blink helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::blink()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::blink_fast() {
  bool _return = false;
  iCubBlinker_IDL_blink_fast helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::blink_fast()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::blink_naturalistic() {
  bool _return = false;
  iCubBlinker_IDL_blink_naturalistic helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::blink_naturalistic()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::dblink() {
  bool _return = false;
  iCubBlinker_IDL_dblink helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::dblink()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
std::string iCubBlinker_IDL::save() {
  std::string _return = "";
  iCubBlinker_IDL_save helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","std::string iCubBlinker_IDL::save()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
std::string iCubBlinker_IDL::load() {
  std::string _return = "";
  iCubBlinker_IDL_load helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","std::string iCubBlinker_IDL::load()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::set_interaction_mode(const std::string& val) {
  bool _return = false;
  iCubBlinker_IDL_set_interaction_mode helper;
  helper.init(val);
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::set_interaction_mode(const std::string& val)");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
std::string iCubBlinker_IDL::get_interaction_mode() {
  std::string _return = "";
  iCubBlinker_IDL_get_interaction_mode helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","std::string iCubBlinker_IDL::get_interaction_mode()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::set_blinking_behavior(const std::string& val) {
  bool _return = false;
  iCubBlinker_IDL_set_blinking_behavior helper;
  helper.init(val);
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::set_blinking_behavior(const std::string& val)");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
std::string iCubBlinker_IDL::get_blinking_behavior() {
  std::string _return = "";
  iCubBlinker_IDL_get_blinking_behavior helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","std::string iCubBlinker_IDL::get_blinking_behavior()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::set_blinking_period(const std::string& val) {
  bool _return = false;
  iCubBlinker_IDL_set_blinking_period helper;
  helper.init(val);
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::set_blinking_period(const std::string& val)");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
std::string iCubBlinker_IDL::get_blinking_period() {
  std::string _return = "";
  iCubBlinker_IDL_get_blinking_period helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","std::string iCubBlinker_IDL::get_blinking_period()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::calib() {
  bool _return = false;
  iCubBlinker_IDL_calib helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::calib()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}

bool iCubBlinker_IDL::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  reader.expectAccept();
  if (!reader.readListHeader()) { reader.fail(); return false; }
  yarp::os::ConstString tag = reader.readTag();
  bool direct = (tag=="__direct__");
  if (direct) tag = reader.readTag();
  while (!reader.isError()) {
    // TODO: use quick lookup, this is just a test
    if (tag == "start") {
      bool _return;
      _return = start();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "stop") {
      bool _return;
      _return = stop();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "status") {
      std::string _return;
      _return = status();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeString(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "blink") {
      bool _return;
      _return = blink();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "blink_fast") {
      bool _return;
      _return = blink_fast();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "blink_naturalistic") {
      bool _return;
      _return = blink_naturalistic();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "dblink") {
      bool _return;
      _return = dblink();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "save") {
      std::string _return;
      _return = save();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeString(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "load") {
      std::string _return;
      _return = load();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeString(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "set_interaction_mode") {
      std::string val;
      if (!reader.readString(val)) {
        reader.fail();
        return false;
      }
      bool _return;
      _return = set_interaction_mode(val);
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "get_interaction_mode") {
      std::string _return;
      _return = get_interaction_mode();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeString(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "set_blinking_behavior") {
      std::string val;
      if (!reader.readString(val)) {
        reader.fail();
        return false;
      }
      bool _return;
      _return = set_blinking_behavior(val);
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "get_blinking_behavior") {
      std::string _return;
      _return = get_blinking_behavior();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeString(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "set_blinking_period") {
      std::string val;
      if (!reader.readString(val)) {
        reader.fail();
        return false;
      }
      bool _return;
      _return = set_blinking_period(val);
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "get_blinking_period") {
      std::string _return;
      _return = get_blinking_period();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeString(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "calib") {
      bool _return;
      _return = calib();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "help") {
      std::string functionName;
      if (!reader.readString(functionName)) {
        functionName = "--all";
      }
      std::vector<std::string> _return=help(functionName);
      yarp::os::idl::WireWriter writer(reader);
        if (!writer.isNull()) {
          if (!writer.writeListHeader(2)) return false;
          if (!writer.writeTag("many",1, 0)) return false;
          if (!writer.writeListBegin(BOTTLE_TAG_INT, static_cast<uint32_t>(_return.size()))) return false;
          std::vector<std::string> ::iterator _iterHelp;
          for (_iterHelp = _return.begin(); _iterHelp != _return.end(); ++_iterHelp)
          {
            if (!writer.writeString(*_iterHelp)) return false;
           }
          if (!writer.writeListEnd()) return false;
        }
      reader.accept();
      return true;
    }
    if (reader.noMore()) { reader.fail(); return false; }
    yarp::os::ConstString next_tag = reader.readTag();
    if (next_tag=="") break;
    tag = tag + "_" + next_tag;
  }
  return false;
}

std::vector<std::string> iCubBlinker_IDL::help(const std::string& functionName) {
  bool showAll=(functionName=="--all");
  std::vector<std::string> helpString;
  if(showAll) {
    helpString.push_back("*** Available commands:");
    helpString.push_back("start");
    helpString.push_back("stop");
    helpString.push_back("status");
    helpString.push_back("blink");
    helpString.push_back("blink_fast");
    helpString.push_back("blink_naturalistic");
    helpString.push_back("dblink");
    helpString.push_back("save");
    helpString.push_back("load");
    helpString.push_back("set_interaction_mode");
    helpString.push_back("get_interaction_mode");
    helpString.push_back("set_blinking_behavior");
    helpString.push_back("get_blinking_behavior");
    helpString.push_back("set_blinking_period");
    helpString.push_back("get_blinking_period");
    helpString.push_back("calib");
    helpString.push_back("help");
  }
  else {
    if (functionName=="start") {
      helpString.push_back("bool start() ");
      helpString.push_back("Starts the blinking behavior (if it was not started before). ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="stop") {
      helpString.push_back("bool stop() ");
      helpString.push_back("Starts the blinking behavior (if it was running). ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="status") {
      helpString.push_back("std::string status() ");
      helpString.push_back("Provides the status of the module. ");
      helpString.push_back("@return a string with both the blinking status (either on or off), ");
      helpString.push_back("        and the interaction mode in which the blinker is. ");
    }
    if (functionName=="blink") {
      helpString.push_back("bool blink() ");
      helpString.push_back("Performs a single blink. ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="blink_fast") {
      helpString.push_back("bool blink_fast() ");
      helpString.push_back("Performs a fast blink. ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="blink_naturalistic") {
      helpString.push_back("bool blink_naturalistic() ");
      helpString.push_back("Performs a naturalistic blink. ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="dblink") {
      helpString.push_back("bool dblink() ");
      helpString.push_back("Performs a double blink. ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="save") {
      helpString.push_back("std::string save() ");
      helpString.push_back("Saves the module configuration into a .ini file (default context is ");
      helpString.push_back("funnyThings, default file is iCubBlinker.ini) ");
      helpString.push_back("@return a string with the full path of the file it saved on. ");
    }
    if (functionName=="load") {
      helpString.push_back("std::string load() ");
      helpString.push_back("Loads the calib configuration from a .ini file (default context is ");
      helpString.push_back("funnyThings, default file is iCubBlinker.ini) ");
      helpString.push_back("@return a string with the full path of the file it loaded from. ");
    }
    if (functionName=="set_interaction_mode") {
      helpString.push_back("bool set_interaction_mode(const std::string& val) ");
      helpString.push_back("Sets the interaction mode in which the module will go. ");
      helpString.push_back("@param val string that specifies the new interaction mode ");
      helpString.push_back("           (either idle or conversation for now). ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="get_interaction_mode") {
      helpString.push_back("std::string get_interaction_mode() ");
      helpString.push_back("Gets the interaction mode in which the module is. ");
      helpString.push_back("@return a string with the current interaction mode. ");
    }
    if (functionName=="set_blinking_behavior") {
      helpString.push_back("bool set_blinking_behavior(const std::string& val) ");
      helpString.push_back("Sets the blinking behavior. ");
      helpString.push_back("@param val string that specifies the new blinking behavior ");
      helpString.push_back("           (either naturalistic or fast). ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="get_blinking_behavior") {
      helpString.push_back("std::string get_blinking_behavior() ");
      helpString.push_back("Gets the blinking behavior used by the module. ");
      helpString.push_back("@return a string with the current blinking behavior. ");
    }
    if (functionName=="set_blinking_period") {
      helpString.push_back("bool set_blinking_period(const std::string& val) ");
      helpString.push_back("Sets the blinking period. ");
      helpString.push_back("@param val string that specifies the new blinking period ");
      helpString.push_back("           (either gaussian or fixed). ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="get_blinking_period") {
      helpString.push_back("std::string get_blinking_period() ");
      helpString.push_back("Gets the blinking period used by the module. ");
      helpString.push_back("@return a string with the current blinking period. ");
    }
    if (functionName=="calib") {
      helpString.push_back("bool calib() ");
      helpString.push_back("Calibrate the servo of the eyelids. ");
      helpString.push_back("NOT IMPLEMENTED ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="help") {
      helpString.push_back("std::vector<std::string> help(const std::string& functionName=\"--all\")");
      helpString.push_back("Return list of available commands, or help message for a specific function");
      helpString.push_back("@param functionName name of command for which to get a detailed description. If none or '--all' is provided, print list of available commands");
      helpString.push_back("@return list of strings (one string per line)");
    }
  }
  if ( helpString.empty()) helpString.push_back("Command not found");
  return helpString;
}



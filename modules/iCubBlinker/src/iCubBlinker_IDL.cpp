// This is an automatically-generated file.
// It could get re-generated if the ALLOW_IDL_GENERATION flag is on.

#include <iCubBlinker_IDL.h>
#include <yarp/os/idl/WireTypes.h>



class iCubBlinker_IDL_blink_start : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_blink_stop : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_blink_status : public yarp::os::Portable {
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

class iCubBlinker_IDL_set_min_dt : public yarp::os::Portable {
public:
  double val;
  bool _return;
  void init(const double val);
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_set_max_dt : public yarp::os::Portable {
public:
  double val;
  bool _return;
  void init(const double val);
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

class iCubBlinker_IDL_get_min_dt : public yarp::os::Portable {
public:
  double _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_get_max_dt : public yarp::os::Portable {
public:
  double _return;
  void init();
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

class iCubBlinker_IDL_calib : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

bool iCubBlinker_IDL_blink_start::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(2)) return false;
  if (!writer.writeTag("blink_start",1,2)) return false;
  return true;
}

bool iCubBlinker_IDL_blink_start::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_blink_start::init() {
  _return = false;
}

bool iCubBlinker_IDL_blink_stop::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(2)) return false;
  if (!writer.writeTag("blink_stop",1,2)) return false;
  return true;
}

bool iCubBlinker_IDL_blink_stop::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_blink_stop::init() {
  _return = false;
}

bool iCubBlinker_IDL_blink_status::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(2)) return false;
  if (!writer.writeTag("blink_status",1,2)) return false;
  return true;
}

bool iCubBlinker_IDL_blink_status::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readString(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_blink_status::init() {
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

bool iCubBlinker_IDL_set_min_dt::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(4)) return false;
  if (!writer.writeTag("set_min_dt",1,3)) return false;
  if (!writer.writeDouble(val)) return false;
  return true;
}

bool iCubBlinker_IDL_set_min_dt::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_set_min_dt::init(const double val) {
  _return = false;
  this->val = val;
}

bool iCubBlinker_IDL_set_max_dt::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(4)) return false;
  if (!writer.writeTag("set_max_dt",1,3)) return false;
  if (!writer.writeDouble(val)) return false;
  return true;
}

bool iCubBlinker_IDL_set_max_dt::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_set_max_dt::init(const double val) {
  _return = false;
  this->val = val;
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

bool iCubBlinker_IDL_get_min_dt::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(3)) return false;
  if (!writer.writeTag("get_min_dt",1,3)) return false;
  return true;
}

bool iCubBlinker_IDL_get_min_dt::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readDouble(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_get_min_dt::init() {
  _return = (double)0;
}

bool iCubBlinker_IDL_get_max_dt::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(3)) return false;
  if (!writer.writeTag("get_max_dt",1,3)) return false;
  return true;
}

bool iCubBlinker_IDL_get_max_dt::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readDouble(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_get_max_dt::init() {
  _return = (double)0;
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
bool iCubBlinker_IDL::blink_start() {
  bool _return = false;
  iCubBlinker_IDL_blink_start helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::blink_start()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::blink_stop() {
  bool _return = false;
  iCubBlinker_IDL_blink_stop helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::blink_stop()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
std::string iCubBlinker_IDL::blink_status() {
  std::string _return = "";
  iCubBlinker_IDL_blink_status helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","std::string iCubBlinker_IDL::blink_status()");
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
bool iCubBlinker_IDL::set_min_dt(const double val) {
  bool _return = false;
  iCubBlinker_IDL_set_min_dt helper;
  helper.init(val);
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::set_min_dt(const double val)");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::set_max_dt(const double val) {
  bool _return = false;
  iCubBlinker_IDL_set_max_dt helper;
  helper.init(val);
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::set_max_dt(const double val)");
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
double iCubBlinker_IDL::get_min_dt() {
  double _return = (double)0;
  iCubBlinker_IDL_get_min_dt helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","double iCubBlinker_IDL::get_min_dt()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
double iCubBlinker_IDL::get_max_dt() {
  double _return = (double)0;
  iCubBlinker_IDL_get_max_dt helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","double iCubBlinker_IDL::get_max_dt()");
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
    if (tag == "blink_start") {
      bool _return;
      _return = blink_start();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "blink_stop") {
      bool _return;
      _return = blink_stop();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "blink_status") {
      std::string _return;
      _return = blink_status();
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
    if (tag == "set_min_dt") {
      double val;
      if (!reader.readDouble(val)) {
        reader.fail();
        return false;
      }
      bool _return;
      _return = set_min_dt(val);
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "set_max_dt") {
      double val;
      if (!reader.readDouble(val)) {
        reader.fail();
        return false;
      }
      bool _return;
      _return = set_max_dt(val);
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
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
    if (tag == "get_min_dt") {
      double _return;
      _return = get_min_dt();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeDouble(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "get_max_dt") {
      double _return;
      _return = get_max_dt();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeDouble(_return)) return false;
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
    helpString.push_back("blink_start");
    helpString.push_back("blink_stop");
    helpString.push_back("blink_status");
    helpString.push_back("blink");
    helpString.push_back("dblink");
    helpString.push_back("save");
    helpString.push_back("load");
    helpString.push_back("set_min_dt");
    helpString.push_back("set_max_dt");
    helpString.push_back("set_interaction_mode");
    helpString.push_back("get_min_dt");
    helpString.push_back("get_max_dt");
    helpString.push_back("get_interaction_mode");
    helpString.push_back("calib");
    helpString.push_back("help");
  }
  else {
    if (functionName=="blink_start") {
      helpString.push_back("bool blink_start() ");
      helpString.push_back("Starts the blinking behavior (if it was not started before). ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="blink_stop") {
      helpString.push_back("bool blink_stop() ");
      helpString.push_back("Starts the blinking behavior (if it was running). ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="blink_status") {
      helpString.push_back("std::string blink_status() ");
      helpString.push_back("Provides the status of the module. ");
      helpString.push_back("@return a string with both the blinking status (either on or off), ");
      helpString.push_back("        and the interaction mode in which the blinker is. ");
    }
    if (functionName=="blink") {
      helpString.push_back("bool blink() ");
      helpString.push_back("Performs a single blink. ");
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
      helpString.push_back("funnyThings, default file is iCubBreather.ini) ");
      helpString.push_back("@return a string with the full path of the file it saved on. ");
    }
    if (functionName=="load") {
      helpString.push_back("std::string load() ");
      helpString.push_back("Loads the calib configuration from a .ini file (default context is ");
      helpString.push_back("funnyThings, default file is iCubBreather.ini) ");
      helpString.push_back("@return a string with the full path of the file it loaded from. ");
    }
    if (functionName=="set_min_dt") {
      helpString.push_back("bool set_min_dt(const double val) ");
      helpString.push_back("Sets the minimum delta T between consecutive blinks. ");
      helpString.push_back("@param val specifies the new value of min_dt ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="set_max_dt") {
      helpString.push_back("bool set_max_dt(const double val) ");
      helpString.push_back("Sets the maximum delta T between consecutive blinks. ");
      helpString.push_back("@param val specifies the new value of max_dt ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="set_interaction_mode") {
      helpString.push_back("bool set_interaction_mode(const std::string& val) ");
      helpString.push_back("Sets the interaction mode in which the module will go. ");
      helpString.push_back("@param val specifies the new interaction mode ");
      helpString.push_back("           (either idle or conversation for now). ");
      helpString.push_back("@return true/false on success/failure. ");
    }
    if (functionName=="get_min_dt") {
      helpString.push_back("double get_min_dt() ");
      helpString.push_back("Gets the minimum delta T between consecutive blinks. ");
      helpString.push_back("@return the current value of min_dt. ");
    }
    if (functionName=="get_max_dt") {
      helpString.push_back("double get_max_dt() ");
      helpString.push_back("Gets the maximum delta T between consecutive blinks. ");
      helpString.push_back("@return the current value of max_dt. ");
    }
    if (functionName=="get_interaction_mode") {
      helpString.push_back("std::string get_interaction_mode() ");
      helpString.push_back("Gets the interaction mode in which the module is. ");
      helpString.push_back("@return a string with the current interaction mode. ");
    }
    if (functionName=="calib") {
      helpString.push_back("bool calib() ");
      helpString.push_back("Calibrate the servo of the eyelids. ");
      helpString.push_back("NOT YET IMPLEMENTED ");
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



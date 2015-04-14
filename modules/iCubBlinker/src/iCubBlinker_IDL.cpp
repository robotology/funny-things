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
  bool _return;
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
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_load : public yarp::os::Portable {
public:
  bool _return;
  void init();
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_set_param : public yarp::os::Portable {
public:
  std::string param;
  std::string val;
  bool _return;
  void init(const std::string& param, const std::string& val);
  virtual bool write(yarp::os::ConnectionWriter& connection);
  virtual bool read(yarp::os::ConnectionReader& connection);
};

class iCubBlinker_IDL_get_parma : public yarp::os::Portable {
public:
  std::string param;
  double _return;
  void init(const std::string& param);
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

class iCubBlinker_IDL_quit : public yarp::os::Portable {
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
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_status::init() {
  _return = false;
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
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_save::init() {
  _return = false;
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
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_load::init() {
  _return = false;
}

bool iCubBlinker_IDL_set_param::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(4)) return false;
  if (!writer.writeTag("set_param",1,2)) return false;
  if (!writer.writeString(param)) return false;
  if (!writer.writeString(val)) return false;
  return true;
}

bool iCubBlinker_IDL_set_param::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_set_param::init(const std::string& param, const std::string& val) {
  _return = false;
  this->param = param;
  this->val = val;
}

bool iCubBlinker_IDL_get_parma::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(3)) return false;
  if (!writer.writeTag("get_parma",1,2)) return false;
  if (!writer.writeString(param)) return false;
  return true;
}

bool iCubBlinker_IDL_get_parma::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readDouble(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_get_parma::init(const std::string& param) {
  _return = (double)0;
  this->param = param;
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

bool iCubBlinker_IDL_quit::write(yarp::os::ConnectionWriter& connection) {
  yarp::os::idl::WireWriter writer(connection);
  if (!writer.writeListHeader(1)) return false;
  if (!writer.writeTag("quit",1,1)) return false;
  return true;
}

bool iCubBlinker_IDL_quit::read(yarp::os::ConnectionReader& connection) {
  yarp::os::idl::WireReader reader(connection);
  if (!reader.readListReturn()) return false;
  if (!reader.readBool(_return)) {
    reader.fail();
    return false;
  }
  return true;
}

void iCubBlinker_IDL_quit::init() {
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
bool iCubBlinker_IDL::status() {
  bool _return = false;
  iCubBlinker_IDL_status helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::status()");
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
bool iCubBlinker_IDL::save() {
  bool _return = false;
  iCubBlinker_IDL_save helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::save()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::load() {
  bool _return = false;
  iCubBlinker_IDL_load helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::load()");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
bool iCubBlinker_IDL::set_param(const std::string& param, const std::string& val) {
  bool _return = false;
  iCubBlinker_IDL_set_param helper;
  helper.init(param,val);
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::set_param(const std::string& param, const std::string& val)");
  }
  bool ok = yarp().write(helper,helper);
  return ok?helper._return:_return;
}
double iCubBlinker_IDL::get_parma(const std::string& param) {
  double _return = (double)0;
  iCubBlinker_IDL_get_parma helper;
  helper.init(param);
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","double iCubBlinker_IDL::get_parma(const std::string& param)");
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
bool iCubBlinker_IDL::quit() {
  bool _return = false;
  iCubBlinker_IDL_quit helper;
  helper.init();
  if (!yarp().canWrite()) {
    yError("Missing server method '%s'?","bool iCubBlinker_IDL::quit()");
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
      bool _return;
      _return = status();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
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
      bool _return;
      _return = save();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "load") {
      bool _return;
      _return = load();
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "set_param") {
      std::string param;
      std::string val;
      if (!reader.readString(param)) {
        reader.fail();
        return false;
      }
      if (!reader.readString(val)) {
        reader.fail();
        return false;
      }
      bool _return;
      _return = set_param(param,val);
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeBool(_return)) return false;
      }
      reader.accept();
      return true;
    }
    if (tag == "get_parma") {
      std::string param;
      if (!reader.readString(param)) {
        reader.fail();
        return false;
      }
      double _return;
      _return = get_parma(param);
      yarp::os::idl::WireWriter writer(reader);
      if (!writer.isNull()) {
        if (!writer.writeListHeader(1)) return false;
        if (!writer.writeDouble(_return)) return false;
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
    if (tag == "quit") {
      bool _return;
      _return = quit();
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
    helpString.push_back("dblink");
    helpString.push_back("save");
    helpString.push_back("load");
    helpString.push_back("set_param");
    helpString.push_back("get_parma");
    helpString.push_back("calib");
    helpString.push_back("quit");
    helpString.push_back("help");
  }
  else {
    if (functionName=="start") {
      helpString.push_back("bool start() ");
    }
    if (functionName=="stop") {
      helpString.push_back("bool stop() ");
    }
    if (functionName=="status") {
      helpString.push_back("bool status() ");
    }
    if (functionName=="blink") {
      helpString.push_back("bool blink() ");
    }
    if (functionName=="dblink") {
      helpString.push_back("bool dblink() ");
    }
    if (functionName=="save") {
      helpString.push_back("bool save() ");
    }
    if (functionName=="load") {
      helpString.push_back("bool load() ");
    }
    if (functionName=="set_param") {
      helpString.push_back("bool set_param(const std::string& param, const std::string& val) ");
    }
    if (functionName=="get_parma") {
      helpString.push_back("double get_parma(const std::string& param) ");
    }
    if (functionName=="calib") {
      helpString.push_back("bool calib() ");
    }
    if (functionName=="quit") {
      helpString.push_back("bool quit() ");
      helpString.push_back("Quit the module. ");
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



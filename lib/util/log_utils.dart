
import 'package:flutter/services.dart';

class Log{
  
  static const perform = const MethodChannel("x_log");
  
  static d(String msg, {tag: 'X-LOG'}) {
    perform.invokeMethod('logD', {'tag': tag, 'msg': msg});
  }
  
  static w(String msg, {tag: 'X-LOG'}) {
    perform.invokeMethod('logW', {'tag': tag, 'msg': msg});
  }
  
  static i(String msg, {tag: 'X-LOG'}) {
    perform.invokeMethod('logI', {'tag': tag, 'msg': msg});
  }
  
  static e(String msg, {tag: 'X-LOG'}) {
    perform.invokeMethod('logE', {'tag': tag, 'msg': msg});
  }
  
  static json(String msg, {tag: 'X-LOG'}) {
    try {
      perform.invokeMethod('logJson', {'tag': tag, 'msg': msg});
    } catch (e) {
      d(msg);
    }
  }
}
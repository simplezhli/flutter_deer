
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Log{
  
  static const perform = const MethodChannel("x_log");
  
  static d(String msg, {tag: 'X-LOG'}) {
    perform.invokeMethod('logD', {'tag': tag, 'msg': msg});
    _print(msg);
  }
  
  static w(String msg, {tag: 'X-LOG'}) {
    perform.invokeMethod('logW', {'tag': tag, 'msg': msg});
    _print(msg);
  }
  
  static i(String msg, {tag: 'X-LOG'}) {
    perform.invokeMethod('logI', {'tag': tag, 'msg': msg});
    _print(msg);
  }
  
  static e(String msg, {tag: 'X-LOG'}) {
    perform.invokeMethod('logE', {'tag': tag, 'msg': msg});
    _print(msg);
  }
  
  static json(String msg, {tag: 'X-LOG'}) {
    try {
      perform.invokeMethod('logJson', {'tag': tag, 'msg': msg});
      _print(msg);
    } catch (e) {
      d(msg);
    }
  }

  static _print(String msg){
    if (defaultTargetPlatform == TargetPlatform.iOS){
      debugPrint(msg);
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_deer/common/common.dart';

class Log{
  
  static const perform = const MethodChannel("x_log");
  
  static d(String msg, {tag: 'X-LOG'}) {
    if (Constant.debuggable){
      perform.invokeMethod('logD', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }
  
  static w(String msg, {tag: 'X-LOG'}) {
    if (Constant.debuggable){
      perform.invokeMethod('logW', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }
  
  static i(String msg, {tag: 'X-LOG'}) {
    if (Constant.debuggable){
      perform.invokeMethod('logI', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }
  
  static e(String msg, {tag: 'X-LOG'}) {
    if (Constant.debuggable){
      perform.invokeMethod('logE', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }
  
  static json(String msg, {tag: 'X-LOG'}) {
    if (Constant.debuggable){
      perform.invokeMethod('logJson', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }

  static _print(String msg, {tag: 'X-LOG'}){
    if (defaultTargetPlatform == TargetPlatform.iOS){
      LogUtil.debuggable = Constant.debuggable;
      LogUtil.v(msg, tag: tag);
    }
  }
}
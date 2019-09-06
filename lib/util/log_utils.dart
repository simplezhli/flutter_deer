
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_deer/common/common.dart';

class Log{

  static var perform;

  static init() {
    if (perform == null){
      perform = const MethodChannel("x_log");
    }
  }

  static d(String msg, {tag: 'X-LOG'}) {
    if (!Constant.inProduction){
      perform?.invokeMethod('logD', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }

  static w(String msg, {tag: 'X-LOG'}) {
    if (!Constant.inProduction){
      perform?.invokeMethod('logW', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }

  static i(String msg, {tag: 'X-LOG'}) {
    if (!Constant.inProduction){
      perform?.invokeMethod('logI', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }

  static e(String msg, {tag: 'X-LOG'}) {
    if (!Constant.inProduction){
      perform?.invokeMethod('logE', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }

  static json(String msg, {tag: 'X-LOG'}) {
    if (!Constant.inProduction){
      perform?.invokeMethod('logJson', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }

  static _print(String msg, {tag: 'X-LOG'}){
    /// 单元测试不必初始化Log工具类，直接使用print输出。
    if (defaultTargetPlatform == TargetPlatform.iOS || perform == null){
      LogUtil.debuggable = !Constant.inProduction;
      LogUtil.v(msg, tag: tag);
    }
  }
}
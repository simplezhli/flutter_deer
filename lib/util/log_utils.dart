
import 'package:common_utils/common_utils.dart';
import 'package:flutter_deer/common/common.dart';

/// 输出Log工具类
class Log{

  static init() {
    LogUtil.debuggable = !Constant.inProduction;
  }

  static d(String msg, {tag: 'X-LOG'}) {
    if (!Constant.inProduction){
      LogUtil.v(msg, tag: tag);
    }
  }

  static e(String msg, {tag: 'X-LOG'}) {
    if (!Constant.inProduction){
      LogUtil.e(msg, tag: tag);
    }
  }

  static json(String msg, {tag: 'X-LOG'}) {
    if (!Constant.inProduction){
      LogUtil.v(msg, tag: tag);
    }
  }

  /// https://github.com/rhymelph/r_logger
  /// json format
  ///
  /// [s] your json
  static String jsonFormat(String s) {
    int level = 0;
    StringBuffer jsonForMatStr = StringBuffer();
    for (int index = 0; index < s.length; index++) {
      int c = s.codeUnitAt(index);
      if (level > 0 &&
          '\n'.codeUnitAt(0) ==
              jsonForMatStr.toString().codeUnitAt(jsonForMatStr.length - 1)) {
        jsonForMatStr.write(_getLevelStr(level));
      }
      if ('{'.codeUnitAt(0) == c || '['.codeUnitAt(0) == c) {
        jsonForMatStr.write(String.fromCharCode(c) + "\n");
        level++;
      } else if (','.codeUnitAt(0) == c) {
        jsonForMatStr.write(String.fromCharCode(c) + "\n");
      } else if ('}'.codeUnitAt(0) == c || ']'.codeUnitAt(0) == c) {
        jsonForMatStr.write("\n");
        level--;
        jsonForMatStr.write(_getLevelStr(level));
        jsonForMatStr.writeCharCode(c);
      } else {
        jsonForMatStr.writeCharCode(c);
      }
    }
    return jsonForMatStr.toString();
  }

  /// json level ping
  ///
  /// [level] your level
  static String _getLevelStr(int level) {
    StringBuffer levelStr = new StringBuffer();
    for (int levelI = 0; levelI < level; levelI++) {
      List<int> codeUnits = "\t".codeUnits;
      codeUnits.forEach((i) {
        levelStr.writeCharCode(i);
      });
    }
    return levelStr.toString();
  }
}
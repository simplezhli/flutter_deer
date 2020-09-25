
import 'package:flutter/services.dart';

class VersionUtils {
  static const MethodChannel _kChannel = MethodChannel('version');

  /// 应用安装
  static void install(String path) {
    _kChannel.invokeMethod<void>('install', {'path': path});
  }

  /// AppStore跳转
  static void jumpAppStore() {
    _kChannel.invokeMethod<void>('jumpAppStore');
  }
}
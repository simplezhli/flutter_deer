
import 'package:flutter/services.dart';

class VersionUtils{
  static const MethodChannel _channel = const MethodChannel('version');

  /// 应用安装
  static void install(String path){
    _channel.invokeMethod("install", {'path': path});
  }

  /// AppStore跳转
  static void jumpAppStore(){
    _channel.invokeMethod("jumpAppStore");
  }
}
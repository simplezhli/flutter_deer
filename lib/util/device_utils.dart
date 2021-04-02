
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
class Device {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
  static bool get isMobile => isAndroid || isIOS;
  static bool get isWeb => kIsWeb;

  static bool get isWindows => !isWeb && Platform.isWindows;
  static bool get isLinux => !isWeb && Platform.isLinux;
  static bool get isMacOS => !isWeb && Platform.isMacOS;
  static bool get isAndroid => !isWeb && Platform.isAndroid;
  static bool get isFuchsia => !isWeb && Platform.isFuchsia;
  static bool get isIOS => !isWeb && Platform.isIOS;

  static AndroidDeviceInfo _androidInfo;

  static Future<void> initDeviceInfo() async {
    if (isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      _androidInfo = await deviceInfo.androidInfo;
    }
  }

  /// 使用前记得初始化
  static int getAndroidSdkInt() {
    if (isAndroid && _androidInfo != null) {
      return _androidInfo.version.sdkInt;
    } else {
      return -1;
    }
  }
}
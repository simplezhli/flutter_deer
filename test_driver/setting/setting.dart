import 'package:flutter/material.dart';
import 'package:flutter_deer/setting/page/setting_page.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_deer/main.dart';

/// 运行 flutter drive --target=test_driver/setting/setting.dart
void main() {
  enableFlutterDriverExtension();
  runApp(MyApp(home: SettingPage()));
}
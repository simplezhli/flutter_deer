import 'package:sp_util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/setting/page/setting_page.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_deer/main.dart';

/// 运行 flutter drive --target=test_driver/setting/setting.dart
Future<void> main() async {
  enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();
  /// sp初始化
  await SpUtil.getInstance();
  runApp(MyApp(home: const SettingPage()));
}
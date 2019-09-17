import 'package:flutter_deer/common/common.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_deer/main.dart' as app;

/// 运行 flutter drive --target=test_driver/driver.dart
void main() {
  enableFlutterDriverExtension();
  Constant.isTest = true;
  app.main();
}
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_deer/main.dart' as app;

/// 集成测试运行 flutter drive --target=test_driver/driver.dart
void main() {
  enableFlutterDriverExtension();
  Constant.isDriverTest = true;
  app.main();
}
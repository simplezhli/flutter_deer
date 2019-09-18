import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main() {

  group('设置部分：', (){
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDown((){
      print('< Success');
    });

    tearDownAll(() async {
      driver?.close();
    });

    test("设置页测试",() async {
      await driver.tap(find.text('账号管理'));
      await delayed();
      await driver.tap(find.text('修改密码'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.text('检查更新'));
      await delayed();
      await driver.tap(find.text('残忍拒绝'));
      await delayed();
    });

    test("关于页面页测试",() async {
      await driver.tap(find.text('关于我们'));
      await delayed();
      await driver.tap(find.text('作者'));
      await Future.delayed(Duration(seconds: 3));
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
    });

  });
}
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main([List<String> args = const <String>[]]) {

  group('设置部分：', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDown(() {
      print('< Success');
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('设置页测试',() async {
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

    test('关于我们页测试',() async {
      await driver.tap(find.text('关于我们'));
      await delayed();
      await driver.tap(find.text('作者博客'));
      await Future<dynamic>.delayed(const Duration(seconds: 3));
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
    });

    test('夜间模式页测试',() async {
      await driver.tap(find.text('夜间模式'));
      await delayed();
      await driver.tap(find.text('开启'));
      await Future<dynamic>.delayed(const Duration(seconds: 2));
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      // 查看效果
      if (args.contains('backHome')) {
        await driver.tap(find.byTooltip('Back'));
        await delayed();
        await driver.tap(find.byTooltip('订单'));
        await delayed();
        await driver.tap(find.byTooltip('商品'));
        await delayed();
        await driver.tap(find.byTooltip('统计'));
        await delayed();
        await driver.tap(find.byTooltip('店铺'));
        await delayed();
        await driver.tap(find.byValueKey('setting'));
      }
    });

    test('多语言页测试',() async {
      await driver.tap(find.text('多语言'));
      await delayed();
      await driver.tap(find.text('English'));
      await Future<dynamic>.delayed(const Duration(seconds: 1));
      await driver.tap(find.byTooltip('Back'));
      await delayed();

      // 退出后在登录页查看效果
      await driver.tap(find.text('退出当前账号'));
      await delayed();
      await driver.tap(find.text('确定'));
      await delayed();
      // 登录页按钮点击
      await driver.tap(find.byValueKey('actionName'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.byValueKey('forgotPassword'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.byValueKey('noAccountRegister'));
    });
  });
}
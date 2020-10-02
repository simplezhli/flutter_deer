import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main() {

  group('账户部分：', () {
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

    test('账户流水页测试',() async {
      await driver.tap(find.byTooltip('店铺'));
      await delayed();
      await driver.tap(find.text('账户流水'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.text('提现账号'));
      await delayed();
      await driver.tap(find.text('微信'));
      await delayed();
      await delayed();
    });
    
    test('添加账号页测试',() async {
      await driver.tap(find.text('添加'));
      await delayed();
      await driver.tap(find.text('账号类型'));
      await delayed();
      await driver.tap(find.text('银行卡(对公账户)'));
      await delayed();
      // 选择城市
      await driver.tap(find.text('开  户  地'));
      await delayed();
      await driver.tap(find.text('北京市'));
      await delayed();
      // 选择银行
      await driver.tap(find.text('银行名称'));
      await delayed();
      await driver.tap(find.text('建设银行'));
      await delayed();

      await driver.tap(find.text('支行名称'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
    });

    test('资金管理页测试',() async {
      await driver.tap(find.text('资金管理'));
      await delayed();
      await driver.tap(find.text('提现记录'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
    });

    test('提现页测试',() async {
      await driver.tap(find.text('提现'));
      await delayed();
      await driver.tap(find.text('工商银行'));
      await delayed();
      await driver.tap(find.text('微信'));
      await delayed();
      await driver.tap(find.text('全部提现'));
      await delayed();
      await driver.tap(find.byValueKey('提现'));
      await delayed();
      await driver.tap(find.text('返回'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
    });

    test('提现密码页测试',() async {
      await driver.tap(find.text('提现密码'));
      await delayed();
      await driver.tap(find.text('修改密码'));
      await delayed();
      await driver.tap(find.text('2'));
      await driver.tap(find.text('1'));
      await driver.tap(find.text('6'));
      await driver.tap(find.text('8'));
      await driver.tap(find.text('9'));
      await driver.tap(find.text('0'));
      await delayed();
      await driver.tap(find.byValueKey('close'));
      await delayed();
      
      await driver.tap(find.text('忘记密码'));
      await delayed();
      await driver.tap(find.text('确定'));
      await delayed();
      await driver.tap(find.text('获取验证码'));
      await delayed();
      
      await driver.tap(find.byValueKey('vcode'));
      await delayed();
      await driver.enterText('111');
      await delayed();
      await driver.enterText('111222');
      await delayed();
      await driver.tap(find.byValueKey('dialog_close'));
      await delayed();
      
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      /// 进入设置页，便于执行设置模块测试操作
      await driver.tap(find.byValueKey('setting'));
    });
  });
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main() {

  group('店铺部分：', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDown(() {
      print('< Success');
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('店铺页测试',() async {
      await driver.tap(find.byTooltip('店铺'));
      await delayed();
      await driver.tap(find.byValueKey('message'), timeout: const Duration(minutes: 1),);
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      
    }, timeout: const Timeout.factor(3));

    test('店铺设置页测试',() async {
      await driver.tap(find.text('店铺设置'));
      await delayed();
      await driver.tap(find.text('店铺简介'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      // 弹框
      await driver.tap(find.text('支付方式'));
      await delayed();
      await driver.tap(find.text('货到付款'));
      await delayed();
      await driver.tap(find.text('确定'));
      await delayed();

      await driver.tap(find.text('配送费用'));
      await delayed();
      await driver.tap(find.byValueKey('price_input'));  // 点击输入框，给予焦点
      await driver.enterText('3.1');  // 输入内容
      await delayed();
      await driver.tap(find.text('确定'));
      await delayed();
      // 弹框
      await driver.tap(find.text('运费配置'));
      await delayed();
      await driver.tap(find.text('运费比例配置'));
      await delayed();
      await driver.tap(find.text('确定'));
      await delayed();
    });

    test('运费配置页测试',() async {
      await driver.tap(find.text('运费比例'));
      await delayed();
      await driver.tap(find.byValueKey('add'));
      await delayed();
      await driver.tap(find.byValueKey('订单金额0'));
      await delayed();
      await driver.tap(find.byValueKey('price_input'));  // 点击输入框，给予焦点
      await driver.enterText('3');  // 输入内容
      await delayed();
      await driver.tap(find.text('确定'));
      await delayed();
      await driver.tap(find.byValueKey('add'));
      await delayed();
      await driver.tap(find.text('重置'));
      await delayed();
      await driver.tap(find.text('完成'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
    });
    
  });
}
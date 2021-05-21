
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main() {

  group('统计部分：', () {
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

    test('统计页测试',() async {
      await driver.tap(find.byTooltip('统计'));
      await delayed();
      await driver.scroll(find.byValueKey('statistic_list'), 0, -300, scrollDuration);
      await delayed();
      
    });

    test('商品统计页测试',() async {
      await driver.tap(find.text('商品统计'));
      await delayed();
      await driver.tap(find.byValueKey('actionName'));
      await delayed();
      await driver.tap(find.byValueKey('actionName'));
      await delayed();
      await driver.scroll(find.byValueKey('goods_statistics_list'), 0, -300, scrollDuration);
      await delayed();
      await driver.scroll(find.byValueKey('goods_statistics_list'), 0, 300, scrollDuration);
      await delayed();
      await driver.tap(find.byTooltip('Back'));
    });

    test('订单统计页测试',() async {
      await driver.scroll(find.byValueKey('statistic_list'), 0, 300, scrollDuration);
      await delayed();
      await driver.tap(find.text('订单统计'));
      await delayed();
      await driver.tap(find.byValueKey('month'));
      await delayed();
      await driver.tap(find.byValueKey('year'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
    });
  });
}
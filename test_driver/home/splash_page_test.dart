
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main([List<String> args = const <String>[]]) {
  group('引导页：', () {
    late FlutterDriver driver;

    // 测试之前连接程序
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDown(() {
      print('< Success');
    });

    // 在测试完成后，关闭程序的连接。
    tearDownAll(() async {
      await driver.close();
    });

    test('测试引导页滑动',() async {
      final SerializableFinder swiperFinder = find.byValueKey('swiper');
      /// 引导页的第三张图
      final SerializableFinder imageFinder = find.byValueKey('app_start_3');
      await delayed();
      await driver.scrollUntilVisible(swiperFinder, imageFinder, dxScroll: -300);
    });
    
    test('点击最后一张引导图',() async {
      final SerializableFinder imageFinder = find.byValueKey('app_start_3');
      /// 点击第三张图片
      await driver.tap(imageFinder);
      await delayed();
    });
  });
}
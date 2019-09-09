import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main([List<String> args = const <String>[]]) {
  group('Splash Page', (){
    FlutterDriver driver;

    // 测试之前连接程序
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDown((){
      print('< Success');
    });

    // 在测试完成后，关闭程序的连接。
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("测试引导页滑动",() async {
      final swiperFinder = find.byValueKey('swiper');
      /// 引导页的第三张图
      final imageFinder = find.byValueKey('app_start_3');
      /// 适当延时，让操作节奏慢下来
      await Future<void>.delayed(const Duration(seconds: 1));
      await driver.scrollUntilVisible(swiperFinder, imageFinder, dxScroll: -300);
    });
    
    test("点击最后一张引导图",() async {
      final imageFinder = find.byValueKey('app_start_3');
      /// 点击第三张图片
      await driver.tap(imageFinder);
      await Future<void>.delayed(const Duration(seconds: 1));
    });
  });
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main() {

  group('审核部分：', () {
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
    
    test('店铺审核资料页测试',() async {
      await driver.tap(find.text('主营范围'));
      final SerializableFinder sortList = find.byValueKey('goods_sort');
      await delayed();
      
      await driver.scroll(sortList, 0.0, -300.0, scrollDuration);
      await delayed();
      await driver.scroll(sortList, 0.0, 100.0, scrollDuration);
      await driver.tap(find.text('休闲食品'));

      await delayed();
      await driver.tap(find.text('提交'));
    });

    test('审核结果页测试',() async {
      await delayed();
      await driver.tap(find.text('进入'));
    });
  });
}
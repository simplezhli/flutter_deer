
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main() {

  group('商品部分：', () {
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

    test('商品页测试',() async {
      await driver.tap(find.byTooltip('商品'));
      await delayed();
      await driver.tap(find.text('待售'));
      await delayed();
      final SerializableFinder pageView = find.byValueKey('pageView');
      await driver.scroll(pageView, 400.0, 0, scrollDuration);
      await delayed();
      
      await driver.tap(find.text('全部商品'));
      await delayed();
      await driver.tap(find.text('休闲食品'));
      await delayed();
      //进入搜索页
      await driver.tap(find.byValueKey('search'));
      await delayed();
      await driver.tap(find.byValueKey('search_back'));
      await delayed();
      //添加商品
      await driver.tap(find.byValueKey('add'));
      await delayed();
      await driver.tap(find.text('添加商品'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      // 商品菜单
      await driver.tap(find.byValueKey('goods_menu_item_2'));
      await delayed();
      await driver.tap(find.byValueKey('goods_operation_item_2'));
      await delayed();
      await driver.tap(find.byValueKey('goods_delete_item_2'));
      await delayed();
      await driver.tap(find.text('确认删除'));
      await delayed();
      await driver.tap(find.byValueKey('goods_menu_item_1'));
      await delayed();
      await driver.tap(find.byValueKey('goods_edit_item_1'));
      await delayed();
    });

    test('商品编辑页测试',() async {
      await driver.scroll(find.byValueKey('goods_edit_page'), 0, -500, scrollDuration);
      await delayed();
      await driver.tap(find.text('商品类型'));
      await delayed();
      await driver.tap(find.text('生鲜果蔬'));
      await delayed();
      await driver.tap(find.text('厨房用具'));
      await delayed();
      await driver.tap(find.text('碗碟'));
      await delayed();
    });

    test('商品规格页测试',() async {
      await driver.tap(find.text('商品规格'));
      await delayed();
      await driver.tap(find.byValueKey('hint'));
      await delayed();
      /// 在集成测试中不能点击特定的TextSpan，这里测试部分放在integration_test/goods_test.dart 实现
      /// https://github.com/flutter/flutter/issues/67123
      // await driver.tap(find.byValueKey('name_edit'));
      // await delayed();
      // await driver.tap(find.text('取消'));
      // await delayed();
      await driver.tap(find.byValueKey('2'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      // 侧滑删除
      await driver.scroll(find.byValueKey('2'), -100.0, 0, scrollDuration);
      await delayed();
      await driver.tap(find.byValueKey('delete_2'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
    });
  });
}
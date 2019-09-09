import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../login/login_page_test.dart' as login_test;

void main() {

  login_test.main();
  
  group('Store Page', (){
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDown((){
      print('< Success');
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    
    test("店铺审核资料页测试",() async {
      await driver.tap(find.text("主营范围"));
      final sortList = find.byValueKey('goods_sort');
      await Future<void>.delayed(const Duration(seconds: 1));
      
      await driver.scroll(sortList, 0.0, -300.0, const Duration(milliseconds: 300));
      await Future<void>.delayed(const Duration(milliseconds: 500));
      await driver.scroll(sortList, 0.0, 300.0, const Duration(milliseconds: 300));
      await driver.tap(find.text("休闲食品"));
      
      await Future<void>.delayed(const Duration(seconds: 1));
      await driver.tap(find.text('提交'));
    });

    test("审核结果页测试",() async {
      await Future<void>.delayed(const Duration(seconds: 1));
      await driver.tap(find.text('进入'));
    });
  });
}
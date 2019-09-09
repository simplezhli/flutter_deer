import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../home/splash_page_test.dart' as splash_test;

void main() {

  splash_test.main();
  
  group('Login Page', (){
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
    
    test("登录页按钮点击",() async {
      await driver.tap(find.text("验证码登录"));
      await driver.tap(find.byTooltip('Back'));
      await driver.tap(find.text("忘记密码"));
      await driver.tap(find.byTooltip('Back'));
      await driver.tap(find.text("还没账号？快去注册"));
    });

    test("注册页测试",() async {
      await driver.tap(find.text("获取验证码"));/// 无法成功触发事件，需要输入手机号
      
      var textField = find.byValueKey('phone');
      await driver.tap(textField);  // 点击输入框，给予焦点
      await driver.enterText('15000000000');  // 输入内容
      await Future<void>.delayed(const Duration(seconds: 1));
      
      await driver.tap(find.text("获取验证码"));
      
      var textField2 = find.byValueKey('vcode');
      await driver.tap(textField2);
      await driver.enterText('123456');
      await Future<void>.delayed(const Duration(seconds: 1));
      
      var textField3 = find.byValueKey('password');
      await driver.tap(textField3);
      await driver.enterText('111111');
      await Future<void>.delayed(const Duration(seconds: 1));

      await driver.tap(find.byValueKey('register')); // 点击注册
      
      // 清除输入框文字
      await driver.tap(find.byValueKey('password_delete'));
      
      await Future<void>.delayed(const Duration(seconds: 1));
      await driver.tap(find.byTooltip('Back'));
    }, timeout: const Timeout(Duration(seconds: 30)));

    test("登录页测试",() async {
      var textField = find.byValueKey('phone');
      await driver.tap(textField);
      await driver.enterText('15000000000');
      await Future<void>.delayed(const Duration(seconds: 1));
      var textField2 = find.byValueKey('password');
      await driver.tap(textField2);
      await driver.enterText('111111');
      await Future<void>.delayed(const Duration(seconds: 1));
      // 点击密码可见两次
      await driver.tap(find.byValueKey('password_showPwd'));
      await Future<void>.delayed(const Duration(seconds: 1));
      await driver.tap(find.byValueKey('password_showPwd'));
      await Future<void>.delayed(const Duration(seconds: 1));
      await driver.tap(find.byValueKey('login')); // 点击登录
    }, timeout: const Timeout(Duration(seconds: 30)));
  });
}
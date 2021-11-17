import 'package:flutter/material.dart';
import 'package:flutter_deer/login/page/login_page.dart';
import 'package:flutter_deer/login/page/register_page.dart';
import 'package:flutter_deer/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


///  flutter drive --driver integration_test/integration_test.dart --target integration_test/login_test.dart
void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('登录部分：', () {

    tearDown(() {
      print('< Success');
    });

    testWidgets('登录页按钮点击',(WidgetTester tester) async {
      runApp(MyApp(home: const LoginPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('actionName')));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('forgotPassword')));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('noAccountRegister')));
    });

    testWidgets('注册页测试',(WidgetTester tester) async {
      runApp(MyApp(home: const RegisterPage()));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('getVerificationCode')));/// 无法成功触发事件，需要输入手机号
      
      final Finder textField = find.byKey(const Key('phone'));
      await tester.enterText(textField, '15000000000');  // 输入内容
      await tester.pumpAndSettle();
      
      await tester.tap(find.byKey(const Key('getVerificationCode')));

      final Finder textField2 = find.byKey(const Key('vcode'));
      await tester.enterText(textField2, '123456');
      await tester.pumpAndSettle();

      final Finder textField3 = find.byKey(const Key('password'));
      await tester.enterText(textField3, '111111');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('register'))); // 点击注册
      
      // 清除输入框文字
      await tester.pumpAndSettle();
      expect(find.text('111111'), findsOneWidget);
      await tester.tap(find.byKey(const Key('password_delete')));
      expect(find.text('111111'), findsNothing);

      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
    }, timeout: const Timeout(Duration(seconds: 30)));

    testWidgets('登录页测试',(WidgetTester tester) async {
      runApp(MyApp(home: const LoginPage()));
      await tester.pumpAndSettle();
      final Finder textField = find.byKey(const Key('phone'));
      await tester.enterText(textField, '15000000000');
      await tester.pumpAndSettle();
      final Finder textField2 = find.byKey(const Key('password'));
      await tester.enterText(textField2, '111111');
      await tester.pumpAndSettle();
      // 点击密码可见两次
      await tester.tap(find.byKey(const Key('password_showPwd')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('password_showPwd')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('login'))); // 点击登录
    }, timeout: const Timeout(Duration(seconds: 30)));
  });
}
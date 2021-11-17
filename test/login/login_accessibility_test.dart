import 'package:flutter/material.dart';
import 'package:flutter_deer/login/page/login_page.dart';
import 'package:flutter_deer/login/page/register_page.dart';
import 'package:flutter_deer/login/page/reset_password_page.dart';
import 'package:flutter_deer/login/page/sms_login_page.dart';
import 'package:flutter_deer/login/page/update_password_page.dart';
import 'package:flutter_deer/main.dart';
import 'package:flutter_deer/setting/provider/theme_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final Map<String, Widget> map = <String, Widget>{};
  map['login_page'] = const LoginPage();
  map['register_page'] = const RegisterPage();
  map['reset_password_page.dart'] = const ResetPasswordPage();
  map['sms_login_page.dart'] = const SMSLoginPage();
  map['update_password_page.dart'] = const UpdatePasswordPage();
 
  /// 这里就不检测页面可点击目标大小了，因为不符合。。。
  
  group('login => 检测页面可点击目标是否都有语义', () {
    final ThemeData themeData = ThemeProvider().getTheme();
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MyApp(home: page, theme: themeData,));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });

}

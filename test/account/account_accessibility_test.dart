import 'package:flutter/material.dart';
import 'package:flutter_deer/account/page/account_page.dart';
import 'package:flutter_deer/account/page/account_record_list_page.dart';
import 'package:flutter_deer/account/page/add_withdrawal_account_page.dart';
import 'package:flutter_deer/account/page/bank_select_page.dart';
import 'package:flutter_deer/account/page/city_select_page.dart';
import 'package:flutter_deer/account/page/withdrawal_account_list_page.dart';
import 'package:flutter_deer/account/page/withdrawal_account_page.dart';
import 'package:flutter_deer/account/page/withdrawal_page.dart';
import 'package:flutter_deer/account/page/withdrawal_password_page.dart';
import 'package:flutter_deer/account/page/withdrawal_record_list_page.dart';
import 'package:flutter_deer/account/page/withdrawal_result_page.dart';
import 'package:flutter_deer/setting/provider/theme_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  final Map<String, Widget> map = <String, Widget>{};
  map['account_page'] = const AccountPage();
  map['account_record_list_page'] = const AccountRecordListPage();
  map['add_withdrawal_account_page'] = const AddWithdrawalAccountPage();
  map['bank_select_page'] = const BankSelectPage();
  map['city_select_page'] = const CitySelectPage();
  map['withdrawal_account_list_page'] = const WithdrawalAccountListPage();
  map['withdrawal_account_page'] = const WithdrawalAccountPage();
  map['withdrawal_page'] = const WithdrawalPage();
  map['withdrawal_password_page'] = const WithdrawalPasswordPage();
  map['withdrawal_record_list_page'] = const WithdrawalRecordListPage();
  map['withdrawal_result_page'] = const WithdrawalResultPage();
  
  group('account => 检测页面可点击目标大小是否大于44 * 44', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      });
    });
  });

  /// 例如图片可点击，但没加语义，就会报错。
  group('account => 检测页面可点击目标是否都有语义', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });

  /// （这个测试仅为示例展示，由于本项目文字与背景遵照设计图，此项测试多处不通过，因此后面的模块不进行此项测试）
  group('account => 检测页面文本对比度是否满足最小值的准则', () {
    final List<ThemeData> themes = <ThemeData>[
      ThemeProvider().getTheme(),
      ThemeProvider().getTheme(isDarkMode: true),
    ];

    const List<String> themeNames = <String>[
      'LightTheme',
      'DarkTheme',
    ];

    for (int themeIndex = 0; themeIndex < themes.length; themeIndex += 1) {
      final ThemeData theme = themes[themeIndex];
      final String themeName = themeNames[themeIndex];

      map.forEach((name, page) {
        testWidgets('$name $themeName', (WidgetTester tester) async {
          tester.binding.addTime(const Duration(seconds: 3));
          final SemanticsHandle handle = tester.ensureSemantics();
          await tester.pumpWidget(MaterialApp(theme: theme, home: page));
          await expectLater(tester, meetsGuideline(textContrastGuideline));
          handle.dispose();
        }, skip:
            name == 'add_withdrawal_account_page' ||
            name == 'withdrawal_page' ||
            name == 'withdrawal_result_page'
        ); // https://github.com/flutter/flutter/issues/21647
      });
    }
  });
}

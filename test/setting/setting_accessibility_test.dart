import 'package:flutter/material.dart';
import 'package:flutter_deer/setting/provider/theme_provider.dart';
import 'package:flutter_deer/setting/page/about_page.dart';
import 'package:flutter_deer/setting/page/account_manager_page.dart';
import 'package:flutter_deer/setting/page/setting_page.dart';
import 'package:flutter_deer/setting/page/theme_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final Map<String, Widget> map = <String, Widget>{};
  map['about_page'] = const AboutPage();
  map['account_manager_page'] = const AccountManagerPage();
  map['setting_page'] = const SettingPage();
  map['theme_page'] = const ThemePage();
  
  group('setting => 检测页面可点击目标大小是否大于44 * 44', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      });
    });
  });

  group('setting => 检测页面可点击目标是否都有语义', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });

  group('setting => 检测页面文本对比度是否满足最小值的准则', () {
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
        });
      });
    }
  });
}

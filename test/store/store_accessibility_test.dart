
import 'package:flutter/material.dart';
import 'package:flutter_deer/provider/theme_provider.dart';
import 'package:flutter_deer/store/page/store_audit_page.dart';
import 'package:flutter_deer/store/page/store_audit_result_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  var map = Map<String, Widget>();
  map['store_audit_page'] = StoreAuditPage();
  map['store_audit_result_page'] = StoreAuditResultPage();

  group('store => 检测页面可点击目标大小是否小于44 * 44', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      });
    });
  });
  
  group('store => 检测页面可点击目标是否都有语义', () {
    ThemeData themeData = ThemeProvider().getTheme();
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page, theme: themeData,));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });

}

import 'package:flutter/material.dart';
import 'package:flutter_deer/shop/page/freight_config_page.dart';
import 'package:flutter_deer/shop/page/input_text_page.dart';
import 'package:flutter_deer/shop/page/message_page.dart';
import 'package:flutter_deer/shop/page/select_address_page.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/shop/page/shop_setting_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final Map<String, Widget> map = <String, Widget>{};
  map['shop_page'] = const ShopPage(isAccessibilityTest: true,);
  map['shop_setting_page'] = const ShopSettingPage();
  map['select_address_page'] = const AddressSelectPage();
  map['message_page'] = const MessagePage();
  map['input_text_page'] = const InputTextPage(title: '测试', hintText: '输入测试内容');
  map['freight_config_page'] = const FreightConfigPage();

  group('shop => 检测页面可点击目标大小是否大于44 * 44', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      }, skip: name == 'select_address_page' || name == 'freight_config_page');
    });
  });

  group('shop => 检测页面可点击目标是否都有语义', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/page/goods_edit_page.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/goods/page/goods_search_page.dart';
import 'package:flutter_deer/goods/page/goods_size_edit_page.dart';
import 'package:flutter_deer/goods/page/goods_size_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final Map<String, Widget> map = <String, Widget>{};
  map['goods_page'] = const GoodsPage();
  map['goods_edit_page'] = const GoodsEditPage();
  map['goods_search_page'] = const GoodsSearchPage();
  map['goods_size_page'] = const GoodsSizePage();
  map['goods_size_edit_page'] = const GoodsSizeEditPage();
  
  group('goods => 检测页面可点击目标大小是否大于44 * 44', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
       
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        if (name == 'goods_page') {
          // GoodsListPage 内有一个2秒的延时
          await tester.pumpAndSettle(const Duration(seconds: 2));
        }
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      }, skip: name == 'goods_search_page' || name == 'goods_size_page'); // https://github.com/flutter/flutter/issues/42455
    });
  });

  group('goods => 检测页面可点击目标是否都有语义', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        if (name == 'goods_page') {
          await tester.pumpAndSettle(const Duration(seconds: 2));
        }
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });

}

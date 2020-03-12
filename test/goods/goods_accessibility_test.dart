
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/page/goods_edit_page.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/goods/page/goods_search_page.dart';
import 'package:flutter_deer/goods/page/goods_size_edit_page.dart';
import 'package:flutter_deer/goods/page/goods_size_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  var map = Map<String, Widget>();
  map['goods_page'] = GoodsPage();
  map['goods_edit_page'] = GoodsEditPage();
  map['goods_search_page'] = GoodsSearchPage();
  map['goods_size_page'] = GoodsSizePage();
  map['goods_size_edit_page'] = GoodsSizeEditPage();
  
  group('goods => 检测页面可点击目标大小是否小于44 * 44', () {
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
      }, skip: (name == 'goods_search_page' || name == 'goods_size_page')); // https://github.com/flutter/flutter/issues/42455
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

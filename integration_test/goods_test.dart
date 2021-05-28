import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_deer/goods/page/goods_edit_page.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/goods/page/goods_size_page.dart';
import 'package:flutter_deer/main.dart';
import 'package:flutter_deer/res/constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


///  flutter drive --driver integration_test/integration_test.dart --target integration_test/goods_test.dart
void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('商品部分：', () {

    Constant.isDriverTest = true;

    tearDown(() {
      print('< Success');
    });

    testWidgets('商品页测试',(WidgetTester tester) async {
      runApp(MyApp(home: const GoodsPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('待售'));
      await tester.pumpAndSettle();

      final Finder pageView = find.byKey(const Key('pageView'));
      await tester.drag(pageView, const Offset(400, 0));
      await tester.pumpAndSettle();

      await tester.tap(find.text('全部商品'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('休闲食品'));
      await tester.pumpAndSettle();
      //进入搜索页
      await tester.tap(find.byKey(const Key('search')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('search_back')));
      await tester.pumpAndSettle();
      //添加商品
      await tester.tap(find.byKey(const Key('add')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('添加商品'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      // 商品菜单
      await tester.tap(find.byKey(const Key('goods_menu_item_2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('goods_operation_item_2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('goods_delete_item_2')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('确认删除'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('goods_menu_item_1')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('goods_edit_item_1')));
      await tester.pumpAndSettle();
    });

    testWidgets('商品编辑页测试',(WidgetTester tester) async {
      runApp(MyApp(home: const GoodsEditPage()));
      await tester.pumpAndSettle();

      await tester.drag(find.byKey(const Key('goods_edit_page')), const Offset(0, -500));
      await tester.pumpAndSettle();
      await tester.tap(find.text('商品类型'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('生鲜果蔬'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('厨房用具'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('碗碟'));
      await tester.pumpAndSettle();
    }, timeout: const Timeout(Duration(seconds: 30)));

    testWidgets('商品规格页测试',(WidgetTester tester) async {
      runApp(MyApp(home: const GoodsSizePage()));

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('hint')));
      await tester.pumpAndSettle();

      final richText = find.byKey(const Key('name_edit')).first;
      fireOnTap(richText, '编辑');
      await tester.pumpAndSettle();
      await tester.tap(find.text('取消'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      // 侧滑删除
      await tester.drag(find.byKey(const Key('2')), const Offset(-100, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('delete_2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
    }, timeout: const Timeout(Duration(seconds: 30)));
  });
}

/// https://github.com/flutter/flutter/issues/56023
/// Runs the onTap handler for the [TextSpan] which matches the search-string.
void fireOnTap(Finder finder, String text) {
  final Element element = finder.evaluate().single;
  final RenderParagraph paragraph = element.renderObject! as RenderParagraph;
  // The children are the individual TextSpans which have GestureRecognizers
  paragraph.text.visitChildren((dynamic span) {
    if (span.text != text)
      return true; // continue iterating.

    (span.recognizer as TapGestureRecognizer).onTap!();
    return false; // stop iterating, we found the one.
  });
}
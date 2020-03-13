
import 'package:flutter/material.dart';
import 'package:flutter_deer/statistics/page/goods_statistics_page.dart';
import 'package:flutter_deer/statistics/page/order_statistics_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  var map = Map<String, Widget>();
  map['statistics_page'] = StatisticsPage();
  map['order_statistics_page'] = OrderStatisticsPage(1);
  map['goods_statistics_page'] = GoodsStatisticsPage();
  
  group('statistics => 检测页面可点击目标大小是否大于44 * 44', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      }, skip: name == 'order_statistics_page');
    });
  });

  group('statistics => 检测页面可点击目标是否都有语义', () {
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

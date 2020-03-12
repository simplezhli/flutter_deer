
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/page/order_info_page.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/order/page/order_search_page.dart';
import 'package:flutter_deer/order/page/order_track_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  var map = Map<String, Widget>();
  map['order_page'] = OrderPage();
  map['order_info_page'] = OrderInfoPage();
  map['order_search_page'] = OrderSearchPage();
  map['order_track_page'] = OrderTrackPage();
  
  group('order => 检测页面可点击目标大小是否小于44 * 44', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
       
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      }, skip: (name == 'order_search_page' ||
          name == 'order_track_page' ||
          name == 'order_page'
        )
      ); // https://github.com/flutter/flutter/issues/42455
    });
  });

  group('order => 检测页面可点击目标是否都有语义', () {
    map.forEach((name, page) {
      testWidgets(name, (WidgetTester tester) async {
        
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(MaterialApp(home: page));
        if (name == 'order_page') {
          await tester.pumpAndSettle(const Duration(seconds: 2));
        }
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });

}

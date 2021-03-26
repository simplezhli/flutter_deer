import 'package:flutter/material.dart';
import 'package:flutter_deer/demo/focus/focus_demo_page.dart';
import 'package:flutter_deer/demo/navigator/books_main.dart';
import 'package:flutter_deer/demo/overlay/overlay_main.dart';
import 'package:flutter_deer/demo/ripple/home_page.dart';
import 'package:flutter_deer/demo/scratcher/scratch_card_demo_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';


class DemoPage extends StatefulWidget {

  const DemoPage({Key key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Demo',
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
            title: 'Overlay',
            onTap: () => AppNavigator.push(context, OverlayDemo()),
          ),
          ClickItem(
            title: 'Focus',
            onTap: () => AppNavigator.push(context, const FocusDemoPage(title: 'Focus Demo')),
          ),
          ClickItem(
            title: 'RipplesAnimation',
            onTap: () => AppNavigator.push(context, const RipplesAnimation()),
          ),
          ClickItem(
            title: 'Navigator 2.0',
            onTap: () => AppNavigator.push(context, const NestedRouterDemo()),
          ),
          ClickItem(
            title: 'ScratchCard',
            onTap: () => AppNavigator.push(context, const ScratchCardDemoPage()),
          ),
        ],
      ),
    );
  }
}

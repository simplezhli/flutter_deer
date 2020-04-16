import 'package:flutter/material.dart';
import 'package:flutter_deer/demo/overlay/page/home_page.dart';
import 'package:flutter_deer/demo/overlay/route/application.dart';
import 'package:flutter_deer/demo/overlay/route/my_navigator_observer.dart';

/// 需求说明： 底部固定悬浮BottomNavigationBar，点击切换时有移动动画。
/// 进入二级页面图标全灰，返回一级页面返回之前状态。
/// 二级页面内点击按钮，直接返回一级页面。
/// 
/// 本例包含自定义BottomNavigationBar，路由监听及Overlay悬浮用法。
class OverlayDemo extends StatelessWidget {

  OverlayDemo() {
    Application.navigatorObserver = MyNavigatorObserver();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
      navigatorObservers: [
        Application.navigatorObserver
      ],
    );
  }
}

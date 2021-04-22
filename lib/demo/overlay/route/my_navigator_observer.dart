
import 'package:flutter/material.dart';

/// 记录路由，便于清空路由栈
class MyNavigatorObserver extends NavigatorObserver {
  List<Route<dynamic>> list = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    /// 首页不添加
    if (route.settings.name != '/') {
      list.add(route);
      print(list.length);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    list.remove(route);
    print(list.length);
  }

}

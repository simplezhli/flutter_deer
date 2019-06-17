
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/routers/router_init.dart';
import 'package:flutter_deer/setting/setting_router.dart';

import 'package:flutter_deer/home/home_page.dart';
import 'package:flutter_deer/home/webview_page.dart';

class Routes {

  static String home = "/home";
  static String webViewPage = "/webview";

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("未找到目标页");
      });

    router.define(home, handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => Home()));
    
    router.define(webViewPage, handler: Handler(handlerFunc: (_, params){
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));
    
    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(SettingRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });
  }
}

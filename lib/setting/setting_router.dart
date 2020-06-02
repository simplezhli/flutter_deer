
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';
import 'package:flutter_deer/setting/page/theme_page.dart';

import 'page/about_page.dart';
import 'page/account_manager_page.dart';
import 'page/setting_page.dart';

class SettingRouter implements IRouterProvider{

  static String settingPage = '/setting';
  static String aboutPage = '/setting/about';
  static String themePage = '/setting/theme';
  static String accountManagerPage = '/setting/accountManager';
  
  @override
  void initRouter(Router router) {
    router.define(settingPage, handler: Handler(handlerFunc: (_, __) => SettingPage()));
    router.define(aboutPage, handler: Handler(handlerFunc: (_, __) => AboutPage()));
    router.define(themePage, handler: Handler(handlerFunc: (_, __) => ThemePage()));
    router.define(accountManagerPage, handler: Handler(handlerFunc: (_, __) => AccountManagerPage()));
  }
  
}
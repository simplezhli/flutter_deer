
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';

import 'page/about_page.dart';
import 'page/account_manager_page.dart';
import 'page/setting_page.dart';

class SettingRouter implements IRouterProvider{

  static String settingPage = "/setting";
  static String aboutPage = "/setting/about";
  static String accountManagerPage = "/setting/accountManager";
  
  @override
  void initRouter(Router router) {
    router.define(settingPage, handler: Handler(handlerFunc: (_, params) => SettingPage()));
    router.define(aboutPage, handler: Handler(handlerFunc: (_, params) => AboutPage()));
    router.define(accountManagerPage, handler: Handler(handlerFunc: (_, params) => AccountManagerPage()));
  }
  
}
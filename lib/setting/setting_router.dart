
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';

import 'about_page.dart';
import 'account_manager_page.dart';
import 'setting_page.dart';

class SettingRouter implements IRouterProvider{

  static String settingPage = "/setting";
  static String aboutPage = "/setting/about";
  static String accountManagerPage = "/setting/accountManager";
  
  @override
  void initRouter(Router router) {
    router.define(settingPage, handler: Handler(handlerFunc: (_, params) => SettingPage()));
    router.define(aboutPage, handler: Handler(handlerFunc: (_, params) => About()));
    router.define(accountManagerPage, handler: Handler(handlerFunc: (_, params) => AccountManagerPage()));
  }
  
}
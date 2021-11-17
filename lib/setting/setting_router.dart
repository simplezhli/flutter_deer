import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/i_router.dart';
import 'package:flutter_deer/setting/page/locale_page.dart';
import 'package:flutter_deer/setting/page/theme_page.dart';

import 'page/about_page.dart';
import 'page/account_manager_page.dart';
import 'page/setting_page.dart';

class SettingRouter implements IRouterProvider{

  static String settingPage = '/setting';
  static String aboutPage = '/setting/about';
  static String themePage = '/setting/theme';
  static String localePage = '/setting/locale';
  static String accountManagerPage = '/setting/accountManager';
  
  @override
  void initRouter(FluroRouter router) {
    router.define(settingPage, handler: Handler(handlerFunc: (_, __) => const SettingPage()));
    router.define(aboutPage, handler: Handler(handlerFunc: (_, __) => const AboutPage()));
    router.define(themePage, handler: Handler(handlerFunc: (_, __) => const ThemePage()));
    router.define(localePage, handler: Handler(handlerFunc: (_, __) => const LocalePage()));
    router.define(accountManagerPage, handler: Handler(handlerFunc: (_, __) => const AccountManagerPage()));
  }
  
}
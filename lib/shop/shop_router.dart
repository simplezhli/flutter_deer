
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';

import 'freight_config_page.dart';
import 'message_page.dart';
import 'shop_page.dart';
import 'shop_setting_page.dart';

class ShopRouter implements IRouterProvider{

  static String shopPage = "/shop";
  static String shopSettingPage = "/shop/shopSetting";
  static String messagePage = "/shop/message";
  static String freightConfigPage = "/shop/freightConfig";
  
  @override
  void initRouter(Router router) {
    router.define(shopPage, handler: Handler(handlerFunc: (_, params) => Shop()));
    router.define(shopSettingPage, handler: Handler(handlerFunc: (_, params) => ShopSettingPage()));
    router.define(messagePage, handler: Handler(handlerFunc: (_, params) => MessagePage()));
    router.define(freightConfigPage, handler: Handler(handlerFunc: (_, params) => FreightConfigPage()));
  }
  
}
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/i_router.dart';

import 'page/freight_config_page.dart';
import 'page/input_text_page.dart';
import 'page/message_page.dart';
import 'page/select_address_page.dart';
import 'page/shop_page.dart';
import 'page/shop_setting_page.dart';

class ShopRouter implements IRouterProvider{

  static String shopPage = '/shop';
  static String shopSettingPage = '/shop/shopSetting';
  static String messagePage = '/shop/message';
  static String freightConfigPage = '/shop/freightConfig';
  static String addressSelectPage = '/shop/addressSelect';
  static String inputTextPage = '/shop/inputText';
  
  @override
  void initRouter(FluroRouter router) {
    router.define(shopPage, handler: Handler(handlerFunc: (_, __) => const ShopPage()));
    router.define(shopSettingPage, handler: Handler(handlerFunc: (_, __) => const ShopSettingPage()));
    router.define(messagePage, handler: Handler(handlerFunc: (_, __) => const MessagePage()));
    router.define(freightConfigPage, handler: Handler(handlerFunc: (_, __) => const FreightConfigPage()));
    router.define(addressSelectPage, handler: Handler(handlerFunc: (_, __) => const AddressSelectPage()));
    router.define(inputTextPage, handler: Handler(handlerFunc: (context, params) {
      /// 类参数
      final args = context!.settings!.arguments! as InputTextPageArgumentsData;
      return InputTextPage(
        title: args.title,
        hintText: args.hintText,
        content: args.content,
        keyboardType: args.keyboardType,
      );
    }));
  }
}
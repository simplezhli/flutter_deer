import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/i_router.dart';

import 'page/order_info_page.dart';
import 'page/order_page.dart';
import 'page/order_search_page.dart';
import 'page/order_track_page.dart';

class OrderRouter implements IRouterProvider{

  static String orderPage = '/order';
  static String orderInfoPage = '/order/info';
  static String orderSearchPage = '/order/search';
  static String orderTrackPage = '/order/track';
  
  @override
  void initRouter(FluroRouter router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, __) => const OrderPage()));
    router.define(orderInfoPage, handler: Handler(handlerFunc: (_, __) => const OrderInfoPage()));
    router.define(orderSearchPage, handler: Handler(handlerFunc: (_, __) => const OrderSearchPage()));
    router.define(orderTrackPage, handler: Handler(handlerFunc: (_, __) => const OrderTrackPage()));
  }
  
}
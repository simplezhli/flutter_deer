
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/i_router.dart';

import 'page/goods_edit_page.dart';
import 'page/goods_page.dart';
import 'page/goods_search_page.dart';
import 'page/goods_size_edit_page.dart';
import 'page/goods_size_page.dart';


class GoodsRouter implements IRouterProvider{

  static String goodsPage = '/goods';
  static String goodsEditPage = '/goods/edit';
  static String goodsSearchPage = '/goods/search';
  static String goodsSizePage = '/goods/size';
  static String goodsSizeEditPage = '/goods/sizeEdit';
  
  @override
  void initRouter(FluroRouter router) {
    router.define(goodsPage, handler: Handler(handlerFunc: (_, __) => GoodsPage()));
    router.define(goodsEditPage, handler: Handler(handlerFunc: (_, Map<String, List<String>> params) {
      final bool isAdd = params['isAdd']?.first == 'true';
      final bool isScan = params['isScan']?.first == 'true';
      return GoodsEditPage(isAdd: isAdd, isScan: isScan,);
    }));
    router.define(goodsSearchPage, handler: Handler(handlerFunc: (_, __) => GoodsSearchPage()));
    router.define(goodsSizePage, handler: Handler(handlerFunc: (_, __) => GoodsSizePage()));
    router.define(goodsSizeEditPage, handler: Handler(handlerFunc: (_, __) => GoodsSizeEditPage()));
  }
  
}
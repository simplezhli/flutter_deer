
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';

import 'goods_edit_page.dart';
import 'goods_page.dart';
import 'goods_search_page.dart';
import 'goods_size_edit_page.dart';
import 'goods_size_page.dart';


class GoodsRouter implements IRouterProvider{

  static String goodsPage = "/goods";
  static String goodsEditPage = "/goods/edit";
  static String goodsSearchPage = "/goods/search";
  static String goodsSizePage = "/goods/size";
  static String goodsSizeEditPage = "/goods/sizeEdit";
  
  @override
  void initRouter(Router router) {
    router.define(goodsPage, handler: Handler(handlerFunc: (_, params) => Goods()));
    router.define(goodsEditPage, handler: Handler(handlerFunc: (_, params){
      bool isAdd = params['isAdd']?.first == "true";
      return GoodsEdit(isAdd: isAdd);
    }));
    router.define(goodsSearchPage, handler: Handler(handlerFunc: (_, params) => GoodsSearch()));
    router.define(goodsSizePage, handler: Handler(handlerFunc: (_, params) => GoodsSize()));
    router.define(goodsSizeEditPage, handler: Handler(handlerFunc: (_, params) => GoodsSizeEdit()));
  }
  
}
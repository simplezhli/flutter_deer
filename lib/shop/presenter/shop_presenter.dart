
import 'package:flutter/material.dart';
import 'package:flutter_deer/mvp/base_page_presenter.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';

import '../shop_page.dart';

class ShopPagePresenter extends BasePagePresenter<ShopState> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      /// 接口请求例子
      /// get请求参数queryParameters  post请求参数params
      requestNetwork<UserEntity>(Method.get,
        url: "users/simplezhli",
        onSuccess: (data){
          view.setImg(data.avatarUrl);
        },
      );
    });
  }
 
}
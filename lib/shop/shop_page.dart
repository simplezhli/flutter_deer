
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/account_router.dart';
import 'package:flutter_deer/mvp/base_page_state.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/setting/setting_router.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/utils.dart';

import 'presenter/shop_presenter.dart';

class Shop extends StatefulWidget {
  @override
  ShopState createState() => ShopState();
}

class ShopState extends BasePageState<Shop, ShopPagePresenter> with AutomaticKeepAliveClientMixin<Shop>{
  
  var menuTitle = ["账户流水", "资金管理", "提现账号"];
  var menuImage = ["zhls", "zjgl", "txzh"];
  /// 头像
  String _img;
  
  void setImg(String img){
    setState(() {
      _img = img;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              onPressed: (){
                NavigatorUtils.push(context, ShopRouter.messagePage);
              },
              icon: loadAssetImage(
                "shop/message",
                width: 24.0,
                height: 24.0,
              ),
            ),
            IconButton(
              onPressed: (){
                NavigatorUtils.push(context, SettingRouter.settingPage);
              },
              icon: loadAssetImage(
                "shop/setting",
                width: 24.0,
                height: 24.0,
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gaps.vGap12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: <Widget>[
                  SizedBox(width: double.infinity, height: 56.0),
                  Text(
                    "官方直营店",
                    style: TextStyles.textBoldDark24,
                  ),
                  Positioned(
                    right: 0.0,
                    child: CircleAvatar(
                      radius: 28.0,
                      backgroundImage: _img == null ? AssetImage(
                        Utils.getImgPath('shop/tx'),
                      ) : CachedNetworkImageProvider(_img),
                    )
                  ),
                  Positioned(
                    top: 38.0,
                    left: 0.0,
                    child: Row(
                      children: <Widget>[
                        loadAssetImage("shop/zybq", width: 40.0, height: 16.0,),
                        Gaps.hGap8,
                        Text("店铺账号:15000000000", style: TextStyles.textDark12)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gaps.vGap12,
            Gaps.vGap12,
            Container(height: 0.6, width: double.infinity, color: Colours.line, margin: const EdgeInsets.only(left: 16.0)),
            Gaps.vGap12,
            Gaps.vGap12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "账户",
                style: TextStyles.textBoldDark18,
              ),
            ),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.18
                ),
                itemCount: menuTitle.length,
                itemBuilder: (_, index){
                  return InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        loadAssetImage("shop/${menuImage[index]}", width: 32.0),
                        Gaps.vGap4,
                        Text(
                          menuTitle[index],
                          style: TextStyles.textDark12,
                        )
                      ],
                    ),
                    onTap: (){
                      if (index == 0){
                        NavigatorUtils.push(context, AccountRouter.accountRecordListPage);
                      }else if (index == 1){
                        NavigatorUtils.push(context, AccountRouter.accountPage);
                      }else if (index == 2){
                        NavigatorUtils.push(context, AccountRouter.withdrawalAccountPage);
                      }
                    },
                  );
                },
              ),
            ),
            Container(height: 0.6, width: double.infinity, color: Colours.line, margin: const EdgeInsets.only(left: 16.0)),
            Gaps.vGap12,
            Gaps.vGap12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "店铺",
                style: TextStyles.textBoldDark18,
              ),
            ),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.18
                ),
                itemCount: 1,
                itemBuilder: (_, index){
                  return InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        loadAssetImage("shop/dpsz", width: 32.0),
                        Gaps.vGap4,
                        Text(
                          "店铺设置",
                          style: TextStyles.textDark12,
                        )
                      ],
                    ),
                    onTap: (){
                      NavigatorUtils.push(context, ShopRouter.shopSettingPage);
                    },
                  );
                },
              ),
            ),
          ],
        )
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  ShopPagePresenter createPresenter() {
    return ShopPagePresenter();
  }
}

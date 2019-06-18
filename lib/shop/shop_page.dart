
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/account_router.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/setting/setting_router.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/util/utils.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  
  var menuTitle = ["账户流水", "资金管理", "提现账号"];
  var menuImage = ["zhls", "zjgl", "txzh"];
  
  @override
  Widget build(BuildContext context) {
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
              icon: Image.asset(
                Utils.getImgPath("shop/message"),
                width: 24.0,
                height: 24.0,
              ),
            ),
            IconButton(
              onPressed: (){
                NavigatorUtils.push(context, SettingRouter.settingPage);
              },
              icon: Image.asset(
                Utils.getImgPath("shop/setting"),
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
                    child: Image.asset(Utils.getImgPath("shop/tx"), width: 56.0),
                  ),
                  Positioned(
                    top: 38.0,
                    left: 0.0,
                    child: Row(
                      children: <Widget>[
                        Image.asset(Utils.getImgPath("shop/zybq"), width: 40.0, height: 16.0,),
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
                        Image.asset(Utils.getImgPath("shop/${menuImage[index]}"), width: 32.0),
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
                        Image.asset(Utils.getImgPath("shop/dpsz"), width: 32.0),
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
}

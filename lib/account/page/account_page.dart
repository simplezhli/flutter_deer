
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';

import '../account_router.dart';

/// design/6店铺-账户/index.html#artboard2
class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: "资金管理",
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          AspectRatio(
            aspectRatio: 1.85,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ImageUtils.getAssetImage("account/bg"),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                Positioned.fill(
                  top: 37.0,
                  child: Column(
                    children: <Widget>[
                      const Text("当前余额(元)", style: TextStyle(color: Colours.login_text_disabled, fontSize: 12.0)),
                      Gaps.vGap8,
                      Text("30.12", style: TextStyle(color: Colors.white, fontSize: 32.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 37.0,
                  left: 70.0,
                  right: 70.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const Text("累计结算金额", style: TextStyle(color: Colours.login_text_disabled, fontSize: 12.0)),
                          Gaps.vGap8,
                          Text("20000.00", style: TextStyle(color: Colours.login_text_disabled, fontSize: 14.0)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Text("累计发放佣金", style: TextStyle(color: Colours.login_text_disabled, fontSize: 12.0)),
                          Gaps.vGap8,
                          Text("0.02", style: TextStyle(color: Colours.login_text_disabled, fontSize: 14.0)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Gaps.vGap5,
          ClickItem(
            title: "提现",
            onTap: (){
              NavigatorUtils.push(context, AccountRouter.withdrawalPage);
            },
          ),
          ClickItem(
            title: "提现记录",
            onTap: (){
              NavigatorUtils.push(context, AccountRouter.withdrawalRecordListPage);
            },
          ),
          ClickItem(
            title: "提现密码",
            onTap: (){
              NavigatorUtils.push(context, AccountRouter.withdrawalPasswordPage);
            },
          ),
        ],
      )
    );
  }
}

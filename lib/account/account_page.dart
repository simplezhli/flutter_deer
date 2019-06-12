
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/withdrawal_page.dart';
import 'package:flutter_deer/account/withdrawal_password_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';

import 'withdrawal_record_list_page.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
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
                      image: AssetImage(Utils.getImgPath("account/bg")),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                Positioned.fill(
                  top: 37.0,
                  child: Column(
                    children: <Widget>[
                      Text("当前余额(元)", style: TextStyle(color: Color(0xFFD4E2FA), fontSize: 12.0)),
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
                          Text("累计结算金额", style: TextStyle(color: Color(0xFFD4E2FA), fontSize: 12.0)),
                          Gaps.vGap8,
                          Text("20000.00", style: TextStyle(color: Color(0xFFD4E2FA), fontSize: 14.0)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("累计发放佣金", style: TextStyle(color: Color(0xFFD4E2FA), fontSize: 12.0)),
                          Gaps.vGap8,
                          Text("0.02", style: TextStyle(color: Color(0xFFD4E2FA), fontSize: 14.0)),
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
              AppNavigator.push(context, WithdrawalPage());
            },
          ),
          ClickItem(
            title: "提现记录",
            onTap: (){
              AppNavigator.push(context, WithdrawalRecordListPage());
            },
          ),
          ClickItem(
            title: "提现密码",
            onTap: (){
              AppNavigator.push(context, WithdrawalPasswordPage());
            },
          ),
        ],
      )
    );
  }
}

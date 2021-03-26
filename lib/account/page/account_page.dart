
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/widgets/rise_number_text.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';

import '../account_router.dart';

/// design/6店铺-账户/index.html#artboard2
class AccountPage extends StatefulWidget {

  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '资金管理',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gaps.vGap5,
            _buildCard(),
            Gaps.vGap5,
            ClickItem(
              title: '提现',
              onTap: () => NavigatorUtils.push(context, AccountRouter.withdrawalPage),
            ),
            ClickItem(
              title: '提现记录',
              onTap: () => NavigatorUtils.push(context, AccountRouter.withdrawalRecordListPage),
            ),
            ClickItem(
              title: '提现密码',
              onTap: () => NavigatorUtils.push(context, AccountRouter.withdrawalPasswordPage),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildCard() {
    return AspectRatio(
      aspectRatio: 1.85,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageUtils.getAssetImage('account/bg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            const _AccountMoney(
              title: '当前余额(元)',
              money: '30.12',
              alignment: MainAxisAlignment.end,
              moneyTextStyle: TextStyle(color: Colors.white, fontSize: 32.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoThin'),
            ),
            Expanded(
              child: Row(
                children: const <Widget>[
                  _AccountMoney(title: '累计结算金额', money: '20000'),
                  _AccountMoney(title: '累计发放佣金', money: '0.02'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountMoney extends StatelessWidget {
  
  const _AccountMoney({
    Key key,
    @required this.title,
    @required this.money,
    this.alignment,
    this.moneyTextStyle
  }): super(key: key);

  final String title;
  final String money;
  final MainAxisAlignment alignment;
  final TextStyle moneyTextStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MergeSemantics(
        child: Column(
          mainAxisAlignment: alignment ?? MainAxisAlignment.center,
          children: <Widget>[
            /// 横向撑开Column，扩大语义区域
            const SizedBox(width: double.infinity),
            Text(title, style: const TextStyle(color: Colours.text_disabled, fontSize: Dimens.font_sp12)),
            Gaps.vGap8,
            RiseNumberText(
              NumUtil.getDoubleByValueStr(money),
              style: moneyTextStyle ?? const TextStyle(
                color: Colours.text_disabled, 
                fontSize: Dimens.font_sp14,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoThin'
              )
            ),
          ],
        ),
      ),
    );
  }
}

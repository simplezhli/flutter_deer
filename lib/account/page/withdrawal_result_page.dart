
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';

/// design/6店铺-账户/index.html#artboard5
class WithdrawalResultPage extends StatefulWidget {

  const WithdrawalResultPage({Key key}) : super(key: key);

  @override
  _WithdrawalResultPageState createState() => _WithdrawalResultPageState();
}

class _WithdrawalResultPageState extends State<WithdrawalResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '提现结果',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap50,
            const LoadAssetImage('account/sqsb',
              width: 80.0,
              height: 80.0,
            ),
            Gaps.vGap12,
            const Text(
              '提现申请提交失败，请重新提交',
              style: TextStyles.textSize16,
            ),
            Gaps.vGap8,
            Text(
              '2021-02-21 15:20:10',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Gaps.vGap8,
            Text(
              '5秒后返回提现页面',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Gaps.vGap24,
            MyButton(
              onPressed: () => NavigatorUtils.goBack(context),
              text: '返回',
            )
          ],
        ),
      ),
    );
  }
}

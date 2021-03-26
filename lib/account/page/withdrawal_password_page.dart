
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/widgets/sms_verify_dialog.dart';
import 'package:flutter_deer/account/widgets/withdrawal_password_setting.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/other_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/base_dialog.dart';
import 'package:flutter_deer/widgets/click_item.dart';

/// design/6店铺-账户/index.html#artboard20
class WithdrawalPasswordPage extends StatefulWidget {

  const WithdrawalPasswordPage({Key key}) : super(key: key);

  @override
  _WithdrawalPasswordPageState createState() => _WithdrawalPasswordPageState();
}

class _WithdrawalPasswordPageState extends State<WithdrawalPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '提现密码',
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
            title: '修改密码',
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                /// 禁止拖动关闭
                enableDrag: false,
                /// 使用true则高度不受16分之9的最高限制
                isScrollControlled: true,
                builder: (_) => const WithdrawalPasswordSetting()
              );
            }
          ),
          ClickItem(
            title: '忘记密码',
            onTap: () => _showHintDialog()
          ),
        ],
      ),
    );
  }

  void _showHintDialog() {
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BaseDialog(
          hiddenTitle: true,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('为了您的账户安全需先进行短信验证并设置提现密码。', textAlign: TextAlign.center),
          ),
          onPressed: () {
            NavigatorUtils.goBack(context);
            _showVerifyDialog();
          },
        );
      },
    );
  }

  void _showVerifyDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SMSVerifyDialog()
    );
  }
}

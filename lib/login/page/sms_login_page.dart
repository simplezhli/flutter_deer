
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/deer_localizations.dart';
import 'package:flutter_deer/util/change_notifier_manage.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/util/other_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/login/widgets/my_text_field.dart';

import '../login_router.dart';

/// design/1注册登录/index.html#artboard4
class SMSLoginPage extends StatefulWidget {

  const SMSLoginPage({Key key}) : super(key: key);

  @override
  _SMSLoginPageState createState() => _SMSLoginPageState();
}

class _SMSLoginPageState extends State<SMSLoginPage> with ChangeNotifierMixin<SMSLoginPage> {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>>{
      _phoneController: callbacks,
      _vCodeController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }
 
  void _verify() {
    final String name = _phoneController.text;
    final String vCode = _vCodeController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _login() {
    Toast.show('去登录......');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2]),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Text(
        DeerLocalizations.of(context).verificationCodeLogin,
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        focusNode: _nodeText1,
        controller: _phoneController,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: DeerLocalizations.of(context).inputPhoneHint,
      ),
      Gaps.vGap8,
      MyTextField(
        focusNode: _nodeText2,
        controller: _vCodeController,
        maxLength: 6,
        keyboardType: TextInputType.number,
        hintText: DeerLocalizations.of(context).inputVerificationCodeHint,
        getVCode: () {
          Toast.show('获取验证码');
          return Future<bool>.value(true);
        },
      ),
      Gaps.vGap8,
      Container(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          child: RichText(
            text: TextSpan(
              text: DeerLocalizations.of(context).registeredTips,
              style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: Dimens.font_sp14),
              children: <TextSpan>[
                TextSpan(text: DeerLocalizations.of(context).register, style: TextStyle(color: Theme.of(context).errorColor)),
                TextSpan(text: Utils.getCurrLocale() == 'zh' ? '。' : '.'),
              ],
            ),
          ),
          onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
        )
      ),
      Gaps.vGap24,
      MyButton(
        onPressed: _clickable ? _login : null,
        text: DeerLocalizations.of(context).login,
      ),
      Container(
        height: 40.0,
        alignment: Alignment.centerRight,
        child: GestureDetector(
          child: Text(
            DeerLocalizations.of(context).forgotPasswordLink,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          onTap: () => NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
        ),
      )
    ];
  }
}

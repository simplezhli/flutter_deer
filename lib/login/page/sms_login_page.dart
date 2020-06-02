
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/widgets/text_field.dart';

import '../login_router.dart';

/// design/1注册登录/index.html#artboard4
class SMSLoginPage extends StatefulWidget {
  @override
  _SMSLoginPageState createState() => _SMSLoginPageState();
}

class _SMSLoginPageState extends State<SMSLoginPage> {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  
  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_verify);
    _vCodeController.addListener(_verify);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_verify);
    _vCodeController.removeListener(_verify);
    _phoneController.dispose();
    _vCodeController.dispose();
    _nodeText1.dispose();
    _nodeText2.dispose();
    super.dispose();
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
      const Text(
        '验证码登录',
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        focusNode: _nodeText1,
        controller: _phoneController,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: '请输入手机号',
      ),
      Gaps.vGap8,
      MyTextField(
        focusNode: _nodeText2,
        controller: _vCodeController,
        maxLength: 6,
        keyboardType: TextInputType.number,
        hintText: '请输入验证码',
        getVCode: () {
          Toast.show('获取验证码');
          return Future.value(true);
        },
      ),
      Gaps.vGap8,
      Container(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          child: RichText(
            text: TextSpan(
              text: '提示：未注册账号的手机号，请先',
              style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: Dimens.font_sp14),
              children: <TextSpan>[
                TextSpan(text: '注册', style: TextStyle(color: Theme.of(context).errorColor)),
                const TextSpan(text: '。'),
              ],
            ),
          ),
          onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
        )
      ),
      Gaps.vGap24,
      MyButton(
        onPressed: _clickable ? _login : null,
        text: '登录',
      ),
      Container(
        height: 40.0,
        alignment: Alignment.centerRight,
        child: GestureDetector(
          child: Text(
            '忘记密码',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          onTap: () => NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
        ),
      )
    ];
  }
}

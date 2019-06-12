
import 'package:flutter/material.dart';
import 'package:flutter_deer/login/register_page.dart';
import 'package:flutter_deer/login/reset_password_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/text_field.dart';

class SMSLogin extends StatefulWidget {
  @override
  _SMSLoginState createState() => _SMSLoginState();
}

class _SMSLoginState extends State<SMSLogin> {
  
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  bool _isClick = false;
  
  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_verify);
    _vCodeController.addListener(_verify);
  }

  void _verify(){
    String name = _phoneController.text;
    String vCode = _vCodeController.text;
    if (name.isEmpty || name.length < 11) {
      setState(() {
        _isClick = false;
      });
      return;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      setState(() {
        _isClick = false;
      });
      return;
    }

    setState(() {
      _isClick = true;
    });
  }

  void _login(){
    Toast.show("去登录......");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "验证码登录",
              style: TextStyles.textBoldDark26,
            ),
            Gaps.vGap16,
            MyTextField(
              controller: _phoneController,
              maxLength: 11,
              keyboardType: TextInputType.phone,
              hintText: "请输入账号",
            ),
            Gaps.vGap10,
            MyTextField(
              controller: _vCodeController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              hintText: "请输入验证码",
              getVCode: (){
                Toast.show('获取验证码');
              },
            ),
            Gaps.vGap10,
            Container(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: RichText(
                    text: TextSpan(
                      text: '提示：未注册账号的手机号，请先',
                      style: TextStyles.textGray14,
                      children: <TextSpan>[
                        TextSpan(text: '注册', style: TextStyle(color: Colours.text_red)),
                        TextSpan(text: '。'),
                      ],
                    ),
                  ),
                  onTap: (){
                    AppNavigator.push(context, Register());
                  },
                )
            ),
            Gaps.vGap15,
            Gaps.vGap10,
            MyButton(
              onPressed: _isClick ? _login : null,
              text: "登录",
            ),
            Container(
              height: 40.0,
              alignment: Alignment.centerRight,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Text(
                  '忘记密码',
                  style: TextStyles.textGray12,
                ),
                onTap: (){
                  AppNavigator.push(context, ResetPassword());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

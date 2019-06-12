
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/text_field.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isClick = false;
  
  @override
  void initState() {
    super.initState();
    //监听输入改变  
    _nameController.addListener(_verify);
    _vCodeController.addListener(_verify);
    _passwordController.addListener(_verify);
  }
  
  void _verify(){
    String name = _nameController.text;
    String vCode = _vCodeController.text;
    String password = _passwordController.text;
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
    if (password.isEmpty || password.length < 6) {
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
    Toast.show("确认......");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "注册",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "开启你的账号",
              style: TextStyles.textBoldDark26,
            ),
            Gaps.vGap16,
            MyTextField(
              controller: _nameController,
              maxLength: 11,
              keyboardType: TextInputType.phone,
              hintText: "请输入账号",
            ),
            Gaps.vGap10,
            MyTextField(
              controller: _vCodeController,
              keyboardType: TextInputType.number,
              getVCode: (){

              },
              maxLength: 6,
              hintText: "请输入验证码",
            ),
            Gaps.vGap10,
            MyTextField(
              isInputPwd: true,
              controller: _passwordController,
              maxLength: 16,
              hintText: "请输入密码",
            ),
            Gaps.vGap10,
            Gaps.vGap15,
            MyButton(
              onPressed: _isClick ? _login : null,
              text: "确认",
            )
          ],
        ),
      ),
    );
  }
}

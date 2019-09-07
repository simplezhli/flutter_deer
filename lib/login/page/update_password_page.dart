
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/text_field.dart';


/// design/1注册登录/index.html#artboard13
class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  //定义一个controller
  TextEditingController _oldPwdController = TextEditingController();
  TextEditingController _newPwdController = TextEditingController();
  bool _isClick = false;
  
  @override
  void initState() {
    super.initState();
    //监听输入改变  
    _oldPwdController.addListener(_verify);
    _newPwdController.addListener(_verify);
  }

  void _verify(){
    String oldPwd = _oldPwdController.text;
    String newPwd = _newPwdController.text;
    bool isClick = true;
    if (oldPwd.isEmpty || oldPwd.length < 6) {
      isClick = false;
    }
    if (newPwd.isEmpty || newPwd.length < 6) {
      isClick = false;
    }
    if (isClick != _isClick){
      setState(() {
        _isClick = isClick;
      });
    }
  }
  
  void _confirm(){
    Toast.show("修改成功！");
    NavigatorUtils.goBack(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "修改密码",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "重置登录密码",
              style: TextStyles.textBoldDark26,
            ),
            Gaps.vGap8,
            Text(
              "设置账号 15000000000",
              style: TextStyles.textGray14,
            ),
            Gaps.vGap16,
            Gaps.vGap16,
            MyTextField(
              isInputPwd: true,
              controller: _oldPwdController,
              maxLength: 16,
              hintText: "请确认旧密码",
            ),
            Gaps.vGap8,
            MyTextField(
              isInputPwd: true,
              controller: _newPwdController,
              maxLength: 16,
              hintText: "请输入新密码",
            ),
            Gaps.vGap10,
            Gaps.vGap15,
            MyButton(
              onPressed: _isClick ? _confirm : null,
              text: "确认",
            )
          ],
        ),
      ),
    );
  }
}

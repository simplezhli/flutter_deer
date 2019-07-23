
import 'package:flutter/material.dart';
import 'package:flutter_deer/login/login_router.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/base_dialog.dart';

class ExitDialog extends StatefulWidget{

  ExitDialog({
    Key key,
  }) : super(key : key);

  @override
  _ExitDialog createState() => _ExitDialog();
  
}

class _ExitDialog extends State<ExitDialog>{

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "提示",
      height: 160.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
        child: Text("您确定要退出登录吗？", style: TextStyles.textDark16),
      ),
      onPressed: (){
        NavigatorUtils.push(context, LoginRouter.loginPage, clearStack: true);
      },
    );
  }
}
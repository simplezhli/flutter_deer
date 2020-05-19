
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/widgets/text_field.dart';


/// design/1注册登录/index.html#artboard13
class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  //定义一个controller
  final TextEditingController _oldPwdController = TextEditingController();
  final TextEditingController _newPwdController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  
  @override
  void initState() {
    super.initState();
    //监听输入改变  
    _oldPwdController.addListener(_verify);
    _newPwdController.addListener(_verify);
  }

  @override
  void dispose() {
    _oldPwdController.removeListener(_verify);
    _newPwdController.removeListener(_verify);
    _oldPwdController.dispose();
    _newPwdController.dispose();
    _nodeText1.dispose();
    _nodeText2.dispose();
    super.dispose();
  }
  
  void _verify() {
    var oldPwd = _oldPwdController.text;
    var newPwd = _newPwdController.text;
    var clickable = true;
    if (oldPwd.isEmpty || oldPwd.length < 6) {
      clickable = false;
    }
    if (newPwd.isEmpty || newPwd.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }
  
  void _confirm() {
    Toast.show('修改成功！');
    NavigatorUtils.goBack(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '修改密码',
      ),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2]),
        crossAxisAlignment: CrossAxisAlignment.center,
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: <Widget>[
          const Text(
            '重置登录密码',
            style: TextStyles.textBold26,
          ),
          Gaps.vGap8,
          Text(
            '设置账号 15000000000',
            style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: Dimens.font_sp12),
          ),
          Gaps.vGap32,
          MyTextField(
            isInputPwd: true,
            focusNode: _nodeText1,
            controller: _oldPwdController,
            maxLength: 16,
            keyboardType: TextInputType.visiblePassword,
            hintText: '请确认旧密码',
          ),
          Gaps.vGap8,
          MyTextField(
            isInputPwd: true,
            focusNode: _nodeText2,
            controller: _newPwdController,
            maxLength: 16,
            keyboardType: TextInputType.visiblePassword,
            hintText: '请输入新密码',
          ),
          Gaps.vGap24,
          MyButton(
            onPressed: _clickable ? _confirm : null,
            text: '确认',
          )
        ],
      ),
    );
  }
}

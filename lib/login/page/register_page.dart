
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/widgets/text_field.dart';

/// design/1注册登录/index.html#artboard11
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _isClick = false;
  
  @override
  void initState() {
    super.initState();
    //监听输入改变  
    _nameController.addListener(_verify);
    _vCodeController.addListener(_verify);
    _passwordController.addListener(_verify);
  }

  void _verify() {
    String name = _nameController.text;
    String vCode = _vCodeController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }
  
  void _register() {
    Toast.show('点击注册');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: '注册',
        ),
        body: MyScrollView(
          keyboardConfig: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2, _nodeText3]),
          crossAxisAlignment: CrossAxisAlignment.center,
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
          children: _buildBody(),
        ),
    );
  }
  
  _buildBody() {
    return [
      const Text(
        '开启你的账号',
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        key: const Key('phone'),
        focusNode: _nodeText1,
        controller: _nameController,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: '请输入手机号',
      ),
      Gaps.vGap8,
      MyTextField(
        key: const Key('vcode'),
        focusNode: _nodeText2,
        controller: _vCodeController,
        keyboardType: TextInputType.number,
        getVCode: () async {
          if (_nameController.text.length == 11) {
            Toast.show('并没有真正发送哦，直接登录吧！');
            /// 一般可以在这里发送真正的请求，请求成功返回true
            return true;
          } else {
            Toast.show('请输入有效的手机号');
            return false;
          }
        },
        maxLength: 6,
        hintText: '请输入验证码',
      ),
      Gaps.vGap8,
      MyTextField(
        key: const Key('password'),
        keyName: 'password',
        focusNode: _nodeText3,
        isInputPwd: true,
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        maxLength: 16,
        hintText: '请输入密码',
      ),
      Gaps.vGap24,
      MyButton(
        key: const Key('register'),
        onPressed: _isClick ? _register : null,
        text: '注册',
      )
    ];
  }
}

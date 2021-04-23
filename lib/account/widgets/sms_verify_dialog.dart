import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/screen_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';

/// design/6店铺-账户/index.html#artboard23
/// 骚操作：借腹生子
class SMSVerifyDialog extends StatefulWidget {

  const SMSVerifyDialog({Key? key}) : super(key: key);

  @override
  _SMSVerifyDialogState createState() => _SMSVerifyDialogState();
}

class _SMSVerifyDialogState extends State<SMSVerifyDialog> {

  /// 倒计时秒数
  final int _second = 60;
  /// 当前秒数
  late int _currentSecond;
  StreamSubscription? _subscription;
  bool _clickable = true;

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final List<String> _codeList = ['', '', '', '', '', ''];
  
  @override
  void initState() {
    super.initState();
//    _controller.addListener(() {
//      if (_controller.text.isEmpty) {
//        return;
//      }
//      // 点击EditableText将光标放置在后端
//      _controller.value =  TextEditingValue(
//        text: _controller.text,
//        selection: TextSelection.collapsed(offset:  _controller.text.length),
//      );
//    });
  }
  
  @override
  void dispose() {
    _subscription?.cancel();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).primaryColor;
    
    final Widget child = Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 56.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 22.0),
              child: const Text(
                '短信验证',
                style: TextStyles.textBold18,
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Semantics(
                label: '关闭',
                child: GestureDetector(
                  onTap: () => NavigatorUtils.goBack(context),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0, right: 16.0),
                    child: LoadAssetImage('goods/icon_dialog_close', width: 16.0, key: Key('dialog_close'),),
                  ),
                ),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('本次操作需短信验证，验证码会发送至您的注册手机 15000000000', textAlign: TextAlign.center),
        ),
        Gaps.vGap16,
        Expanded(
          child: Stack(
            children: <Widget>[
              EditableText(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                /// 指定键盘外观，仅iOS有效
                keyboardAppearance: Brightness.dark,
                /// 只能为数字、6位
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                // 隐藏光标与字体颜色，达到隐藏输入框的目的
                cursorColor: Colors.transparent,
                cursorWidth: 0,
                textAlign: TextAlign.center,
                backgroundCursorColor: Colors.transparent,
                style: const TextStyle(color: Colors.transparent, fontSize: Dimens.font_sp18),
                onChanged: (v) {
                  for (var i = 0; i < _codeList.length; i ++) {
                    if (i < v.length) {
                      _codeList[i] = v.substring(i, i + 1);
                    } else {
                      _codeList[i] = '';
                    }
                  }
                  if (v.length == _codeList.length) {
                    Toast.show('验证码：${_controller.text}');
                    for (var i = 0; i < _codeList.length; i ++) {
                      _codeList[i] = '';
                    }
                    /// https://github.com/flutter/flutter/issues/47191
                    /// https://github.com/flutter/flutter/pull/57264 
                    /// 1.19.0已修复，小于此版本需添加addPostFrameCallback处理，否则会错误触发onChanged。
                    SchedulerBinding.instance!.addPostFrameCallback((_) {
                      _controller.clear();
                    });
                  }
                  setState(() {});
                },
              ),
              Semantics(
                label: '点击输入',
                child: GestureDetector(
                  onTap: () {
                    /// 一直怼，会有概率造成键盘抖动，加一个键盘时候弹出判断
                    if (MediaQuery.of(context).viewInsets.bottom < 10) {
                      final focusScope = FocusScope.of(context);
                      focusScope.unfocus();
                      Future.delayed(Duration.zero, () => focusScope.requestFocus(_focusNode));
                    }
                  },
                  child: Container(
                    key: const Key('vcode'),
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_codeList.length, (i) => _buildInputWidget(i, textColor)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gaps.vGap16,
        Gaps.line,
        MyButton(
          text: _clickable ? '获取验证码' : '已发送($_currentSecond s)',
          textColor: textColor,
          disabledTextColor: Colours.text_gray,
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          onPressed: _clickable ? () {
            setState(() {
              _currentSecond = _second;
              _clickable = false;
            });
            _subscription = Stream.periodic(const Duration(seconds: 1), (i) => i).take(_second).listen((i) {
              setState(() {
                _currentSecond = _second - i - 1;
                _clickable = _currentSecond < 1;
              });
            });
          }: null,
        ),
      ],
    );

    Widget body = Container(
      decoration: BoxDecoration(
        color: context.dialogBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 280.0,
      height: 210.0,
      child: child,
    );

    /// 判断原因见BaseDialog注释
    if (Device.getAndroidSdkInt() >= 30) {
      body = Container(
        alignment: Alignment.center,
        height: context.height - MediaQuery.of(context).viewInsets.bottom,
        child: body,
      );
    } else {
      body = AnimatedContainer(
        alignment: Alignment.center,
        height: context.height - MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: body,
      );
    }

    return Scaffold(//创建透明层
      backgroundColor: Colors.transparent,//透明类型
      body: body,
    );
  }

  Widget _buildInputWidget(int p, Color textColor) {
    return Container(
        height: 32.0,
        width: 32.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 0.6, color: _codeList[p].isNotEmpty ? textColor : Colours.text_gray_c),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(_codeList[p], style: const TextStyle(fontSize: Dimens.font_sp18),)
    );
  }
}

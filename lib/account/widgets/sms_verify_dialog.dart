
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/screen_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/load_image.dart';

/// design/6店铺-账户/index.html#artboard23
/// 骚操作：借腹生子
class SMSVerifyDialog extends StatefulWidget {
  @override
  _SMSVerifyDialogState createState() => _SMSVerifyDialogState();
}

class _SMSVerifyDialogState extends State<SMSVerifyDialog> {

  /// 倒计时秒数
  final int _second = 60;
  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;
  bool _isClick = true;

  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  List<String> _codeList = ['', '', '', '', '', ''];
  
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
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).primaryColor;
    return Scaffold(//创建透明层
      backgroundColor: Colors.transparent,//透明类型
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: Screen.height(context) - MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: Container(
            decoration: BoxDecoration(
              color: ThemeUtils.getDialogBackgroundColor(context),
              borderRadius: BorderRadius.circular((8.0)),
            ),
            width: 280.0,
            height: 210.0,
            child: Column(
              children: <Widget>[
                Container(
                  height: 56.0,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
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
                            child: Container(
                              padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                              child: const LoadAssetImage('goods/icon_dialog_close', width: 16.0, key: const Key('dialog_close'),),
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text('本次操作需短信验证，验证码会发送至您的注册手机 15000000000', textAlign: TextAlign.center),
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
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                        // 隐藏光标与字体颜色，达到隐藏输入框的目的
                        cursorColor: Colors.transparent,
                        cursorWidth: 0,
                        textAlign: TextAlign.center,
                        backgroundCursorColor: Colors.transparent,
                        style: TextStyle(color: Colors.transparent, fontSize: Dimens.font_sp18),
                        onChanged: (v) {
                          for (int i = 0; i < _codeList.length; i ++) {
                            if (i < v.length) {
                              _codeList[i] = v.substring(i, i + 1);
                            } else {
                              _codeList[i] = '';
                            }
                          }
                          if (v.length == _codeList.length) {
                            Toast.show('验证码：${_controller.text}');
                            for (int i = 0; i < _codeList.length; i ++) {
                              _codeList[i] = '';
                            }
                            _controller.text = '';
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
                              children: List.generate(_codeList.length, (i) => _buildInputWidget(i, textColor))
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap16,
                Gaps.line,
                Container(
                  width: double.infinity,
                  height: 48.0,
                  child: FlatButton(
                    child: Text(_isClick ? '获取验证码' : '已发送($_currentSecond s)', style: TextStyle(fontSize: Dimens.font_sp18)),
                    textColor: textColor,
                    disabledTextColor: Colours.text_gray,
                    onPressed: _isClick ? () {
                      setState(() {
                        _currentSecond = _second;
                        _isClick = false;
                      });
                      _subscription = Stream.periodic(Duration(seconds: 1), (i) => i).take(_second).listen((i) {
                        setState(() {
                          _currentSecond = _second - i - 1;
                          _isClick = _currentSecond < 1;
                        });
                      });
                    }: null,
                  ),
                )
              ],
            )
        ),
      ),
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
        child: Text(_codeList[p], style: TextStyle(fontSize: Dimens.font_sp18),)
    );
  }
}

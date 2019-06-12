
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:rxdart/rxdart.dart';

/// 骚操作：借腹生子
class SMSVerifyDialog extends StatefulWidget {
  @override
  _SMSVerifyDialogState createState() => _SMSVerifyDialogState();
}

class _SMSVerifyDialogState extends State<SMSVerifyDialog> {

  /// 倒计时秒数
  final int second = 60;
  /// 当前秒数
  int s;
  StreamSubscription _subscription;
  bool _isClick = true;

  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  List<Widget> _inputWidget = [];
  List<String> _codeList = ["", "", "", "", "", ""];
  
  @override
  void initState() {
    super.initState();
//    _controller.addListener((){
//      if (_controller.text.isEmpty){
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
    _inputWidget.clear();
    for (int i = 0; i < 6; i++){
      _inputWidget.add(_buildInputWidget(i));
    }
    return Scaffold(//创建透明层
      backgroundColor: Colors.transparent,//透明类型
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
                        child: Text(
                          "短信验证",
                          style: TextStyles.textBoldDark18,
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: InkWell(
                          onTap: (){Navigator.pop(context);},
                          child: Container(
                            padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                            child: Image.asset(Utils.getImgPath("goods/icon_dialog_close"), width: 16.0),
                          )
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text("本次操作需短信验证，验证码会发送至您的注册手机 15000000000", style: TextStyles.textDark14, textAlign: TextAlign.center),
                ),
                Gaps.vGap16,
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _inputWidget,
                        ),
                      ),
                      Positioned.fill(
                        child: EditableText(
                          controller: _controller,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                          // 隐藏光标与字体颜色，达到隐藏输入框的目的
                          cursorColor: Colors.transparent,
                          cursorWidth: 0.0,
                          textAlign: TextAlign.center,
                          backgroundCursorColor: Colors.transparent,
                          style: TextStyle(color: Colors.transparent, fontSize: Dimens.font_sp18),
                          onChanged: (v){
                            if (v.length > 6){
                              print(v);
                              _controller.value = TextEditingValue(
                                text: v.substring(0, 6),
                                selection: TextSelection.collapsed(offset: 6),
                              );
                              return;
                            }
                            for (int i = 0; i < 6; i ++){
                              if (i < v.length){
                                _codeList[i] = v.substring(i, i + 1);
                              }else{
                                _codeList[i] = "";
                              }
                            }
                            if (v.length == 6){
                              Toast.show("验证码：${_controller.text}");
                              _controller.text = "";
                              for (int i = 0; i < 6; i ++){
                                _codeList[i] = "";
                              }
                            }
                            setState(() {});
                          },
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
                    child: Text(_isClick ? "获取验证码" : "已发送($s s)", style: TextStyle(fontSize: Dimens.font_sp18)),
                    textColor: Colours.app_main,
                    disabledTextColor: Colours.text_gray,
                    onPressed: _isClick ? (){
                      setState(() {
                        s = second;
                        _isClick = false;
                      });
                      _subscription = Observable.periodic(Duration(seconds: 1), (i) => i).take(second).listen((i){
                        setState(() {
                          s = second - i - 1;
                          _isClick = s < 1;
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

  Widget _buildInputWidget(int p){
    return Container(
        height: 32.0,
        width: 32.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 0.6, color: _codeList[p].isNotEmpty ? Colours.app_main : Colours.text_gray_c),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(_codeList[p], style: TextStyle(fontSize: Dimens.font_sp18, color: Colours.text_dark),)
    );
  }
}

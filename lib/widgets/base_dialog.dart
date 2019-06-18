

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';

class BaseDialog extends StatelessWidget{

  BaseDialog({
    Key key,
    this.title,
    this.onPressed,
    this.height,
    this.hiddenTitle : false,
    @required this.child
  }) : super(key : key);

  final String title;
  final Function onPressed;
  final Widget child;
  final double height;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(//创建透明层
      backgroundColor: Colors.transparent,//透明类型
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 270.0,
            height: height,
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: <Widget>[
                Offstage(
                  offstage: hiddenTitle,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      hiddenTitle ? "" : title,
                      style: TextStyles.textBoldDark18,
                    ),
                  ),
                ),
                Expanded(child: child),
                Gaps.vGap8,
                Gaps.line,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            "取消",
                            style: TextStyle(
                                fontSize: Dimens.font_sp18
                            ),
                          ),
                          textColor: Colours.text_gray,
                          onPressed: (){
                            NavigatorUtils.goBack(context);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 48.0,
                      width: 0.6,
                      color: Colours.line,
                    ),
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            "确定",
                            style: TextStyle(
                                fontSize: Dimens.font_sp18
                            ),
                          ),
                          textColor: Colours.app_main,
                          onPressed: (){
                            onPressed();
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
  
}
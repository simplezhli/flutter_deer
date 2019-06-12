

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

class BaseDialog extends StatefulWidget{

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
  _BaseDialog createState() => _BaseDialog();
  
}

class _BaseDialog extends State<BaseDialog>{

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
            height: widget.height,
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: <Widget>[
                Offstage(
                  offstage: widget.hiddenTitle,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.hiddenTitle ? "" : widget.title,
                      style: TextStyles.textBoldDark18,
                    ),
                  ),
                ),
                Expanded(child: widget.child),
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
                            Navigator.of(context).pop();
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
                            widget.onPressed();
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
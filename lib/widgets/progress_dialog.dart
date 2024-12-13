import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

/// 加载中的弹框
class ProgressDialog extends Dialog {

  const ProgressDialog({
    super.key,
    this.hintText = '',
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    
    final Widget progress = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CupertinoActivityIndicator(radius: 14.0, color: Colors.grey,),
        Gaps.vGap8,
        Text(hintText, style: const TextStyle(color: Colors.white),)
      ],
    );
    
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 88.0,
          width: 120.0,
          decoration: const ShapeDecoration(
            color: Color(0xFF3A3A3A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          child: progress,
        ),
      ),
    );
  }
}

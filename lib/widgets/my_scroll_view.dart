

import 'package:flutter/material.dart';

/// 本项目通用的布局（SingleChildScrollView）
/// 1.底部存在按钮
/// 2.底部没有按钮
class MyScrollView extends StatelessWidget {

  const MyScrollView({
    Key key,
    this.padding,
    this.physics: const BouncingScrollPhysics(),
    this.crossAxisAlignment: CrossAxisAlignment.start,
    @required this.children,
    this.bottomButton
  }): super(key: key);

  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;
  final Widget bottomButton;

  @override
  Widget build(BuildContext context) {

    Widget body = SingleChildScrollView(
      padding: padding,
      physics: physics,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );

    if (bottomButton != null) {
      body = Column(
        children: <Widget>[
          Expanded(
            child: body
          ),
          bottomButton
        ],
      );
    }

    return SafeArea(
      child: body
    );
  }
}

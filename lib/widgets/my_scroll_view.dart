

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

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
    this.bottomButton,
    this.keyboardConfig,
    this.tapOutsideToDismiss: false
  }): super(key: key);

  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;
  final Widget bottomButton;
  final KeyboardActionsConfig keyboardConfig;
  /// 键盘外部按下将其关闭
  final bool tapOutsideToDismiss;

  @override
  Widget build(BuildContext context) {

    Widget contents;
    if (defaultTargetPlatform == TargetPlatform.iOS && keyboardConfig != null) {
      /// iOS 键盘处理
      contents = Column(
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );

      if (padding != null) {
        contents = Padding(
          padding: padding,
          child: contents
        );
      }

      contents = KeyboardActions(
        config: keyboardConfig,
        tapOutsideToDismiss: tapOutsideToDismiss,
        child: contents
      );

    } else {
      contents = SingleChildScrollView(
        padding: padding,
        physics: physics,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      );
    }

    if (bottomButton != null) {
      contents = Column(
        children: <Widget>[
          Expanded(
            child: contents
          ),
          bottomButton
        ],
      );
    }

    return SafeArea(
      child: contents
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

/// 默认字号18，白字蓝底，高度48
class MyButton extends StatelessWidget {

  const MyButton({
    Key key,
    this.text = '',
    this.fontSize = Dimens.font_sp18,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius = 2.0,
    this.side = BorderSide.none,
    @required this.onPressed,
  }): super(key: key);

  final String text;
  final double fontSize;
  final Color textColor;
  final Color disabledTextColor;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final double minHeight;
  final double minWidth;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final double radius;
  final BorderSide side;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return TextButton(
      child: Text(text, style: TextStyle(fontSize: fontSize),),
      onPressed: onPressed,
      style: ButtonStyle(
        // 文字颜色
        foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledTextColor ?? (isDark ? Colours.dark_text_disabled : Colours.text_disabled);
            }
            return textColor ?? (isDark ? Colours.dark_button_text : Colors.white);
          },
        ),
        // 背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return disabledBackgroundColor ?? (isDark ? Colours.dark_button_disabled : Colours.button_disabled);
          }
          return backgroundColor ?? (isDark ? Colours.dark_app_main : Colours.app_main);
        }),
        // 水波纹
        overlayColor: MaterialStateProperty.resolveWith((states) {
          return (textColor ?? (isDark ? Colours.dark_button_text : Colors.white)).withOpacity(0.12);
        }),
        // 按钮最小大小
        minimumSize: (minWidth == null || minHeight == null) ? null : MaterialStateProperty.all<Size>(Size(minWidth, minHeight)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(side),
      )
    );
  }
}

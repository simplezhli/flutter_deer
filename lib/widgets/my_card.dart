import 'package:flutter/material.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/util/theme_utils.dart';

class MyCard extends StatelessWidget {

  const MyCard({
    super.key,
    required this.child,
    this.color,
    this.shadowColor
  });
  
  final Widget child;
  final Color? color;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    final Color backgroundColor = color ?? (isDark ? Colours.dark_bg_gray_ : Colors.white);
    final Color sColor = isDark ? Colors.transparent : (shadowColor ?? const Color(0x80DCE7FA));

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(color: sColor, offset: const Offset(0.0, 2.0), blurRadius: 8.0),
        ],
      ),
      child: child,
    );
  }
}

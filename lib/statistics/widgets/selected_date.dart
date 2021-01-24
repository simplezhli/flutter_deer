
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

class SelectedDateButton extends StatelessWidget {

  const SelectedDateButton(this.text,{
    Key key,
    this.fontSize = 14.0,
    this.selected = false,
    @required this.unSelectedTextColor,
    this.enable = true,
    this.onTap,
    this.semanticsLabel
  }): assert(unSelectedTextColor != null, 'The [unSelectedTextColor] argument must not be null.'),
      super(key: key);

  final String text;
  final double fontSize;
  final bool selected;
  final Color unSelectedTextColor;
  final GestureTapCallback onTap;
  final bool enable;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    Widget child = _buildText();
    
    if (enable) {
      child = InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 32.0,
            maxHeight: 32.0,
            minHeight: 32.0,
          ),
          padding: EdgeInsets.symmetric(horizontal: fontSize > 14 ? 10.0 : 0.0),
          decoration: selected ? BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
//            shape: BoxShape.circle,
            boxShadow: context.isDark ? null : const [
              BoxShadow(color: Color(0x805793FA), offset: Offset(0.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF5758FA), Color(0xFF5793FA)],
            ),
          ) : null,
          child: Column(
            // 此处为了宽度适应，高度撑满。
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              child
            ],
          ),
        ),
      );
    }
    
    return child;
  }

  Widget _buildText() {
    if (text.endsWith('月') || text.endsWith('日')) {
      return RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: text.substring(0, text.length - 1), style: TextStyle(color: getTextColor(), fontSize: fontSize)),
            TextSpan(text: text.substring(text.length - 1), style: TextStyle(color: getTextColor(), fontSize: fontSize - 4.0)),
          ],
        ),
      );
    } else {
      return Text(text,
        semanticsLabel: semanticsLabel,
        style: TextStyle(color: getTextColor(), fontSize: fontSize),
      );
    }
  }

  Color getTextColor() {
    return enable ? (selected ? Colors.white : unSelectedTextColor) : Colours.text_gray_c;
  }
}


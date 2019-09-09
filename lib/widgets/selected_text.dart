
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

class SelectedText extends StatelessWidget {

  const SelectedText(this.text,{
    Key key,
    this.fontSize : 14.0,
    this.selected : false,
    this.unSelectedTextColor : Colours.text_dark,
    this.enable : true,
    this.onTap
  }): super(key: key);

  final String text;
  final double fontSize;
  final bool selected;
  final Color unSelectedTextColor;
  final GestureTapCallback onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: enable ? onTap : null,
      child: Container(
        constraints: BoxConstraints(
          minWidth: 32.0,
          maxHeight: 32.0,
          minHeight: 32.0,
        ),
        padding: EdgeInsets.symmetric(horizontal: fontSize > 14 ? 10.0 : 0.0),
        decoration: selected ? BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
//            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(color: Color(0x805793FA), offset: Offset(0.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
            ],
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [Color(0xFF5758FA), Color(0xFF5793FA)]
            )
        ) : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildText()
          ],
        ),
      ),
    );
  }

  _buildText(){
    if (text.endsWith("月") || text.endsWith("日")){
      return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: text.substring(0, text.length - 1), style: TextStyle(color: getTextColor(), fontSize: fontSize)),
              TextSpan(text: text.substring(text.length - 1), style: TextStyle(color: getTextColor(), fontSize: fontSize - 4.0)),
            ],
          )
      );
    }else{
      return Text(text, style: TextStyle(color: getTextColor(), fontSize: fontSize));
    }
  }

  getTextColor(){
    return enable ? (selected ? Colors.white : unSelectedTextColor) : Colours.text_gray_c;
  }
}


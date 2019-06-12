
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

class SelectedText extends StatefulWidget {

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
  _SelectedTextState createState() => _SelectedTextState();
}

class _SelectedTextState extends State<SelectedText> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: widget.enable ? widget.onTap : null,
      child: Container(
        constraints: BoxConstraints(
          minWidth: 32.0,
          maxHeight: 32.0,
          minHeight: 32.0,
        ),
        padding: EdgeInsets.symmetric(horizontal: widget.fontSize > 14 ? 10.0 : 0.0),
        decoration: widget.selected ? BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
//            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Color(0x805793FA), offset: Offset(0.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF5758FA), Color(0xFF5793FA)]
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
    if (widget.text.endsWith("月") || widget.text.endsWith("日")){
      return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: widget.text.substring(0, widget.text.length - 1), style: TextStyle(color: getTextColor(), fontSize: widget.fontSize)),
              TextSpan(text: widget.text.substring(widget.text.length - 1, widget.text.length), style: TextStyle(color: getTextColor(), fontSize: widget.fontSize - 4.0)),
            ],
          )
      );
    }else{
      return Text(widget.text, style: TextStyle(color: getTextColor(), fontSize: widget.fontSize));
    }
  }
  
  getTextColor(){
    return widget.enable ? (widget.selected ? Colors.white : widget.unSelectedTextColor) : Colours.text_gray_c;
  }
}

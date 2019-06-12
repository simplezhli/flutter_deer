
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

class MyButton extends StatefulWidget {

  const MyButton({
    Key key,
    this.text: "",
    @required this.onPressed,
  }): super(key: key);

  final String text;
  final VoidCallback onPressed;
  
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.onPressed,
      textColor: Colors.white,
      color: Colours.app_main,
      disabledTextColor: Colours.login_text_disabled,
      disabledColor: Colours.login_button_disabled,
      //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          Container(
            height: 48,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: Dimens.font_sp18
              ),
            ),
          ),
        ],
      ),
    );
  }
}

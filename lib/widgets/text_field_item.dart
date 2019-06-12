
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/number_text_input_formatter.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class TextFieldItem extends StatefulWidget {

  const TextFieldItem({
    Key key,
    this.controller,
    @required this.title,
    this.keyboardType: TextInputType.text,
    this.hintText: "",
    this.focusNode,
    this.config
  }): super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final KeyboardActionsConfig config;

  @override
  _TextFieldItemState createState() => _TextFieldItemState();
}

class _TextFieldItemState extends State<TextFieldItem> {

  @override
  void initState() {
    if (widget.config != null && defaultTargetPlatform == TargetPlatform.iOS){
      // 因Android平台输入法兼容问题，所以只配置IOS平台
      FormKeyboardActions.setKeyboardActions(context, widget.config);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin:  const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, color: Colours.line, width: 0.6),
          )
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              widget.title,
              style: TextStyles.textDark14,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType,
              inputFormatters: _getInputFormatters(),
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none, //去掉下划线
                hintStyle: TextStyles.textGrayC14
              )
            ),
          )
        ],
      ),
    );
  }

  _getInputFormatters(){
    if (widget.keyboardType == TextInputType.numberWithOptions(decimal: true)){
      return [UsNumberTextInputFormatter()];
    }
    if (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone){
      return [WhitelistingTextInputFormatter.digitsOnly];
    }
    return null;
  }
}

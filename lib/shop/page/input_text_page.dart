
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';


/// design/7店铺-店铺配置/index.html#artboard13
class InputTextPage extends StatefulWidget {

  const InputTextPage({
    Key key,
    @required this.title,
    this.content,
    this.hintText,
    this.keyboardType = TextInputType.text,
  }) : super(key : key);

  final String title;
  final String content;
  final String hintText;
  final TextInputType keyboardType;
  
  @override
  _InputTextPageState createState() => _InputTextPageState();
}

class _InputTextPageState extends State<InputTextPage> {

  final TextEditingController _controller = TextEditingController();
  List<TextInputFormatter> _inputFormatters;
  int _maxLength;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
    _maxLength = widget.keyboardType == TextInputType.phone ? 11 : 30;
    _inputFormatters = widget.keyboardType == TextInputType.phone ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : null;
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        actionName: '完成',
        onPressed: () {
          NavigatorUtils.goBackWithParams(context, _controller.text);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 21.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Semantics(
          multiline: true,
          maxValueLength: _maxLength,
          child: TextField(
            maxLength: _maxLength,
            maxLines: 5,
            autofocus: true,
            controller: _controller,
            keyboardType: widget.keyboardType,
            inputFormatters: _inputFormatters,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

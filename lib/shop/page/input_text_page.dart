
import 'package:flutter/material.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/app_bar.dart';


/// design/7店铺-店铺配置/index.html#artboard13
class InputTextPage extends StatefulWidget {

  const InputTextPage({
    Key key,
    @required this.title,
    this.content,
    this.hintText,
    this.keyboardType: TextInputType.text,
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
  
  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
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
          maxValueLength: 30,
          child: TextField(
            maxLength: 30,
            maxLines: 5,
            autofocus: true,
            controller: _controller,
            keyboardType: widget.keyboardType,
            //style: TextStyles.textDark14,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              //hintStyle: TextStyles.textGrayC14
            )
          ),
        ),
      ),
    );
  }
}

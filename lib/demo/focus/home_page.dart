import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final FocusNode _focusNode = FocusNode();
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.title} build');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(
            focusNode: _focusNode,
          ),
          FlatButton(
            child: Text('打印FocusTree'),
            onPressed: () {
              // 关闭软键盘四种方式
//              SystemChannels.textInput.invokeMethod('TextInput.hide');
//              FocusScope.of(context).requestFocus(FocusNode());
//              FocusScope.of(context).unfocus();
//              _focusNode.unfocus();
//              FocusManager.instance.primaryFocus.unfocus();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                debugDumpFocusTree();
              });
            },
          ),
          FlatButton(
            child: Text('Push TestPage'),
            onPressed: () {
              Navigator.push<MyHomePage>(
                context,
                MaterialPageRoute<MyHomePage>(
                  builder: (BuildContext context) => MyHomePage(title: 'Test Page'),
                ),
              );
            },
          ),
        ],
      ),
    );
  } 

}

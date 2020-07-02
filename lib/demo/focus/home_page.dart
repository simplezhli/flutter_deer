import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(),
          FlatButton(
            child: Text('打印FocusTree'),
            onPressed: () {
//              FocusManager.instance.primaryFocus.unfocus();
//              FocusScope.of(context).requestFocus(FocusNode());
//              FocusScope.of(context).unfocus();
              debugDumpFocusTree();
            },
          ),
        ],
      ),
    );
  } 

}

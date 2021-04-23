import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';


/// 博客：https://weilu.blog.csdn.net/article/details/107132031
class FocusDemoPage extends StatefulWidget {
  const FocusDemoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FocusDemoPageState createState() => _FocusDemoPageState();
}

class _FocusDemoPageState extends State<FocusDemoPage> {


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
        backgroundColor: context.isDark ? Colours.dark_bg_color : Colors.blue,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            focusNode: _focusNode,
          ),
          OutlinedButton(
            child: const Text('打印FocusTree'),
            onPressed: () {
              // 关闭软键盘四种方式
//              SystemChannels.textInput.invokeMethod('TextInput.hide');
//              FocusScope.of(context).requestFocus(FocusNode());
//              FocusScope.of(context).unfocus();
//              _focusNode.unfocus();
//              FocusManager.instance.primaryFocus.unfocus();
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                debugDumpFocusTree();
              });
            },
          ),
          ElevatedButton(
            child: const Text('Push TestPage'),
            onPressed: () {
              Navigator.push<FocusDemoPage>(
                context,
                MaterialPageRoute<FocusDemoPage>(
                  builder: (BuildContext context) => const FocusDemoPage(title: 'Test Page'),
                ),
              );
            },
          ),
        ],
      ),
    );
  } 

}

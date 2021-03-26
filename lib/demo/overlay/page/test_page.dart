
import 'package:flutter/material.dart';
import 'package:flutter_deer/demo/widgets/neumorphic.dart';

class TestPage extends StatefulWidget {

  const TestPage({Key key}) : super(key: key);
  
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      backgroundColor: Colors.blueGrey.shade200,
      body: Center(
        child: NeumorphicContainer(
          child: GestureDetector(
            child: const Text('点击跳转', style: TextStyle(fontSize: 18.0, color: Colors.white70),),
            onTap: () {
              Navigator.push<TestPage>(
                context,
                MaterialPageRoute<TestPage>(
                  builder: (BuildContext context) => const TestPage(),
                ),
              );
            },
          ),
        ),
      )
    );
  }
}

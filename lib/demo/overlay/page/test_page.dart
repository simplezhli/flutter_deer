
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  
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
      body: Container(
        color: Colors.tealAccent,
        child: Center(
          child: GestureDetector(
            child: const Text('Test Page', style: TextStyle(fontSize: 22.0),),
            onTap: () {
              Navigator.push<TestPage>(
                context,
                MaterialPageRoute<TestPage>(
                  builder: (BuildContext context) => TestPage(),
                ),
              );
            },
          )
        ),
      )
    );
  }
}

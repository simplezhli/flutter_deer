
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
        title: Text('Test Page'),
      ),
      body: Container(
        color: Colors.tealAccent,
        child: Center(
          child: GestureDetector(
            child: Text('Test Page', style: const TextStyle(fontSize: 22.0),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
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

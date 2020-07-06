import 'package:flutter/material.dart';
import 'package:flutter_deer/demo/focus/home_page.dart';

/// 博客：https://weilu.blog.csdn.net/article/details/107132031
class FocusDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

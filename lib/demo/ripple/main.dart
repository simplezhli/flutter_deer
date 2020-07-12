import 'package:flutter/material.dart';
import 'package:flutter_deer/demo/ripple/home_page.dart';

/// https://medium.com/flutterdevs/ripple-animation-in-flutter-3421cbd66a18
class RippleAnimationDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RipplesAnimation(),
    );
  }
}

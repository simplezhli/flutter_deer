import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_deer/res/resources.dart';
import 'splash_page.dart';

void main(){
  runApp(MyApp());
  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Deer',
        //debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colours.app_main,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashPage(),
      ),
    );
  }
}

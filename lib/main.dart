import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/application.dart';
import 'package:flutter_deer/routers/routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_deer/home/splash_page.dart';

void main(){
//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
  
  runApp(MyApp());
  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  
  final Widget home;
  
  MyApp({this.home}) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Deer',
//        showPerformanceOverlay: true, //显示性能标签
        //debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colours.app_main,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            // TextField输入文字颜色
            subhead: TextStyles.textDark14,
            body1: TextStyles.textDark14,
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyles.textGray14
          )
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colours.app_main,
          textTheme: TextTheme(
            subhead: TextStyles.textGray14,
            body1: TextStyles.textGray14,
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyles.textGray14
          )
          //scaffoldBackgroundColor: Colors.black87,
        ),
        home: home ?? SplashPage(),
        onGenerateRoute: Application.router.generator,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('zh', 'CH'),
          Locale('en', 'US')
        ]
      ),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom
    );
  }
}

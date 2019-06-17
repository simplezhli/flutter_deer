
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class Routes {

  static String home = "/home";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("未找到目标页");
      });

    router.define(home, handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => Home()));
  }
}

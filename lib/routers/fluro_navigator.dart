import 'package:flutter/material.dart';

import 'application.dart';

class NavigatorUtils {
  
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack);
  }

  static pushResult(context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack).then((result){
      // 页面返回result为null
      if (result == null){
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }
}

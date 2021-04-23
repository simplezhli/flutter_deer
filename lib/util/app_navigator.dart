import 'package:flutter/material.dart';

/// Navigator工具类 
/// 更推荐使用'routers/fluro_navigator.dart'
class AppNavigator {
  static void push(BuildContext context, Widget scene) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  /// 替换页面 当新的页面进入后，之前的页面将执行dispose方法
  static void pushReplacement(BuildContext context, Widget scene) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  /// 指定页面加入到路由中，然后将其他所有的页面全部pop
  static void pushAndRemoveUntil(BuildContext context, Widget scene) {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ), (route) => route == null
    );
  }

  static void pushResult(BuildContext context, Widget scene, Function(Object?) function) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    ).then((dynamic result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      print('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, dynamic result) {
    Navigator.pop<dynamic>(context, result);
  }
}

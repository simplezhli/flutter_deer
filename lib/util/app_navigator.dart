import 'package:flutter/material.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  static pushAndRemoveUntil(BuildContext context, Widget scene) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ), (route) => route == null
    );
  }

  static pushResult(BuildContext context, Widget scene, Function(Object) function) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    ).then((result){
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

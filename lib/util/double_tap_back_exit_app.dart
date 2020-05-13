
import 'package:flutter/material.dart';
import 'package:flutter_deer/util/toast.dart';

class DoubleTapBackExitApp extends StatefulWidget {

  const DoubleTapBackExitApp({
    Key key,
    @required this.child,
    this.duration = const Duration(milliseconds: 2500),
  }): super(key: key);

  final Widget child;
  /// 两次点击返回按钮的时间间隔
  final Duration duration;

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();
}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {

  DateTime  _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() {
    if (_lastTime == null || DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();
      Toast.show('再次点击退出应用');
      return Future.value(false);
    }
    Toast.cancelToast();
    return Future.value(true);
  }
}


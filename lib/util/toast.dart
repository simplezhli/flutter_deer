
import 'package:oktoast/oktoast.dart';

/// Toast工具类
class Toast {
  static show(String msg, {duration = 2000}) {
    if (msg == null) {
      return;
    }
    showToast(
      msg,
      duration: Duration(milliseconds: duration),
      dismissOtherToast: true
    );
  }

  static cancelToast() {
    dismissAllToast();
  }
}

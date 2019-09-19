
import 'package:oktoast/oktoast.dart';

/// Toast工具类
class Toast {
  static show(String msg, {duration = 2000}) {
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

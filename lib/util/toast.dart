
import 'package:flutter_deer/widgets/progress_dialog.dart';
import 'package:flutter_deer/widgets/toast/oktoast.dart';
import 'package:flutter_deer/widgets/toast/toast_manager.dart';

class Toast {
  static show(String msg, {duration = 2000}) {
    showToast(
        msg,
        duration: Duration(milliseconds: duration)
    );
  }

  static cancelToast(){
    dismissAllToast();
  }

  static ToastFuture _future;

  static bool isShowProgress(){
    if (_future == null){
      return false;
    }
    return ToastManager().isShowToast(_future);
  }

  static showProgress(){
    _future = showToastWidget(
        ProgressDialog(hintText: "正在加载...",),
        duration: Duration(minutes: 1),
        position: ToastPosition.center
    );
  }
}


import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

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
}

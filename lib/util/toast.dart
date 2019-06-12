
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Toast {
  static show(String msg) {
    showToast(
      msg,
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
      dismissOtherToast: true
    );
  }
}

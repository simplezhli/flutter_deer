
import 'package:flutter/material.dart';

import 'i_lifecycle.dart';

abstract class IMvpView {

  BuildContext getContext();
  /// 显示Progress
  void showProgress();

  /// 关闭Progress
  void closeProgress();

  /// 展示Toast
  void showToast(String string);
}

abstract class IPresenter extends ILifecycle {}

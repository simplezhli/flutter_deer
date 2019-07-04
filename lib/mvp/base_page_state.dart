
import 'package:flutter/material.dart';
import 'package:flutter_deer/util/toast.dart';

import 'base_page_presenter.dart';
import 'mvps.dart';

abstract class BasePageState<T extends StatefulWidget, V extends BasePagePresenter> extends State<T> implements IMvpView {

  V presenter;
  
  BasePageState() {
    presenter = createPresenter();
    presenter.view = this;
  }
  
  V createPresenter();

  @override
  void closeProgress() {
    Toast.cancelToast();
  }

  @override
  void showProgress() {
    if (!Toast.isShowProgress()){
      try{
        Toast.showProgress();
      }catch(e){
        print(e);
      }
    }
  }

  @override
  void showToast(String string) {
    Toast.show(string);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    presenter.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    presenter.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    presenter.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    presenter.initState();
  }

  void didUpdateWidgets<W>(W oldWidget) {
    presenter.didUpdateWidgets<W>(oldWidget);
  }
}
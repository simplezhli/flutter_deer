
import 'package:flutter_deer/mvp/base_page.dart';
import 'package:flutter_deer/mvp/base_page_presenter.dart';
import 'package:flutter_deer/mvp/base_presenter.dart';

/// 管理多个Presenter，实现复用。
class PowerPresenter<IMvpView> extends BasePresenter {

  BasePageMixin _state;
  List<BasePagePresenter> _presenters = [];
  
  PowerPresenter(BasePageMixin state) {
    this._state = state;
  }

  void requestPresenter(List<BasePagePresenter> presenters) {
    this._presenters = presenters;
    _presenters.forEach((presenter) => presenter.view = _state);
  }
  
  @override
  void deactivate() {
    _presenters.forEach((presenter) => presenter.deactivate());
  }

  @override
  void didChangeDependencies() {
    _presenters.forEach((presenter) => presenter.didChangeDependencies());
  }

  @override
  void didUpdateWidgets<W>(W oldWidget) {
    _presenters.forEach((presenter) => presenter.didUpdateWidgets<W>(oldWidget));
  }

  @override
  void dispose() {
    _presenters.forEach((presenter) => presenter.dispose());
  }

  @override
  void initState() {
    _presenters.forEach((presenter) => presenter.initState());
  }
  
}
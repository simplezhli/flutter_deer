
import 'package:dio/dio.dart';
import 'package:flutter_deer/net/dio_utils.dart';

import 'mvps.dart';

class BasePagePresenter<V extends IMvpView> extends IPresenter {

  V view;

  CancelToken _cancelToken;

  BasePagePresenter(){
    _cancelToken = CancelToken();
  }
  
  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidgets<W>(W oldWidget) {}

  @override
  void dispose() {
    if (!_cancelToken.isCancelled){
      _cancelToken.cancel();
    }
  }

  @override
  void initState() {}

  void requestNetwork<T>(Method method, String url, {Function(T t) onSuccess, Function(List<T> list) onSuccessList, Function(int code, String mag) onError,
    Map<String, dynamic> params, Map<String, dynamic> queryParameters, 
    CancelToken cancelToken, Options options, bool isList : false}){
    view.showProgress();
    DioUtils.instance.requestNetwork(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
        isList: isList,
        onSuccess: (data){
          view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onSuccessList: (data){
          view.closeProgress();
          if (onSuccessList != null) {
            onSuccessList(data);
          }
        },
        onError: (code, msg){
          view.closeProgress();
          if (msg.isNotEmpty){
            view.showToast(msg);
          }
          if (onError != null) {
            onError(code, msg);
          }
        }
    );
  }
}

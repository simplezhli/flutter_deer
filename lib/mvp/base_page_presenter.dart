
import 'package:dio/dio.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:meta/meta.dart';

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
    /// 销毁时，将请求取消
    if (!_cancelToken.isCancelled){
      _cancelToken.cancel();
    }
  }

  @override
  void initState() {}

  /// 返回Future 适用于刷新，加载更多
  Future request<T>(Method method, {@required String url, bool isShow : true, bool isClose: true, Function(T t) onSuccess, Function(int code, String mag) onError, Map<String, dynamic> params, Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options}) async {
    if (isShow) view.showProgress();
    await DioUtils.instance.request<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken?? _cancelToken,
        onSuccess: (data){
          if (isClose) view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onError: (code, msg){
          _onError(code, msg, onError);
        }
    );
  }

  /// 返回Future 适用于刷新，加载更多
  Future requestList<T>(Method method, {@required String url, bool isShow : true, bool isClose: true, Function(List<T> t) onSuccess, Function(int code, String mag) onError, Map<String, dynamic> params, Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options}) async {
    if (isShow) view.showProgress();
    await DioUtils.instance.requestList<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken?? _cancelToken,
        onSuccess: (data){
          if (isClose) view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onError: (code, msg){
          _onError(code, msg, onError);
        }
    );
  }

  void requestNetwork<T>(Method method, {@required String url, bool isShow : true, bool isClose: true, Function(T t) onSuccess, Function(List<T> list) onSuccessList, Function(int code, String mag) onError,
    Map<String, dynamic> params, Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList : false}){
    if (isShow) view.showProgress();
    DioUtils.instance.requestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken?? _cancelToken,
        isList: isList,
        onSuccess: (data){
          if (isClose) view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onSuccessList: (data){
          if (isClose) view.closeProgress();
          if (onSuccessList != null) {
            onSuccessList(data);
          }
        },
        onError: (code, msg){
          _onError(code, msg, onError);
        }
    );
  }

  _onError(int code, String msg, Function(int code, String mag) onError){
    /// 异常时直接关闭加载圈，不受isClose影响
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error){
      view.showToast(msg);
    }
    if (onError != null) {
      onError(code, msg);
    }
  }
}

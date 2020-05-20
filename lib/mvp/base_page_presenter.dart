import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_deer/mvp/base_presenter.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:meta/meta.dart';

import 'mvps.dart';

class BasePagePresenter<V extends IMvpView> extends BasePresenter<V> {

  CancelToken _cancelToken;

  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void dispose() {
    /// 销毁时，将请求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  /// 返回Future 适用于刷新，加载更多
  Future requestNetwork<T>(Method method, {@required String url, bool isShow = true, bool isClose = true, Function(T t) onSuccess,
    Function(List<T> list) onSuccessList, Function(int code, String msg) onError, dynamic params, 
    Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList = false}) {
    if (isShow) view.showProgress();
    return DioUtils.instance.requestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken?? _cancelToken,
        isList: isList,
        onSuccess: (data) {
          if (isClose) view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onSuccessList: (data) {
          if (isClose) view.closeProgress();
          if (onSuccessList != null) {
            onSuccessList(data);
          }
        },
        onError: (code, msg) {
          _onError(code, msg, onError);
        }
    );
  }

  void asyncRequestNetwork<T>(Method method, {@required String url, bool isShow = true, bool isClose = true, Function(T t) onSuccess, Function(List<T> list) onSuccessList, Function(int code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList = false}) {
    if (isShow) view.showProgress();
    DioUtils.instance.asyncRequestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken?? _cancelToken,
        isList: isList,
        onSuccess: (data) {
          if (isClose) view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onSuccessList: (data) {
          if (isClose) view.closeProgress();
          if (onSuccessList != null) {
            onSuccessList(data);
          }
        },
        onError: (code, msg) {
          _onError(code, msg, onError);
        }
    );
  }

  /// 上传图片实现
  Future<String> uploadImg(File image) async {
    String imgPath = '';
    try{
      String path = image.path;
      var name = path.substring(path.lastIndexOf('/') + 1);
      var formData = FormData.fromMap({
        'uploadIcon': await MultipartFile.fromFile(path, filename: name)
      });
      await requestNetwork<String>(Method.post,
          url: HttpApi.upload,
          params: formData,
          onSuccess: (data) {
            imgPath = data;
          }
      );
    } catch(e) {
      view.showToast('图片上传失败！');
    }
    return imgPath;
  }

  void _onError(int code, String msg, Function(int code, String msg) onError) {
    /// 异常时直接关闭加载圈，不受isClose影响
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error) {
      view.showToast(msg);
    }
    /// 页面如果dispose，则不回调onError
    if (onError != null && view.getContext() != null) {
      onError(code, msg);
    }
  }
}

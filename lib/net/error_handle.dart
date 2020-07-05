import 'dart:io';

import 'package:dio/dio.dart';

class ExceptionHandle {
  static const int success = 200;
  static const int success_not_content = 204;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int not_found = 404;

  static const int net_error = 1000;
  static const int parse_error = 1001;
  static const int socket_error = 1002;
  static const int http_error = 1003;
  static const int timeout_error = 1004;
  static const int cancel_error = 1005;
  static const int unknown_error = 9999;

  static NetError handleException(dynamic error) {
    print(error);

    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.DEFAULT:
        case DioErrorType.RESPONSE:
          switch (error.error.runtimeType) {
            case HttpException:
              return NetError(http_error, '服务器异常！');
            case FormatException:
              return NetError(parse_error, '数据解析错误！');
            case SocketException:
              return NetError(socket_error, '网络异常，请检查你的网络！');
            default:
              return NetError(net_error, '网络异常，请检查你的网络！');
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          return NetError(timeout_error, '连接超时！');
        case DioErrorType.CANCEL:
          return NetError(cancel_error, '取消请求');
        default:
          return NetError(unknown_error, '未知异常');
      }
    }
    return NetError(unknown_error, '未知异常');
  }
}

class NetError {
  int code;
  String msg;

  NetError(this.code, this.msg);
}

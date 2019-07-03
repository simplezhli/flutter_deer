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

  static Error handleException(dynamic error){
    print(error);
    if (error is DioError){
      if (error.type == DioErrorType.DEFAULT || 
          error.type == DioErrorType.RESPONSE){
        dynamic e = error.error;
        if (e is SocketException){
          return Error(socket_error, "网络异常，请检查你的网络！");
        }
        if (e is HttpException){
          return Error(http_error, "服务器异常！");
        }
        return Error(net_error, "网络异常，请检查你的网络！");
      }else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT){
        return Error(timeout_error, "连接超时！");
      }else if (error.type == DioErrorType.CANCEL){
        return Error(cancel_error, "");
      }else{
        return Error(unknown_error, "未知异常");
      }
    }else {
      return Error(unknown_error, "未知异常");
    }
  }
}

class Error{
  int code;
  String msg;

  Error(this.code, this.msg);
}
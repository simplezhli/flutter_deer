

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/util/log_utils.dart';
import 'package:sprintf/sprintf.dart';

import 'dio_utils.dart';
import 'error_handle.dart';

class AuthInterceptor extends Interceptor{
  @override
  onRequest(RequestOptions options) {
    String accessToken = SpUtil.getString(Constant.accessToken);
    if (accessToken.isNotEmpty){
      options.headers["Authorization"] = "Bearer $accessToken";
    }
   
    return super.onRequest(options);
  }
}

class TokenInterceptor extends Interceptor{

  Future<String> getToken() async {

    Map<String, String> params = Map();
    params["refresh_token"] = SpUtil.getString(Constant.refreshToken);
    try{
      _tokenDio.options = DioUtils.instance.getDio().options;
      var response = await _tokenDio.post("lgn/refreshToken", data: params);
      if (response.statusCode == ExceptionHandle.success){
        return json.decode(response.data.toString())["access_token"];
      }
    }catch(e){
      Log.e("刷新Token失败！");
    }
    return null;
  }

  Dio _tokenDio = Dio();

  @override
  onResponse(Response response) async{
    //401代表token过期
    if (response != null && response.statusCode == ExceptionHandle.unauthorized) {
      Log.d("-----------自动刷新Token------------");
      Dio dio = DioUtils.instance.getDio();
      dio.interceptors.requestLock.lock();
      String accessToken = await getToken(); // 获取新的accessToken
      Log.e("-----------NewToken: $accessToken ------------");
      SpUtil.putString(Constant.accessToken, accessToken);
      dio.interceptors.requestLock.unlock();

      if (accessToken != null){{
        // 重新请求失败接口
        var request = response.request;
        request.headers["Authorization"] = "Bearer $accessToken";
        try {
          Log.e("----------- 重新请求接口 ------------");
          /// 避免重复执行拦截器，使用tokenDio
          var response = await _tokenDio.request(request.path,
              data: request.data,
              queryParameters: request.queryParameters,
              cancelToken: request.cancelToken,
              options: request,
              onReceiveProgress: request.onReceiveProgress);
          return response;
        } on DioError catch (e) {
          return e;
        }
      }}
    }
    return super.onResponse(response);
  }
}

class LoggingInterceptor extends Interceptor{

  DateTime startTime;
  DateTime endTime;
  
  @override
  onRequest(RequestOptions options) {
    startTime = DateTime.now();
    Log.d("----------Start----------");
    if (options.queryParameters.isEmpty){
      Log.i("RequestUrl: " + options.baseUrl + options.path);
    }else{
      Log.i("RequestUrl: " + options.baseUrl + options.path + "?" + Transformer.urlEncodeMap(options.queryParameters));
    }
    Log.d("RequestMethod: " + options.method);
    Log.d("RequestHeaders:" + options.headers.toString());
    Log.d("RequestContentType: ${options.contentType}");
    Log.d("RequestData: ${options.data.toString()}");
    return super.onRequest(options);
  }
  
  @override
  onResponse(Response response) {
    endTime = DateTime.now();
    int duration = endTime.difference(startTime).inMilliseconds;
    if (response.statusCode == ExceptionHandle.success){
      Log.d("ResponseCode: ${response.statusCode}");
    }else {
      Log.e("ResponseCode: ${response.statusCode}");
    }
    // 输出结果
    Log.json(response.data.toString());
    Log.d("----------End: $duration 毫秒----------");
    return super.onResponse(response);
  }
  
  @override
  onError(DioError err) {
    Log.d("----------Error-----------");
    return super.onError(err);
  }
}

class AdapterInterceptor extends Interceptor{

  static const String msg = "msg";
  static const String slash = "\"";
  static const String message = "message";

  static const String defaultText = "\"无返回信息\"";
  static const String notFound = "未找到查询信息";

  static const String failureFormat = "{\"code\":%d,\"message\":\"%s\"}";
  static const String successFormat = "{\"code\":0,\"data\":%s,\"message\":\"\"}";
  
  @override
  onResponse(Response response) {
    Response r = adapterData(response);
    return super.onResponse(r);
  }
  
  @override
  onError(DioError err) {
    if (err.response != null){
      adapterData(err.response);
    }
    return super.onError(err);
  }

  Response adapterData(Response response){
    String result;
    String content = response.data == null ? "" : response.data.toString();
    /// 成功时，直接格式化返回
    if (response.statusCode == ExceptionHandle.success || response.statusCode == ExceptionHandle.success_not_content){
      if (content == null || content.isEmpty){
        content = defaultText;
      }
      result = sprintf(successFormat, [content]);
      response.statusCode = ExceptionHandle.success;
    }else{
      if (response.statusCode == ExceptionHandle.not_found){
        /// 错误数据格式化后，按照成功数据返回
        result = sprintf(failureFormat, [response.statusCode, notFound]);
        response.statusCode = ExceptionHandle.success;
      }else {
        if (content == null || content.isEmpty){
          // 一般为网络断开等异常
          result = content;
        }else {
          String msg;
          try {
            content = content.replaceAll("\\", "");
            if (slash == content.substring(0, 1)){
              content = content.substring(1, content.length - 1);
            }
            Map<String, dynamic> map = json.decode(content);
            if (map.containsKey(message)){
              msg = map[message];
            }else if(map.containsKey(msg)){
              msg = map[msg];
            }else {
              msg = "未知异常";
            }
            result = sprintf(failureFormat, [response.statusCode, msg]);
            // 401 token失效时，单独处理，其他一律为成功
            if (response.statusCode == ExceptionHandle.unauthorized){
              response.statusCode = ExceptionHandle.unauthorized;
            }else {
              response.statusCode = ExceptionHandle.success;
            }
          } catch (e) {
            Log.d("异常信息：$e");
            // 解析异常直接按照返回原数据处理（一般为返回500,503 HTML页面代码）
            result = sprintf(failureFormat, [response.statusCode, "服务器异常(${response.statusCode})"]);
          }
        }
      }
    }
    response.data = result;
    return response;
  }
}


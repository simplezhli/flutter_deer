# pull request

> 注意！代码未经测试，仅作了目视检查

## 更改项
[error_handel::handleException](./lib/net/error_handle.dart) 代码优化。将 `if else` 改为 `switch case` 语句。

## 修改前

``` dart
static NetError handleException(dynamic error) {
    print(error);
    if (error is DioError) {
      if (error.type == DioErrorType.DEFAULT || 
          error.type == DioErrorType.RESPONSE) {
        dynamic e = error.error;
        if (e is SocketException) {
          return NetError(socket_error, '网络异常，请检查你的网络！');
        }
        if (e is HttpException) {
          return NetError(http_error, '服务器异常！');
        }
        if (e is FormatException) {
          return NetError(parse_error, '数据解析错误！');
        }
        return NetError(net_error, '网络异常，请检查你的网络！');
      } else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT) {
        return NetError(timeout_error, '连接超时！');
      } else if (error.type == DioErrorType.CANCEL) {
        return NetError(cancel_error, '取消请求');
      } else {
        return NetError(unknown_error, '未知异常');
      }
    } else {
      return NetError(unknown_error, '未知异常');
    }
  }
```

## 修改后

``` dart
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
```

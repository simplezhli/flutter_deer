package com.weilu.deer;


import android.os.Bundle;

import com.elvishew.xlog.LogConfiguration;
import com.elvishew.xlog.LogLevel;
import com.elvishew.xlog.XLog;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    // 指定日志级别，低于该级别的日志将不会被打印，默认为 LogLevel.ALL
    LogConfiguration config = new LogConfiguration.Builder()
            .logLevel(BuildConfig.DEBUG ? LogLevel.ALL : LogLevel.NONE).build();

    XLog.init(config);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), "x_log")
            .setMethodCallHandler((methodCall, result) -> logPrint(methodCall));
  }

  private void logPrint(MethodCall call) {
    String tag = call.argument("tag");
    String message = call.argument("msg");

    switch (call.method){
      case "logD":
        XLog.tag(tag).d(message);
        break;
      case "logW":
        XLog.tag(tag).w(message);
        break;
      case "logI":
        XLog.tag(tag).i(message);
        break;
      case "logE":
        XLog.tag(tag).e(message);
        break;
      case "logJson":
        try {
          XLog.tag(tag).json(message);
        } catch (Exception e) {
          XLog.tag(tag).d(message);
        }
        break;
      default:
        XLog.tag(tag).v(message);
        break;
    }
  }
}

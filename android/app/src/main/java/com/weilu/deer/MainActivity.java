package com.weilu.deer;

import android.content.Intent;
import android.os.Bundle;

import com.elvishew.xlog.XLog;

import java.io.File;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), "version").setMethodCallHandler((methodCall, result) -> {
      if (methodCall.method.equals("install")){
        String path = methodCall.argument("path");
        openFile(path);
      }else {
        result.notImplemented();
      }
    });
  }

  /**
   * 安装 文件（APK）
   */
  private void openFile(String path) {
    Intent intents = new Intent();
    intents.setAction(Intent.ACTION_VIEW);
    intents.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    FileProvider7.setIntentDataAndType(this, intents, "application/vnd.android.package-archive", new File(path), false);
    this.startActivity(intents);
  }
  
}

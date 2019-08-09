package com.weilu.deer;

import com.elvishew.xlog.LogConfiguration;
import com.elvishew.xlog.LogLevel;
import com.elvishew.xlog.XLog;

import io.flutter.app.FlutterApplication;

/**
 * @Description:
 * @Author: weilu
 * @Time: 2019/8/5 0005 17:08.
 */
public class MyApp extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        // 指定日志级别，低于该级别的日志将不会被打印，默认为 LogLevel.ALL
        LogConfiguration config = new LogConfiguration.Builder()
                .logLevel(BuildConfig.DEBUG ? LogLevel.ALL : LogLevel.NONE).build();

        XLog.init(config);
    }
}

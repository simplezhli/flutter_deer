package com.weilu.deer;

import android.content.Context;

import androidx.multidex.MultiDex;

import io.flutter.app.FlutterApplication;

/**
 * @Description:
 * @Author: weilu
 * @Time: 2019/8/5 0005 17:08.
 */
public class MyApp extends FlutterApplication {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }
}

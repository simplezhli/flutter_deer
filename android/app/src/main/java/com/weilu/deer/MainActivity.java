package com.weilu.deer;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;

/**
 * @author weilu
 */
public class MainActivity extends FlutterActivity {

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    flutterEngine.getPlugins().add(new InstallAPKPlugin(this));
    // https://github.com/flutter/flutter/issues/47021
    // ImagePickerPlugin暂不支持v2插件api，导致初始化未能完成。这里手动初始化一遍。
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
    io.flutter.plugins.imagepicker.ImagePickerPlugin.registerWith(shimPluginRegistry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
  }
}

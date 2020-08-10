## shader

详细使用方法见文档：https://flutter.cn/docs/perf/rendering/shader

本项目提供我捕获的`SkSL着色`json文件（Android），可在项目根目录执行：

```
  flutter build apk --bundle-sksl-path shader/flutter_01.sksl.json
```

经测试在低性能设备（华为平板C5 麒麟659）有明显效果。
# Android 问题汇总

## Could not resolve io.flutter:flutter_embedding_xxx

### 大致异常如下：

```java
Could not resolve all files for configuration ':app:debugCompileClasspath'.
    > Could not resolve io.flutter:flutter_embedding_debug:1.0.0-6bc433c6b6b5b98dcf4cc11aff31cdee90849f32.
    ...
```

### 解决方法：

修改`flutter\packages\flutter_tools\gradle`下的`flutter.gradle`文件。

替换`MAVEN_REPO`为： http://download.flutter.io

或者修改flutter项目`android`目录的`build.gradle`文件，在`repositories`中添加：

```java
maven {
    url `http://download.flutter.io`
}
```

参考：https://github.com/flutter/flutter/issues/39729

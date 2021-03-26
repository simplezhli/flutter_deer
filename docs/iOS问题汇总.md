# iOS 问题汇总

## CDN: trunk Repo update failed

### 问题如下：

```java
[!] CDN: trunk Repo update failed - xx error(s):
    CDN: trunk URL couldn't be downloaded: https://raw.githubusercontent.com/CocoaPods/Specs/master/Specs/...
    ...
```

### 原因：

CocoaPods 1.8后将CDN切换为默认的spec repo源。

### 解决方法：

1.Podfile文件中添加source源：

```
source 'https://github.com/CocoaPods/Specs.git'
```

或者指定为国内的镜像：

```
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
```

2.执行`pod repo remove trunk`移除trunk源。

参考：https://www.jianshu.com/p/bf1cbe49cb5d

## CDN: trunk URL couldn't be downloaded

在host文件中添加：

```
151.101.76.133 raw.githubusercontent.com
```

如果这个ip无效，可以根据这个[查询真实IP](https://www.cnblogs.com/ljcgood66/p/12852044.html)自行查询。

参考：https://www.ioiox.com/archives/62.html
     https://mirrors.tuna.tsinghua.edu.cn/help/CocoaPods/


## 历史问题

- [~~iOS使用Let's Encript证书，App卡死~~](https://github.com/flutterchina/dio/issues/703#issuecomment-748737446)

- 1.17.0已知问题(~~#38323~~ ~~#47191~~)。

- 1.17.0已修复。~~在iOS手机上开启深色模式时，[无法将状态栏文字修改为黑色](https://github.com/flutter/flutter/issues/41067)。~~
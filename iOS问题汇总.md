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

1.podfile文件中添加source源：

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
199.232.4.133 raw.githubusercontent.com
```

参考：https://www.ioiox.com/archives/62.html
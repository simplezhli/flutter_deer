# Web 问题汇总（flutter 2.2.0）

## service worker

flutter 2.2中新的`service worker`加载机制目前发现兼容不够，部分浏览器无法正常工作。（web/index1.html）

## CanvasKit渲染（默认PC浏览器）

### 中文文字、表情等加载延迟导致乱码现象

主要原因是完整的字体表情包太大，不能是一次加载完成，按需加载过程导致此类现象。

具体问题跟进可以关注：

- [[web] Emojis take a few seconds to render on canvaskit ](https://github.com/flutter/flutter/issues/76248)

- [[Web] [CanvasKit][Feature Request]: Load fonts as soon as detecting browser locale](https://github.com/flutter/flutter/issues/77023)

## HTML渲染（默认手机浏览器）

### 使用`TextOverflow.ellipsis`属性。

现象如下：

- 文字没有超出，后面出现红色省略号。

- 文字超出，未出现省略号。

其他相关问题：

- [[canvaskit] font renders missing glyph when text overflow is ellipsis](https://github.com/flutter/flutter/issues/76473)

## 指定渲染引擎

```
flutter run -d chrome --release --web-renderer html
// 或
flutter run -d chrome --release --web-renderer canvaskit
```

> 总结：HTML渲染相较于CanvasKit渲染，UI还原度差一些，但综合性能相对较好。


## 已解决问题

### 使用`Transform`。

在变换Widget时，添加的`LinearGradient`没有渐变效果。。。（例子见lib/account/widgets/withdrawal_account_item.dart）

目前处理方法是添加`RepaintBoundary`。

### 按钮的大小在移动端与Web端不同

可以`ThemeData`中全局指定`visualDensity`属性为`VisualDensity.standard`。

详情见[Buttons not respecting default dimensions](https://github.com/flutter/flutter/issues/77142)

## 已修复问题

### ~~使用`DecorationImage`的`colorFilter`属性。~~

`ColorFilter.mode`中的color为null时，Web报错NoSuchMethodError: invalid member on null: 'red' 。
2.2.0上`ColorFilter.mode`中的color以不能设为null。

其他相关问题：

[[web] wrong image filter on web app built with HTML renderer](https://github.com/flutter/flutter/issues/76966)

### ~~使用`Locale`报空安全错误~~

2.2.0已修复，详情见[[Web]: App throws null safety errors on Locale using latest stable, but works on Master](https://github.com/flutter/flutter/issues/79351)






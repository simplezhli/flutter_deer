# Web 问题汇总（flutter 2.0.3）

## CanvasKit渲染，使用`DecorationImage`的`colorFilter`属性。

`ColorFilter.mode`中的color为null时，Web报错NoSuchMethodError: invalid member on null: 'red' ，因此这里注意指定色值。

其他相关问题：

- [[web] wrong image filter on web app built with HTML renderer](https://github.com/flutter/flutter/issues/76966)

## HTML渲染，使用`TextOverflow.ellipsis`属性。（Chrome 浏览器）

现象如下：

- 文字没有超出，后面出现红色省略号。

- 文字超出，未出现省略号。

其他相关问题：

- [[canvaskit] font renders missing glyph when text overflow is ellipsis](https://github.com/flutter/flutter/issues/76473)

## HTML渲染，使用`Transform`。

在变换Widget时，添加的`LinearGradient`没有渐变效果。。。（例子见lib/account/widgets/withdrawal_account_item.dart）

目前处理方法是添加`RepaintBoundary`。





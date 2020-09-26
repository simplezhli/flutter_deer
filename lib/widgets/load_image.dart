
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/util/image_utils.dart';

/// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {
  
  const LoadImage(this.image, {
    Key key,
    this.width, 
    this.height,
    this.fit = BoxFit.cover, 
    this.format = ImageFormat.png,
    this.holderImg = 'none',
    this.cacheWidth,
    this.cacheHeight,
  }) : assert(image != null, 'The [image] argument must not be null.'),
       super(key: key);
  
  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageFormat format;
  final String holderImg;
  final int cacheWidth;
  final int cacheHeight;
  
  @override
  Widget build(BuildContext context) {

    if (image.isEmpty || image.startsWith('http')) {
      final Widget _image = LoadAssetImage(holderImg, height: height, width: width, fit: fit);
      return CachedNetworkImage(
        imageUrl: image,
        placeholder: (_, __) => _image,
        errorWidget: (_, __, dynamic error) => _image,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
      );
    } else {
      return LoadAssetImage(image,
        height: height,
        width: width,
        fit: fit,
        format: format,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
    }
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  
  const LoadAssetImage(this.image, {
    Key key,
    this.width,
    this.height, 
    this.cacheWidth,
    this.cacheHeight,
    this.fit,
    this.format = ImageFormat.png,
    this.color
  }): super(key: key);

  final String image;
  final double width;
  final double height;
  final int cacheWidth;
  final int cacheHeight;
  final BoxFit fit;
  final ImageFormat format;
  final Color color;
  
  @override
  Widget build(BuildContext context) {

    return Image.asset(
      ImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      color: color,
      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}

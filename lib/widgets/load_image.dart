
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/util/image_utils.dart';

/// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {
  
  const LoadImage(this.image, {
    Key key,
    this.width, 
    this.height,
    this.fit: BoxFit.cover, 
    this.format: "png",
    this.holderImg: "none"
  }): super(key: key);
  
  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final String holderImg;
  
  @override
  Widget build(BuildContext context) {
    if (TextUtil.isEmpty(image) || image == "null"){
      return LoadAssetImage(holderImg,
        height: height,
        width: width,
        fit: fit,
        format: format
      );
    }else {
      if (image.startsWith("http")){
        return CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) => LoadAssetImage(holderImg, height: height, width: width, fit: fit),
          errorWidget: (context, url, error) => LoadAssetImage(holderImg, height: height, width: width, fit: fit),
          width: width,
          height: height,
          fit: fit,
        );
      }else{
        return LoadAssetImage(image,
            height: height,
            width: width,
            fit: fit,
            format: format
        );
      }
    }
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  
  const LoadAssetImage(this.image, {
    Key key,
    this.width,
    this.height, 
    this.fit,
    this.format: 'png', 
  }): super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      fit: fit,
    );
  }
}

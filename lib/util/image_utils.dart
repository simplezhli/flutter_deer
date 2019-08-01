
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 加载本地资源图片
Widget loadAssetImage(String name, {double width, double height, BoxFit fit}){
  return Image.asset(
    Utils.getImgPath(name),
    height: height,
    width: width,
    fit: fit,
  );
}

/// 加载网络图片
Widget loadNetworkImage(String imageUrl, {double width, double height, BoxFit fit: BoxFit.cover, String holderImg: "none"}){
  if (TextUtil.isEmpty(imageUrl)){
    return loadAssetImage(holderImg, height: height, width: width, fit: fit);
  }
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) => loadAssetImage(holderImg, height: height, width: width, fit: fit),
    errorWidget: (context, url, error) => loadAssetImage(holderImg, height: height, width: width, fit: fit),
    width: width,
    height: height,
    fit: fit,
  );
}

ImageProvider getImageProvider(String imageUrl, {String holderImg: "none"}){
  if (TextUtil.isEmpty(imageUrl)){
    return AssetImage(Utils.getImgPath(holderImg));
  }
  return CachedNetworkImageProvider(imageUrl);
}
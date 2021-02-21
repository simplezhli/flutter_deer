
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImage extends StatefulWidget {

  const SelectedImage({
    Key key,
    this.size = 80.0,
  }): super(key: key);

  final double size;

  @override
  SelectedImageState createState() => SelectedImageState();
}

class SelectedImageState extends State<SelectedImage> {

  final ImagePicker _picker = ImagePicker();
  ImageProvider _imageProvider;
  PickedFile pickedFile;

  Future<void> _getImage() async {
    try {
      pickedFile = await _picker.getImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile != null) {

        if (Device.isWeb) {
          _imageProvider = NetworkImage(pickedFile.path);
        } else {
          _imageProvider = FileImage(File(pickedFile.path));
        }

      } else {
        _imageProvider = null;
      }
      setState(() {

      });
    } catch (e) {
      Toast.show('没有权限，无法打开相册！');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '选择图片',
      hint: '跳转相册选择图片',
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: _getImage,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            // 图片圆角展示
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              image: _imageProvider ?? ImageUtils.getAssetImage('store/icon_zj'),
              fit: BoxFit.cover,
              colorFilter: _imageProvider == null ? ColorFilter.mode(ThemeUtils.getDarkColor(context, Colours.dark_unselected_item_color), BlendMode.srcIn) : null
            ),
          ),
        ),
      ),
    );
  }
}


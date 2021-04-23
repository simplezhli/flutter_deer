import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/util/other_utils.dart';
import 'package:flutter_deer/util/version_utils.dart';
import 'package:flutter_deer/widgets/my_button.dart';


class UpdateDialog extends StatefulWidget {

  const UpdateDialog({Key? key}) : super(key: key);

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  
  final CancelToken _cancelToken = CancelToken();
  bool _isDownload = false;
  double _value = 0;
  
  @override
  void dispose() {
    if (!_cancelToken.isCancelled && _value != 1) {
      _cancelToken.cancel();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: () async {
        /// 使用false禁止返回键返回，达到强制升级目的
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 120.0,
                width: 280.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                  image: DecorationImage(
                    image: ImageUtils.getAssetImage('update_head', format: ImageFormat.jpg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 280.0,
                decoration: BoxDecoration(
                  color: context.dialogBackgroundColor,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('新版本更新', style: TextStyles.textSize16),
                    Gaps.vGap10,
                    const Text('1.又双叒修复了一大堆bug。\n\n2.祭天了多名程序猿。'),
                    Gaps.vGap15,
                    if (_isDownload)
                      LinearProgressIndicator(
                        backgroundColor: Colours.line,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        value: _value,
                      )
                    else
                      _buildButton(context),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: MyButton(
            text: '残忍拒绝',
            fontSize: Dimens.font_sp16,
            textColor: primaryColor,
            disabledTextColor: Colors.white,
            disabledBackgroundColor: Colours.text_gray_c,
            radius: 18.0,
            side: BorderSide(
              color: primaryColor,
              width: 0.8,
            ),
            backgroundColor: Colors.transparent,
            onPressed: () {
              NavigatorUtils.goBack(context);
            },
          ),
        ),
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: MyButton(
            text: '立即更新',
            fontSize: Dimens.font_sp16,
            onPressed: () {
              if (defaultTargetPlatform == TargetPlatform.iOS) {
                NavigatorUtils.goBack(context);
                VersionUtils.jumpAppStore();
              } else {
                setState(() {
                  _isDownload = true;
                });
                _download();
              }
            },
            textColor: Colors.white,
            backgroundColor: primaryColor,
            disabledTextColor: Colors.white,
            disabledBackgroundColor: Colours.text_gray_c,
            radius: 18.0,
          ),
        )
      ],
    );
  }

  ///下载apk
  Future<void> _download() async {
    try {
      setInitDir(initStorageDir: true);
      await DirectoryUtil.getInstance();
      DirectoryUtil.createStorageDirSync(category: 'Download');
      final String path = DirectoryUtil.getStoragePath(fileName: 'deer', category: 'Download', format: 'apk').nullSafe;
      final File file = File(path);
      /// 链接可能会失效
      await Dio().download('http://imtt.dd.qq.com/16891/apk/FF9625F40FD26F015F4CDED37B6B66AE.apk',
        file.path,
        cancelToken: _cancelToken,
        onReceiveProgress: (int count, int total) {
          if (total != -1) {
            _value = count / total;
            setState(() {

            });
            if (count == total) {
              NavigatorUtils.goBack(context);
              VersionUtils.install(path);
            }
          }
        },
      );
    } catch (e) {
      Toast.show('下载失败!');
      print(e);
      setState(() {
        _isDownload = false;
      });
    }
  }
}


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/version_utils.dart';


class UpdateDialog extends StatefulWidget {
  
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
          child: Container(
            decoration: BoxDecoration(
              color: ThemeUtils.getDialogBackgroundColor(context),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 280.0,
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
                      image: ImageUtils.getAssetImage('update_head', format: 'jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 16.0),
                  child: Text('新版本更新', style: TextStyles.textSize16),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Text('1.又双叒修复了一大堆bug。\n\n2.祭天了多名程序猿。'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0 , top: 5.0),
                  child: _isDownload ? LinearProgressIndicator(
                    backgroundColor: Colours.line,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    value: _value,
                  ): Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 110.0,
                        height: 36.0,
                        child: FlatButton(
                          onPressed: () {
                            NavigatorUtils.goBack(context);
                          },
                          textColor: primaryColor,
                          color: Colors.transparent,
                          disabledTextColor: Colors.white,
                          disabledColor: Colours.text_gray_c,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: primaryColor,
                              width: 0.8,
                            ),
                          ),
                          child: const Text(
                            '残忍拒绝',
                            style: TextStyle(fontSize: Dimens.font_sp16),
                          ),
                        ),
                      ),
                      Container(
                        width: 110.0,
                        height: 36.0,
                        child: FlatButton(
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
                          color: primaryColor,
                          disabledTextColor: Colors.white,
                          disabledColor: Colours.text_gray_c,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: const Text(
                            '立即更新',
                            style: TextStyle(fontSize: Dimens.font_sp16),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
        )
      ),
    );
  }
  
  ///下载apk
  Future<void> _download() async {
    try {
      setInitDir(initStorageDir: true);
      await DirectoryUtil.getInstance();
      DirectoryUtil.createStorageDirSync(category: 'Download');
      String path = DirectoryUtil.getStoragePath(fileName: 'deer', category: 'Download', format: 'apk');
      File file = File(path);
      /// 链接可能会失效
      await Dio().download('https://54a0bf2343ff38bdc347780545bd8c9e.dd.cdntips.com/imtt.dd.qq.com/16891/apk/E664A57DD3EA0540676EFC830BFDDE97.apk',
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

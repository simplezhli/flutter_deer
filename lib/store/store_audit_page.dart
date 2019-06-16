
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/store_select_text_item.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/store/store_audit_result_page.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class StoreAudit extends StatefulWidget {
  @override
  _StoreAuditState createState() => _StoreAuditState();
}

class _StoreAuditState extends State<StoreAudit> {

  Future<File> _imageFile;
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  
  void _getImage() {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText2,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText3,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("关闭"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: MyAppBar(
        centerTitle: "店铺审核资料",
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
                child: _buildBody()
              ) : SingleChildScrollView(
                child: _buildBody()
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: MyButton(
                onPressed: (){
                  AppNavigator.push(context, StoreAuditResult());
                },
                text: "提交",
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap5,
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("店铺资料", style: TextStyles.textBoldDark18),
          ),
          Gaps.vGap16,
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: (){
                    //选择图片
                    _getImage();
                  },
                  child: FutureBuilder(
                      future: _imageFile,
                      builder: (_, snapshot){
                        return Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            // 图片圆角展示
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                              image: snapshot.connectionState == ConnectionState.done && snapshot.data != null ?
                              FileImage(snapshot.data) : AssetImage(Utils.getImgPath("store/icon_zj")),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                  ),
                ),
                Gaps.vGap10,
                Text(
                  "店主手持身份证或营业执照",
                  style: TextStyles.textGray14,
                )
              ],
            ),
          ),
          Gaps.vGap16,
          TextFieldItem(
              focusNode: _nodeText1,
              title: "店铺名称",
              hintText: "填写店铺名称"
          ),
          StoreSelectTextItem(
              title: "主营范围",
              content: _sortName,
              onTap: (){
                _showBottomSheet();
              }
          ),
          StoreSelectTextItem(
              title: "店铺地址",
              content: "陕西省 西安市 雁塔区 高新六路201号",
              onTap: (){ }
          ),
          Gaps.vGap16,
          Gaps.vGap16,
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("店主信息", style: TextStyles.textBoldDark18),
          ),
          Gaps.vGap16,
          TextFieldItem(
              focusNode: _nodeText2,
              title: "店主姓名",
              hintText: "填写店主姓名"
          ),
          TextFieldItem(
              focusNode: _nodeText3,
              config: _buildConfig(context),
              keyboardType: TextInputType.phone,
              title: "联系电话",
              hintText: "填写店主联系电话"
          )
        ],
      ),
    );
  }

  String _sortName = "";
  var _list = ["水果生鲜", "家用电器", "休闲食品", "茶酒饮料", "美妆个护", "粮油调味", "家庭清洁", "厨具用品", "儿童玩具", "床上用品"];

  _showBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 360.0,
          child: ListView.builder(
            itemBuilder: (_, index){
              return InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: 48.0,
                  alignment: Alignment.centerLeft,
                  child: Text(_list[index]),
                ),
                onTap: (){
                  setState(() {
                    _sortName = _list[index];
                  });
                  Navigator.of(context).pop();
                },
              );
            },
            itemCount: _list.length,
          ),
        );
      },
    );
  }
}

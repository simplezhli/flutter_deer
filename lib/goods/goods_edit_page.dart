
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';

import 'goods_size_page.dart';
import 'goods_sort_dialog.dart';

class GoodsEdit extends StatefulWidget {
  
  const GoodsEdit({Key key, this.isAdd: true}) : super(key: key);
  
  final bool isAdd;
  
  @override
  _GoodsEditState createState() => _GoodsEditState();
}

class _GoodsEditState extends State<GoodsEdit> {

  Future<File> _imageFile;
  String _goodsSortName;

  void _getImage() {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: widget.isAdd ? "添加商品" : "编辑商品",
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gaps.vGap5,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "基本信息",
                        style: TextStyles.textBoldDark18,
                      ),
                    ),
                    Gaps.vGap16,
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              //选择图片
                              _getImage();
                            },
                            borderRadius: BorderRadius.circular(16.0),
                            child: FutureBuilder(
                                future: _imageFile,
                                builder: (_, snapshot){
                                  return Container(
                                    width: 96.0,
                                    height: 96.0,
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
                          Gaps.vGap8,
                          Text(
                            "点击添加商品图片",
                            style: TextStyles.textGray14,
                          )
                        ],
                      ),
                    ),
                    Gaps.vGap16,
                    TextFieldItem(
                      title: "商品名称",
                      hintText: "填写商品名称",
                    ),
                    TextFieldItem(
                      title: "商品简介",
                      hintText: "填写简短描述",
                    ),
                    TextFieldItem(
                      title: "折后价格",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      hintText: "填写商品单品折后价格",
                    ),
                    TextFieldItem(
                      title: "商品条码",
                      hintText: "选填",
                    ),
                    TextFieldItem(
                      title: "商品说明",
                      hintText: "选填",
                    ),
                    Gaps.vGap16,
                    Gaps.vGap16,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "折扣立减",
                        style: TextStyles.textBoldDark18,
                      ),
                    ),
                    Gaps.vGap16,
                    TextFieldItem(
                      title: "立减金额",
                      keyboardType: TextInputType.numberWithOptions(decimal: true)
                    ),
                    TextFieldItem(
                      title: "折扣金额",
                      keyboardType: TextInputType.numberWithOptions(decimal: true)
                    ),
                    Gaps.vGap16,
                    Gaps.vGap16,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "类型规格",
                        style: TextStyles.textBoldDark18,
                      ),
                    ),
                    Gaps.vGap16,
                    ClickItem(
                      title: "商品类型",
                      content: _goodsSortName ?? "选择商品类型",
                      onTap: (){
                        _showBottomSheet();
                      },
                    ),
                    ClickItem(
                      title: "商品规格",
                      content: "对规格进行编辑",
                      onTap: (){
                        AppNavigator.push(context, GoodsSize());
                      },
                    ),
                    Gaps.vGap8,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: MyButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                text: "提交",
              ),
            )
          ],
        ),
      ),
    );
  }

  _showBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GoodsSortDialog(
          onSelected: (_, name){
            setState(() {
              _goodsSortName = name;
            });
          },
        );
      },
    );
  }
}

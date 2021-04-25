import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/provider/goods_sort_provider.dart';
import 'package:flutter_deer/goods/widgets/goods_sort_bottom_sheet.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/widgets/selected_image.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../goods_router.dart';

/// design/4商品/index.html#artboard5
class GoodsEditPage extends StatefulWidget {
  
  const GoodsEditPage({
    Key? key,
    this.isAdd = true,
    this.isScan = false,
    this.heroTag,
    this.goodsImageUrl
  }) : super(key: key);
  
  final bool isAdd;
  final bool isScan;
  final String? heroTag;
  final String? goodsImageUrl;
  
  @override
  _GoodsEditPageState createState() => _GoodsEditPageState();
}

class _GoodsEditPageState extends State<GoodsEditPage> {

  String? _goodsSortName;
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.isScan) {
        _scan();
      }
    });
  }

  void _scan() {
    if (Device.isMobile) {
      NavigatorUtils.pushResult(context, GoodsRouter.qrCodeScannerPage, (Object code) {
        _codeController.text = code.toString();
      });
    } else {
      Toast.show('当前平台暂不支持');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: widget.isAdd ? '添加商品' : '编辑商品',
      ),
      body: MyScrollView(
        key: const Key('goods_edit_page'),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: <Widget>[
          Gaps.vGap5,
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              '基本信息',
              style: TextStyles.textBold18,
            ),
          ),
          Gaps.vGap16,
          Center(
            child: SelectedImage(
              heroTag: widget.heroTag,
              url: widget.goodsImageUrl,
              size: 96.0,
            ),
          ),
          Gaps.vGap8,
          Center(
            child: Text(
              '点击添加商品图片',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14),
            ),
          ),
          Gaps.vGap16,
          const TextFieldItem(
            title: '商品名称',
            hintText: '填写商品名称',
          ),
          const TextFieldItem(
            title: '商品简介',
            hintText: '填写简短描述',
          ),
          const TextFieldItem(
            title: '折后价格',
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            hintText: '填写商品单品折后价格',
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              TextFieldItem(
                controller: _codeController,
                title: '商品条码',
                hintText: '选填',
              ),
              Positioned(
                right: 0.0,
                child: Semantics(
                  label: '扫码',
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: context.isDark ?
                        const LoadAssetImage('goods/icon_sm', width: 16.0, height: 16.0) :
                        const LoadAssetImage('goods/scanning', width: 16.0, height: 16.0),
                    ),
                    onTap: _scan,
                  ),
                ),
              )
            ],
          ),
          const TextFieldItem(
            title: '商品说明',
            hintText: '选填',
          ),
          Gaps.vGap32,
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              '折扣立减',
              style: TextStyles.textBold18,
            ),
          ),
          Gaps.vGap16,
          const TextFieldItem(
            title: '立减金额',
            keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          const TextFieldItem(
            title: '折扣金额',
            keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          Gaps.vGap32,
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              '类型规格',
              style: TextStyles.textBold18,
            ),
          ),
          Gaps.vGap16,
          ClickItem(
            title: '商品类型',
            content: _goodsSortName ?? '选择商品类型',
            onTap: () => _showBottomSheet(),
          ),
          ClickItem(
            title: '商品规格',
            content: '对规格进行编辑',
            onTap: () => NavigatorUtils.push(context, GoodsRouter.goodsSizePage),
          ),
          Gaps.vGap8,
        ],
        bottomButton: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyButton(
            onPressed: () => NavigatorUtils.goBack(context),
            text: '提交',
          ),
        ),
      )
    );
  }

  final GoodsSortProvider _provider = GoodsSortProvider();

  @override
  void dispose() {
    _provider.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GoodsSortBottomSheet(
          provider: _provider,
          onSelected: (_, name) {
            setState(() {
              _goodsSortName = name;
            });
          },
        );
      },
    );
  }
}

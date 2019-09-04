
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/models/goods_size_model.dart';
import 'package:flutter_deer/goods/widgets/goods_size_dialog.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/popup_window.dart';
import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../goods_router.dart';

class GoodsSizePage extends StatefulWidget {
  @override
  _GoodsSizePageState createState() => _GoodsSizePageState();
}

class _GoodsSizePageState extends State<GoodsSizePage> {
  
  bool _isEdit = false;
  String _sizeName = "商品规格名称";
  GlobalKey _hintKey = GlobalKey();
  
  @override
  void initState() {
    super.initState();
    goodsSizeList.clear();
    goodsSizeList.add(new GoodsSizeModel("goods/goods_size_1", "黑色", 1000, "50.0", 2, "2", "2", "2"));
    goodsSizeList.add(new GoodsSizeModel("goods/goods_size_2", "银色", 100, "51.0", 1, "", "2", "1"));
    goodsSizeList.add(new GoodsSizeModel("goods/goods_size_1", "黑色1", 1050, "50.0", 2, "20", "2", ""));
    goodsSizeList.add(new GoodsSizeModel("goods/goods_size_2", "银色1", 1000, "55.0", 2, "", "10", "2"));
    goodsSizeList.add(new GoodsSizeModel("goods/goods_size_1", "黑色2", 500, "56", 2, "2", "2", "2"));
    goodsSizeList.add(new GoodsSizeModel("goods/goods_size_2", "银色2", 110, "51.0", 2, "2", "1", ""));
    goodsSizeList.add(new GoodsSizeModel("goods/goods_size_1", "黑色3", 10, "50.0", 2, "2", "2.5", ""));

    // 获取Build完成状态监听
    var widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback){
      _showHint();
    });
  }

  _showHint(){
    final RenderBox hint = _hintKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var a =  hint.localToGlobal(Offset(50.0 , hint.size.height + 150.0), ancestor: overlay);
    var b =  hint.localToGlobal(hint.size.bottomLeft(Offset(50.0, 150.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    showPopupWindow(
      context: context,
      fullWidth: false,
      isShowBg: true,
      position: position,
      elevation: 0.0,
      child: Container(
        width: 200.0,
        height: 147.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageUtils.getAssetImage("goods/ydss"),
            fit: BoxFit.fitWidth
          )
        ),
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        key: _hintKey,
        title: "商品规格",
        actionName: "保存",
        onPressed: (){
          Toast.show("保存");
          NavigatorUtils.goBack(context);
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap16,
            Gaps.vGap5,
            Text(
              _sizeName,
              style: TextStyles.textBoldDark24,
            ),
            Gaps.vGap8,
            InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return GoodsSizeDialog(
                        onPressed: (name){
                          setState(() {
                            _sizeName = name;
                            _isEdit = true;
                          });
                        },
                      );
                    });
              },
              child: RichText(
                text: TextSpan(
                  text: '先对名称进行',
                  style: TextStyles.textGray14,
                  children: <TextSpan>[
                    TextSpan(text: '编辑', style: TextStyle(color: Colours.app_main)),
                  ],
                )
              ),
            ),
            Gaps.vGap16,
            Gaps.vGap16,
            Expanded(
              child: goodsSizeList.isEmpty ? const StateLayout(
                type: StateType.goods,
                hintText: "暂无商品规格",
              ) : ListView.builder(
                itemCount: goodsSizeList.length,
                itemExtent: 105.0,
                itemBuilder: (_, index){
                  return getGoodsSizeItem(index);
                },
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: MyButton(
                onPressed: _isEdit ? (){
                  NavigatorUtils.push(context, GoodsRouter.goodsSizeEditPage);
                } : null,
                text: "添加",
              ),
            )
          ],
        ),
      ),
    );
  }
  
  List<GoodsSizeModel> goodsSizeList = [];
  // 保留一个Slidable打开
  final SlidableController _slidableController = SlidableController();
  
  Widget getGoodsSizeItem(int index){
    return Slidable(
      key: Key(index.toString()),
      controller: _slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20, 
      ///右侧的action
      secondaryActions: <Widget>[
        SlideAction(
          child: Container(
            width: 72.0,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: const LoadAssetImage("goods/goods_delete"),
          ),
          color: Colours.text_red,
          onTap: () {
            setState(() {
              goodsSizeList.removeAt(index);
            });
          },
        ),
      ],
      child: InkWell(
        onTap: (){
          NavigatorUtils.push(context, GoodsRouter.goodsSizeEditPage);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border(
                  bottom: Divider.createBorderSide(context, color: Colours.line, width: 0.8),
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LoadAssetImage(goodsSizeList[index].icon, width: 72.0, height: 72.0),
                  Gaps.hGap8,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              goodsSizeList[index].sizeName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.textDark14
                            ),
                            Text(
                              "库存${goodsSizeList[index].stock}",
                              style: TextStyles.textDark12
                            ),
                         ],
                        ),
                        Gaps.vGap4,
                        Row(
                          children: <Widget>[
                            Offstage(
                              offstage: goodsSizeList[index].reducePrice.isEmpty,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                margin: const EdgeInsets.only(right: 4.0),
                                decoration: BoxDecoration(
                                  color: Colours.text_red,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                height: 16.0,
                                alignment: Alignment.center,
                                child: Text(
                                  "立减${goodsSizeList[index].reducePrice}元",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp10
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: goodsSizeList[index].currencyPrice.isEmpty ? 0.0 : 1.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: Colours.app_main,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                height: 16.0,
                                alignment: Alignment.center,
                                child: Text(
                                  "社区币抵扣${goodsSizeList[index].currencyPrice}元",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp10
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Gaps.vGap16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "¥${goodsSizeList[index].price}",
                              style: TextStyles.textDark14,
                            ),
                            const SizedBox(width: 50.0,),
                            Text(
                              "佣金${goodsSizeList[index].charges}元",
                              style: TextStyles.textDark12
                            ),
                            Text(
                              "起购${goodsSizeList[index].minSaleNum}件",
                              style: TextStyles.textDark12
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/menu_reveal.dart';


/// design/4商品/index.html#artboard1
class GoodsItem extends StatelessWidget {
  
  const GoodsItem({
    Key key,
    @required this.img,
    @required this.index,
    @required this.selectIndex,
    @required this.onTapMenu,
    @required this.onTapEdit,
    @required this.onTapOperation,
    @required this.onTapDelete,
    @required this.onTapMenuClose,
    @required this.animation
  }): super(key: key);

  final String img;
  final int index;
  final int selectIndex;
  final Function onTapMenu;
  final Function onTapEdit;
  final Function onTapOperation;
  final Function onTapDelete;
  final Function onTapMenuClose;
  final Animation<double> animation;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border(
                  bottom: Divider.createBorderSide(context, width: 0.8),
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LoadImage(img, width: 72.0, height: 72.0),
                  Gaps.hGap8,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "八月十五中秋月饼礼盒",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis
                        ),
                        Gaps.vGap4,
                        Row(
                          children: <Widget>[
                            Offstage(
                              // 类似于gone
                              offstage: index % 3 != 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                margin: const EdgeInsets.only(right: 4.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).errorColor,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                height: 16.0,
                                alignment: Alignment.center,
                                child: const Text(
                                  "立减",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp10
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              // 修改透明度实现隐藏，类似于invisible
                              opacity: index % 2 != 0 ? 0.0 : 1.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                height: 16.0,
                                alignment: Alignment.center,
                                child: const Text(
                                  "社区币抵扣",
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
                        const Text("¥20.00")
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                            key: Key('goods_menu_item_$index'),
                            width: 24.0,
                            height: 24.0,
                            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: const LoadAssetImage("goods/ellipsis")
                        ),
                        onTap: onTapMenu,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          "特产美味",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Offstage(
            offstage: selectIndex != index,
            child: AnimatedBuilder(
                animation: animation,
                builder:(_, child){
                  bool isDark = ThemeUtils.isDark(context);
                  Color buttonColor = isDark ? Colours.dark_text : Colors.white;
                  return MenuReveal(
                    revealPercent: animation.value,
                    child: InkWell(
                      onTap: onTapMenuClose,
                      child: Container(
                        color: isDark ? const Color(0xB34D4D4D) : const Color(0x4D000000),
                        child: Theme( // 修改button默认的最小宽度与padding
                          data: Theme.of(context).copyWith(
                            buttonTheme: ButtonThemeData(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              minWidth: 56.0,
                              height: 56.0,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 距顶部距离为0
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                            textTheme: TextTheme(
                                button: TextStyle(
                                  fontSize: Dimens.font_sp16,
                                )
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Gaps.hGap15,
                              FlatButton(
                                key: Key('goods_edit_item_$index'),
                                textColor: isDark ?  Colours.dark_button_text : Colors.white,
                                color: isDark ?  Colours.dark_app_main : Colours.app_main,
                                child: const Text("编辑"),
                                onPressed: onTapEdit,
                              ),
                              FlatButton(
                                key: Key('goods_operation_item_$index'),
                                textColor: Colours.text,
                                color: buttonColor,
                                child: const Text("下架"),
                                onPressed: onTapOperation,
                              ),
                              FlatButton(
                                key: Key('goods_delete_item_$index'),
                                textColor: Colours.text,
                                color: buttonColor,
                                child: const Text("删除"),
                                onPressed: onTapDelete,
                              ),
                              Gaps.hGap15,
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        )
      ],
    );
  }
}
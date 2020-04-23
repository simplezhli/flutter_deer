
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/models/goods_item_entity.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/menu_reveal.dart';


/// design/4商品/index.html#artboard1
class GoodsItem extends StatelessWidget {
  
  const GoodsItem({
    Key key,
    @required this.item,
    @required this.index,
    @required this.selectIndex,
    @required this.onTapMenu,
    @required this.onTapEdit,
    @required this.onTapOperation,
    @required this.onTapDelete,
    @required this.onTapMenuClose,
    @required this.animation
  }): super(key: key);

  final GoodsItemEntity item;
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
                  ExcludeSemantics(child: LoadImage(item.icon, width: 72.0, height: 72.0)),
                  Gaps.hGap8,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          '八月十五中秋月饼礼盒',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis
                        ),
                        Gaps.vGap4,
                        Row(
                          children: <Widget>[
                            Visibility(
                              // 默认为占位替换，类似于gone
                              visible: item.type % 3 == 0,
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
                                  '立减',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimens.font_sp10
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              // 修改透明度实现隐藏，类似于invisible
                              opacity: item.type % 2 != 0 ? 0.0 : 1.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                height: 16.0,
                                alignment: Alignment.center,
                                child: const Text(
                                  '社区币抵扣',
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
                        Text(Utils.formatPrice('20.00', format: MoneyFormat.NORMAL))
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Semantics(
                        /// container属性为true，防止上方ExcludeSemantics去除此处语义
                        container: true,
                        label: '商品操作菜单',
                        child: GestureDetector(
                          child: Container(
                            key: Key('goods_menu_item_$index'),
                            width: 44.0,
                            height: 44.0,
                            color: Colors.transparent,
                            padding: const EdgeInsets.only(left: 28.0, bottom: 28.0),
                            child: const LoadAssetImage('goods/ellipsis')
                          ),
                          onTap: onTapMenu,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          '特产美味',
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
        selectIndex != index ? Gaps.empty : Positioned.fill(
          child: AnimatedBuilder(
              animation: animation,
              builder:(_, child) {
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
                              child: const Text('编辑'),
                              onPressed: onTapEdit,
                            ),
                            FlatButton(
                              key: Key('goods_operation_item_$index'),
                              textColor: Colours.text,
                              color: buttonColor,
                              child: const Text('下架'),
                              onPressed: onTapOperation,
                            ),
                            FlatButton(
                              key: Key('goods_delete_item_$index'),
                              textColor: Colours.text,
                              color: buttonColor,
                              child: const Text('删除'),
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
        )
      ],
    );
  }
}
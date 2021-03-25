
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/models/goods_item_entity.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/other_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';

import 'menu_reveal.dart';


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
  final VoidCallback onTapMenu;
  final VoidCallback onTapEdit;
  final VoidCallback onTapOperation;
  final VoidCallback onTapDelete;
  final VoidCallback onTapMenuClose;
  final Animation<double> animation;
  
  @override
  Widget build(BuildContext context) {
    final Row child = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ExcludeSemantics(child: LoadImage(item.icon, width: 72.0, height: 72.0)),
        Gaps.hGap8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.type % 3 != 0 ? '八月十五中秋月饼礼盒' : '八月十五中秋月饼礼盒八月十五中秋月饼礼盒',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Gaps.vGap4,
              Row(
                children: <Widget>[
                  Visibility(
                    // 默认为占位替换，类似于gone
                    visible: item.type % 3 == 0,
                    child: _GoodsItemTag(
                      text: '立减',
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                  Opacity(
                    // 修改透明度实现隐藏，类似于invisible
                    opacity: item.type % 2 != 0 ? 0.0 : 1.0,
                    child: _GoodsItemTag(
                      text: '金币抵扣',
                      color: Theme.of(context).primaryColor,
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
                  child: const LoadAssetImage('goods/ellipsis'),
                ),
                onTap: onTapMenu,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '特产美味',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            )
          ],
        )
      ],
    );
    
    return Stack(
      children: <Widget>[
        // item间的分隔线
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: Divider.createBorderSide(context, width: 0.8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: child,
            ),
          ),
        ),
        if (selectIndex != index) Gaps.empty else _buildGoodsMenu(context),
      ],
    );
  }
  
  Widget _buildGoodsMenu(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: animation,
        child: _buildGoodsMenuContent(context),
        builder:(_, Widget child) {
          return MenuReveal(
            revealPercent: animation.value,
            child: child
          );
        }
      ),
    );
  }

  Widget _buildGoodsMenuContent(BuildContext context) {
    final bool isDark = context.isDark;
    final Color buttonColor = isDark ? Colours.dark_text : Colors.white;

    return InkWell(
      onTap: onTapMenuClose,
      child: Container(
        color: isDark ? const Color(0xB34D4D4D) : const Color(0x4D000000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Gaps.hGap15,
            MyButton(
              key: Key('goods_edit_item_$index'),
              text: '编辑',
              fontSize: Dimens.font_sp16,
              radius: 24.0,
              minWidth: 56.0,
              minHeight: 56.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              textColor: isDark ? Colours.dark_button_text : Colors.white,
              backgroundColor: isDark ? Colours.dark_app_main : Colours.app_main,
              onPressed: onTapEdit,
            ),
            MyButton(
              key: Key('goods_operation_item_$index'),
              text: '下架',
              fontSize: Dimens.font_sp16,
              radius: 24.0,
              minWidth: 56.0,
              minHeight: 56.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              textColor: Colours.text,
              backgroundColor: buttonColor,
              onPressed: onTapOperation,
            ),
            MyButton(
              key: Key('goods_delete_item_$index'),
              text: '删除',
              fontSize: Dimens.font_sp16,
              radius: 24.0,
              minWidth: 56.0,
              minHeight: 56.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              textColor: Colours.text,
              backgroundColor: buttonColor,
              onPressed: onTapDelete,
            ),
            Gaps.hGap15,
          ],
        ),
      ),
    );
  }
}

class _GoodsItemTag extends StatelessWidget {
  
  const _GoodsItemTag({
    Key key,
    this.color,
    this.text,
  }): super(key: key);

  final Color color;
  final String text;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
      ),
      height: 16.0,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: Dimens.font_sp10,
          height: 1.1,
        ),
      ),
    );
  }
}

import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/goods/goods_router.dart';

class GoodsAddMenu extends StatefulWidget {

  const GoodsAddMenu({
    Key? key,
  }): super(key: key);

  @override
  _GoodsAddMenuState createState() => _GoodsAddMenuState();
}

class _GoodsAddMenuState extends State<GoodsAddMenu> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = context.backgroundColor;
    final Color? iconColor = ThemeUtils.getIconColor(context);

    final Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: LoadAssetImage('goods/jt', width: 8.0, height: 4.0,
            color: ThemeUtils.getDarkColor(context, Colours.dark_bg_color),
          ),
        ),
        SizedBox(
          width: 120.0,
          height: 40.0,
          child: TextButton.icon(
            onPressed: () {
              NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=true&isScan=true', replace: true);
            },
            icon: LoadAssetImage('goods/scanning', width: 16.0, height: 16.0, color: iconColor,),
            label: const Text('扫码添加'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).textTheme.bodyText2?.color,
              onSurface: Theme.of(context).textTheme.bodyText2?.color?.withOpacity(0.12),
              backgroundColor: backgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
              ),
            ),
          ),
        ),
        Container(width: 120.0, height: 0.6, color: Colours.line),
        SizedBox(
          width: 120.0,
          height: 40.0,
          child: TextButton.icon(
            onPressed: () {
              NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=true', replace: true);
            },
            icon: LoadAssetImage('goods/add2', width: 16.0, height: 16.0, color: iconColor,),
            label: const Text('添加商品'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).textTheme.bodyText2?.color,
              onSurface: Theme.of(context).textTheme.bodyText2?.color?.withOpacity(0.12),
              backgroundColor: backgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      ],
    );

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (_, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          alignment: Alignment.topRight,
          child: child,
        );
      },
      child: body,
    );
  }


}


import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';

class GoodsSortMenu extends StatefulWidget {

  const GoodsSortMenu({
    Key? key,
    required this.data,
    required this.sortIndex,
    required this.height,
    required this.onSelected,
  }): super(key: key);

  final List<String> data;
  final int sortIndex;
  final double height;
  final Function(int, String) onSelected;

  @override
  _GoodsSortMenuState createState() => _GoodsSortMenuState();
}

class _GoodsSortMenuState extends State<GoodsSortMenu> with SingleTickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCubic,
    reverseCurve: Curves.easeOutCubic,
  );

  @override
  void initState() {
    super.initState();
    _animation.addStatusListener(_statusListener);
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      /// 菜单动画停止，关闭菜单。
      NavigatorUtils.goBack(context);
    }
  }

  @override
  void dispose() {
    _animation.removeStatusListener(_statusListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = context.backgroundColor;

    final Widget listView = ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: widget.data.length + 1,
      itemBuilder: (_, int index) {
        return index == widget.data.length ? Container(
          color: backgroundColor,
          height: 12.0,
        ) : _buildItem(index, backgroundColor);
      },
    );

    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: const Color(0x99000000),
        height: widget.height - 12.0,
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.topCenter,
          child: listView,
        ),
      ),
    );
  }

  Widget _buildItem(int index, Color backgroundColor) {
    final TextStyle textStyle = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Theme.of(context).primaryColor,
    );
    return Material(
      color: backgroundColor,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.data[index],
                style: index == widget.sortIndex ? textStyle : null,
              ),
              Text(
                '($index)',
                style: index == widget.sortIndex ? textStyle : null,
              ),
            ],
          ),
        ),
        onTap: () {
          widget.onSelected(index, widget.data[index]);
          _controller.reverse();
        },
      ),
    );
  }
}

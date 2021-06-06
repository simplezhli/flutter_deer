
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {

  const MyBottomNavigationBar({
    Key? key,
    this.selectedPosition = 0,
    this.isShowIndicator = true,
    required this.selectedCallback,
  }) : super(key: key);

  /// 选中下标
  final int selectedPosition;
  final bool isShowIndicator;
  final Function(int selectedPosition) selectedCallback;
  
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> with TickerProviderStateMixin {
  
  /// BottomNavigationBar高度
  double barHeight = 56.0;
  /// 指示器高度
  double indicatorHeight = 44.0;
  /// 选中图标颜色
  Color selectedIconColor = Colors.blue;
  /// 默认图标颜色
  Color normalIconColor = Colors.grey;
  /// 选中下标
  int selectedPosition = 0;
  /// 记录上一次的选中下标
  int previousSelectedPosition = 0;
  /// 选中图标高度
  double selectedIconHeight = 38.0;
  /// 默认图标高度
  double normalIconHeight = 32.0;
  /// 图标
  List<IconData> iconList = [Icons.image, Icons.add, Icons.access_alarms, Icons.settings];

  double itemWidth = 0;

  late AnimationController controller;
  late Animation<double> animation;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      itemWidth = (context.size!.width - barHeight) / 3;
      setState(() {});
    });
    
    /// 设置动画时长
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 333));
    
    if (widget.isShowIndicator) {
      selectedPosition = widget.selectedPosition;
      previousSelectedPosition = widget.selectedPosition;
    }
    animation = Tween(begin: selectedPosition.toDouble(), end: selectedPosition.toDouble())
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    
    /// 背景
    final background = Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(barHeight / 2),
        boxShadow: const [
          BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 4.0, spreadRadius: 0.0),
        ],
      ),
    );

    children.add(background);

    if (itemWidth == 0) {
      return Stack(children: children,);
    }
    
    if (widget.isShowIndicator) {
      /// 指示器
      children.add(Positioned(
        child: Container(
          width: indicatorHeight,
          height: indicatorHeight,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset.zero, blurRadius: 1.0, spreadRadius: 0.0),
            ],
          ),
        ),
        left: 6.0 + animation.value * itemWidth,
        top: (barHeight - indicatorHeight) / 2,
      ));
    }

    for (var i = 0; i < iconList.length; i++) {
      /// 图标中心点计算
      final rect = Rect.fromCenter(
        center: Offset(28.0 + (i * itemWidth), 28.0),
        width: (i == selectedPosition && widget.isShowIndicator) ? selectedIconHeight : normalIconHeight,
        height: (i == selectedPosition && widget.isShowIndicator) ? selectedIconHeight : normalIconHeight,
      );

      children.add(Positioned.fromRect(
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (i == selectedPosition && widget.isShowIndicator) ? selectedIconColor : normalIconColor,
            ),
            child: Icon(iconList[i], color: Colors.white,),
          ),
          onTap: () {
            _selectedPosition(i);
          },
        ),
        rect: rect,
      ));
    }
    
    return Stack(children: children,);
  }

  void _selectedPosition(int position) {
    if (!widget.isShowIndicator) {
      previousSelectedPosition = position;
    } else {
      previousSelectedPosition = selectedPosition;
    }
    selectedPosition = position;
    /// 执行动画
    animation = Tween(begin: previousSelectedPosition.toDouble(), end: selectedPosition.toDouble())
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    animation.addListener(() {
      setState(() {});
    });
    controller.forward(from: 0.0);
    
    if (widget.selectedCallback != null) {
      widget.selectedCallback(selectedPosition);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

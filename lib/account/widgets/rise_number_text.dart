
import 'package:flutter/material.dart';

// 简易实现数字滚动效果
class RiseNumberText extends StatefulWidget {

  const RiseNumberText(this.number,{
    Key key,
    this.style,
    this.duration: 1200
  }): super(key: key);

  final num number;
  final TextStyle style;
  final int duration;

  @override
  _RiseNumberTextState createState() => _RiseNumberTextState();
}

class _RiseNumberTextState extends State<RiseNumberText> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;
  num fromNumber = 0;
  
  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Duration(milliseconds: widget.duration), vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween<double>(begin: 0, end: 1).animate(curve);
    controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(RiseNumberText oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 数据变化时执行动画
    if (oldWidget.number != widget.number){
      fromNumber = oldWidget.number;
      controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __){
        // 数字默认从0增长。数据变化时，由之前数字为基础变化。
        return Text(
          (fromNumber + (animation.value * (widget.number - fromNumber))).toStringAsFixed(2).toString(),
          style: widget.style,
        );
      },
    );
  }
}



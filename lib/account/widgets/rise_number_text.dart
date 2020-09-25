
import 'package:flutter/material.dart';

// 简易实现数字滚动效果
class RiseNumberText extends StatefulWidget {

  const RiseNumberText(this.number,{
    Key key,
    this.style,
    this.duration = 1200
  }): super(key: key);

  final num number;
  final TextStyle style;
  final int duration;

  @override
  _RiseNumberTextState createState() => _RiseNumberTextState();
}

class _RiseNumberTextState extends State<RiseNumberText> with SingleTickerProviderStateMixin {

  Animation<double> _animation;
  AnimationController _controller;
  num _fromNumber = 0;
  
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Duration(milliseconds: widget.duration), vsync: this);
    final curve = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _animation = Tween<double>(begin: 0, end: 1).animate(curve);
    _controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(RiseNumberText oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 数据变化时执行动画
    if (oldWidget.number != widget.number) {
      _fromNumber = oldWidget.number;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        // 数字默认从0增长。数据变化时，由之前数字为基础变化。
        return Text(
          (_fromNumber + (_animation.value * (widget.number - _fromNumber))).toStringAsFixed(2).toString(),
          style: widget.style,
        );
      },
    );
  }
}



import 'dart:math';

import 'package:flutter/material.dart';


//https://github.com/alibaba/flutter-go/blob/master/lib/views/fourth_page/page_reveal.dart
class MenuReveal extends StatelessWidget {

  final double revealPercent;
  final Widget child;

  MenuReveal({
    this.revealPercent,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: new CircleRevealClipper(revealPercent),
      child: child,
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect>{

  final double revealPercent;


  CircleRevealClipper(this.revealPercent);

  @override
  Rect getClip(Size size) {

    // 右上角的点击点为圆心
    final epicenter = new Offset(size.width - 25.0, 25.0);

    double theta = atan(epicenter.dy / epicenter.dx);
    final distanceToCorner = (epicenter.dy) / sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;

    return new Rect.fromLTWH(epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}
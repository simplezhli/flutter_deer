import 'dart:math';

import 'package:flutter/material.dart';


//https://github.com/alibaba/flutter-go/blob/master/lib/views/fourth_page/page_reveal.dart
class MenuReveal extends StatelessWidget {

  const MenuReveal({
    Key? key,
    required this.revealPercent,
    required this.child
  }): super(key: key);

  final double revealPercent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircleRevealClipper(revealPercent),
      child: child,
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {

  CircleRevealClipper(this.revealPercent);

  final double revealPercent;

  @override
  Rect getClip(Size size) {

    // 右上角的点击点为圆心
    final Offset epicenter = Offset(size.width - 25.0, 25.0);

    final double theta = atan(epicenter.dy / epicenter.dx);
    final double distanceToCorner = (epicenter.dy) / sin(theta);

    final double radius = distanceToCorner * revealPercent;
    final double diameter = 2 * radius;

    return Rect.fromLTWH(epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}
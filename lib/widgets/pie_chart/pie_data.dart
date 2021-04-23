import 'package:flutter/material.dart';

class PieData {
  /// 颜色
  late Color color;
  /// 百分比
  late num percentage;
  /// 数量
  late int number;
  /// 名称
  late String name;
  
  @override
  String toString() => 'name: $name, color: $color, '
      'number: $number, percentage: $percentage';
}
import 'package:flutter/material.dart';

class PieData{
  /// 颜色
  Color color;
  /// 百分比
  num percentage;
  /// 数量
  int number;
  /// 名称
  String name;
  
  @override
  String toString() => 'name: $name, color: $color, '
      'number: $number, percentage: $percentage';
}
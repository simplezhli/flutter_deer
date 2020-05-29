import 'package:flutter/material.dart';

typedef MissingValueBuilder = double Function(DateTime value);

///This Bezier line is used to display your data
class BezierLine {
  final Color lineColor;

  ///`width` of the bezier line
  final double lineStrokeWidth;

  ///List of data points used to build the bezier line
  final List<DataPoint> data;

  ///This builder is only valid for `bezierChartScale` of date types
  ///It uses the double value returned by the function based on the current `DateTime` received as parameter
  final MissingValueBuilder onMissingValue;

  ///Label used in the bubble info indicator
  final String label;

  const BezierLine({
    this.lineColor = Colors.white,
    this.lineStrokeWidth = 2.0,
    this.label = '',
    this.onMissingValue,
    this.data,
  });

  factory BezierLine.copy({BezierLine bezierLine}) {
    return BezierLine(
      lineColor: bezierLine.lineColor,
      lineStrokeWidth: bezierLine.lineStrokeWidth,
      label: bezierLine.label,
      onMissingValue: bezierLine.onMissingValue,
      data: bezierLine.data,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BezierLine &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          lineColor == other.lineColor &&
          lineStrokeWidth == other.lineStrokeWidth &&
          hashCode == other.hashCode;

  @override
  int get hashCode => data
      .map((val) => val.value?.toString() ?? '')
      .reduce((val1, val2) => '$val1$val2')
      .hashCode;
}

///This class represent each value `Y` per `X` axis
class DataPoint<T> {
  ///The value `Y`
  final double value;

  ///The `X` Axis value, it supports `double` and `DateTime` for now
  final T xAxis;

  const DataPoint({
    this.value,
    this.xAxis,
  });

  String toString() => 'value: $value, xAxis: $xAxis';
}

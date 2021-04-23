import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Type of Bezier line Chart
enum BezierChartScale {
  HOURLY,
  WEEKLY,
  MONTHLY,
  YEARLY,

  ///numbers sorted in an increasing way.
  CUSTOM,
}

enum BezierChartAggregation {
  AVERAGE,
  SUM,
  FIRST,
  COUNT,
  MAX,
  MIN,
}

///`BezierChartConfig` allows the customization of the `BezierChart` widget
class BezierChartConfig {
  ///`true` if you want to display the vertical indicator
  final bool showVerticalIndicator;
  final Color verticalIndicatorColor;

  ///`width` of the line used for the vertical indicator
  final double verticalIndicatorStrokeWidth;

  ///`true` if you want to keep the info indicator in a fixed position
  final bool verticalIndicatorFixedPosition;

  ///`true` if you want to display the vertical line in full height
  final bool verticalLineFullHeight;

  ///Color of the bubble indicator, it's white by default
  final Color bubbleIndicatorColor;

  ///TextStyle for the title displayed inside the bubble indicator
  final TextStyle bubbleIndicatorTitleStyle;

  ///TextStyle for the value displayed inside the bubble indicator
  final TextStyle bubbleIndicatorValueStyle;

  ///NumberFormat for the value displayed inside the bubble indicator
  final NumberFormat? bubbleIndicatorValueFormat;

  ///TextStyle for the label displayed inside the bubble indicator
  final TextStyle bubbleIndicatorLabelStyle;

  ///Color of the background of the chart
  final Color backgroundColor;

  ///Gradient of the background of the chart
  final LinearGradient? backgroundGradient;

  ///`true` if you want to display the value of the Y axis, [false] by default
  final bool displayYAxis;

  ///If [displayYAxis] is true, then you can set a positive value to display the steps of Y axis values
  ///e.g 1: stepsYAxis : 5 ,  if your maxValue is 100, then the Y values should be: [0,5,10,15 .... 100]
  ///e.g 2: stepsYAxis : 10 , if your maxValue is 100, then the Y values should be: [10,20,30,40 .... 100]
  final int? stepsYAxis;

  ///`true` if you want to start the values of Y axis from the minimum value of your Y values.
  final bool startYAxisFromNonZeroValue;

  ///TextStyle of the text of the Y Axis values
  final TextStyle? yAxisTextStyle;

  ///TextStyle of the text of the X Axis values
  final TextStyle? xAxisTextStyle;

  ///Height of the footer
  final double footerHeight;

  ///`true` if you want to display the data points
  final bool showDataPoints;

  ///`true` if you want to snap between each data point
  final bool snap;

  ///`true` if you want to enable pinch Zoom for `bezierChartScale` of date types
  /// Pinch and zoom is used to switch beetwen charts of date types
  final bool pinchZoom;

  ///If the `contentWidth` is upper than the current width then the content will be scrollable (only valid for `bezierChartScale` = `CUSTOM`)
  final double? contentWidth;

  ///`true` if you want to display a vertical line on each X data point, it only works when there is one `BezierLine`.
  final bool displayLinesXAxis;

  ///Color for the vertical line in each X point, only works when `displayLinesXAxis` is true
  final Color xLinesColor;

  ///`true` if you want do display the dot when there is no value specified (The values inside `onMissingValue`)
  final bool displayDataPointWhenNoValue;

  ///The physics for horizontal ScrollView
  final ScrollPhysics physics;

  ///`true` if you want do update bubble info on tap action instead of long press. This option will disable tap to hide bubble action
  final bool updatePositionOnTap;

  BezierChartConfig({
    this.verticalIndicatorStrokeWidth = 2.0,
    this.verticalIndicatorColor = Colors.black,
    this.showVerticalIndicator = true,
    this.showDataPoints = true,
    this.displayYAxis = false,
    this.snap = true,
    this.backgroundColor = Colors.transparent,
    this.xAxisTextStyle,
    this.yAxisTextStyle,
    this.footerHeight = 35.0,
    this.contentWidth,
    this.pinchZoom = true,
    this.bubbleIndicatorColor = Colors.white,
    this.backgroundGradient,
    this.verticalIndicatorFixedPosition = false,
    this.startYAxisFromNonZeroValue = true,
    this.displayLinesXAxis = false,
    this.stepsYAxis,
    this.xLinesColor = Colors.grey,
    this.displayDataPointWhenNoValue = true,
    this.bubbleIndicatorLabelStyle = const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w700,
      fontSize: 9,
    ),
    this.bubbleIndicatorTitleStyle = const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w600,
      fontSize: 9.5,
    ),
    this.bubbleIndicatorValueStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 11,
    ),
    this.bubbleIndicatorValueFormat,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.updatePositionOnTap = false,
    bool? verticalLineFullHeight,
  }) : this.verticalLineFullHeight =
      verticalLineFullHeight ?? verticalIndicatorFixedPosition;
}
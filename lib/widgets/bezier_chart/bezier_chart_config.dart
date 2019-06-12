import 'package:flutter/material.dart';

/// Type of Bezier line Chart
enum BezierChartScale {
  WEEKLY,
  MONTHLY,
  YEARLY,

  ///numbers sorted in an increasing way.
  CUSTOM,
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

  ///Color of the bubble indicator, it's white by default
  final Color bubbleIndicatorColor;

  ///Color of the background of the chart
  final Color backgroundColor;

  ///Gradient of the background of the chart
  final LinearGradient backgroundGradient;

  ///Color of the text of the footer
  final Color footerColor;

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
  final double contentWidth;

  BezierChartConfig({
    this.verticalIndicatorStrokeWidth = 2.0,
    this.verticalIndicatorColor = Colors.black,
    this.showVerticalIndicator = true,
    this.showDataPoints = true,
    this.snap = true,
    this.backgroundColor = Colors.transparent,
    this.footerColor = Colors.white,
    this.footerHeight = 35.0,
    this.contentWidth,
    this.pinchZoom = true,
    this.bubbleIndicatorColor = Colors.white,
    this.backgroundGradient,
    this.verticalIndicatorFixedPosition = true,
  });
}

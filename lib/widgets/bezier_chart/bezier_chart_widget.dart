import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bezier_line.dart';
import 'bezier_chart_config.dart';
import 'package:intl/intl.dart' as intl;

import 'my_single_child_scroll_view.dart';

typedef FooterValueBuilder = String Function(double value);
typedef FooterDateTimeBuilder = String Function(
    DateTime value, BezierChartScale scaleType);

class BezierChart extends StatefulWidget {
  ///Chart configuration
  final BezierChartConfig config;

  ///Type of Chart
  final BezierChartScale bezierChartScale;

  ///Aggregation of Chart
  final BezierChartAggregation bezierChartAggregation;

  ///This value is required only if the `BezierChartScale` is `BezierChartScale.CUSTOM`
  ///and these values must be sorted in increasing way (These will be showed in the Axis X).
  final List<double> xAxisCustomValues;

  ///[Optional] This callback only works if the `BezierChartScale` is `BezierChartScale.CUSTOM` otherwise it will be ignored
  ///This is used to display a custom footer value based on the current 'x' value
  final FooterValueBuilder? footerValueBuilder;

  ///[Optional] This callback only works if the `BezierChartScale` is `BezierChartScale.CUSTOM` otherwise it will be ignored
  ///This is used to display a custom bubble label value based on the current 'x' value
  final FooterValueBuilder? bubbleLabelValueBuilder;

  ///[Optional] This callback only works if the `BezierChartScale` is Date type otherwise it will be ignored
  ///This is used to display a custom footer value based on the current 'x' value
  final FooterDateTimeBuilder? footerDateTimeBuilder;

  ///[Optional] This callback only works if the `BezierChartScale` is Date type otherwise it will be ignored
  ///This is used to display a custom bubble label value based on the current 'x' value
  final FooterDateTimeBuilder? bubbleLabelDateTimeBuilder;

  ///[Optional] This callback notify when the display indicator is visible or not
  final ValueChanged<bool>? onIndicatorVisible;

  ///[Optional] This callback will display the current `double` value selected by the indicator
  ///Only works when the `BezierChartScale` is not `BezierChartScale.CUSTOM`
  final ValueChanged<double>? onValueSelected;

  ///[Optional] This callback will display the current `DateTime` selected by the indicator
  ///Only works when the `BezierChartScale` is date type
  final ValueChanged<DateTime>? onDateTimeSelected;

  ///This value is required only if the `BezierChartScale` is not `BezierChartScale.CUSTOM`
  final DateTime? fromDate;

  ///This value is required only if the `BezierChartScale` is not `BezierChartScale.CUSTOM`
  final DateTime? toDate;

  ///This value represents the date selected to display the info in the Chart
  ///For `BezierChartScale.HOURLY` it will use year, month, day and hour
  ///For `BezierChartScale.WEEKLY` it will use year, month and day
  ///For `BezierChartScale.MONTHLY` it will use year, month
  ///For `BezierChartScale.YEARLY` it will use year
  final DateTime? selectedDate;

  ///This value represents the value selected to display the info in the Chart
  ///It's only for `BezierChartScale.CUSTOM`
  final double? selectedValue;

  ///Beziers used in the Axis Y
  final List<BezierLine> series;

  ///Notify if the `BezierChartScale` changed, it only works with date scales.
  final ValueChanged<BezierChartScale>? onScaleChanged;

  BezierChart({
    Key? key,
    required this.config,
    required this.xAxisCustomValues,
    this.footerValueBuilder,
    this.bubbleLabelValueBuilder,
    this.footerDateTimeBuilder,
    this.bubbleLabelDateTimeBuilder,
    this.fromDate,
    this.toDate,
    this.selectedDate,
    this.onIndicatorVisible,
    this.onDateTimeSelected,
    this.onValueSelected,
    this.selectedValue,
    this.bezierChartAggregation = BezierChartAggregation.SUM,
    required this.bezierChartScale,
    required this.series,
    this.onScaleChanged,
  })  : assert(
  (bezierChartScale == BezierChartScale.CUSTOM &&
      xAxisCustomValues != null &&
      series != null) ||
      bezierChartScale != BezierChartScale.CUSTOM,
  'The xAxisCustomValues and series must not be null',
  ),
        assert(
        bezierChartScale == BezierChartScale.CUSTOM &&
            _isSorted(xAxisCustomValues) ||
            bezierChartScale != BezierChartScale.CUSTOM,
        'The xAxisCustomValues must be sorted in increasing way',
        ),
        assert(
        bezierChartScale == BezierChartScale.CUSTOM &&
            _compareLengths(xAxisCustomValues.length, series) ||
            bezierChartScale != BezierChartScale.CUSTOM,
        'xAxisCustomValues lenght must be equals to series length',
        ),
        assert(
        (bezierChartScale == BezierChartScale.CUSTOM &&
            _areAllPositive(xAxisCustomValues) &&
            _checkCustomValues(series)) ||
            bezierChartScale != BezierChartScale.CUSTOM,
        'xAxisCustomValues and series must be positives',
        ),
        assert(
        (((bezierChartScale != BezierChartScale.CUSTOM) &&
            fromDate != null &&
            toDate != null) ||
            (bezierChartScale == BezierChartScale.CUSTOM &&
                fromDate == null &&
                toDate == null)),
        'fromDate and toDate must not be null',
        ),
        assert(
        (((bezierChartScale != BezierChartScale.CUSTOM) &&
            toDate!.isAfter(fromDate!)) ||
            (bezierChartScale == BezierChartScale.CUSTOM &&
                fromDate == null &&
                toDate == null)),
        'toDate must be after of fromDate',
        ),
        super(key: key);

  @override
  BezierChartState createState() => BezierChartState();
}

@visibleForTesting
class BezierChartState extends State<BezierChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;
  GlobalKey _keyScroll = GlobalKey();

  ///Track the current position when dragging the indicator
  Offset? _verticalIndicatorPosition;
  bool _displayIndicator = false;

  ///padding for leading and trailing of the chart
  // TODO(weilu): 修改处 horizontalPadding = 50.0;
  final double horizontalPadding = 11.0;

  ///spacing between each datapoint
  double horizontalSpacing = 60.0;

  ///List of `DataPoint`s used to display all the values for the `X` axis
  List<DataPoint> _xAxisDataPoints = [];

  ///List of `BezierLine`s used to display all lines, each line contains a list of `DataPoint`s
  List<BezierLine> computedSeries = [];

  ///Current scale when use pinch/zoom
  double _currentScale = 1.0;

  ///This value allow us to get the last scale used when start the pinch/zoom again
  late double _previousScale;

  ///The current chart scale
  late BezierChartScale _currentBezierChartScale;

  double _lastValueSnapped = double.infinity;
  bool get isPinchZoomActive => (_touchFingers > 1 && widget.config.pinchZoom);

  ///When we only have 1 axis we don't need to much span to change the date type chart`
  bool get isOnlyOneAxis => _xAxisDataPoints.length <= 1;

  double _contentWidth = 0.0;
  bool _isScrollable = false;

  ///Calculate all of the values related to the Y axis
  late List<double> _yValues;

  ///Values from valueBuilder
  late List<double> _tempYValues;

  DateTime? _dateTimeSelected;
  double? _valueSelected;
  GlobalKey _keyLastYAxisItem = GlobalKey();
  double _yAxisWidth = 0.0;

  ///Refresh the position of the vertical/bubble
  void _refreshPosition(details) {
    if (_animationController.status == AnimationStatus.completed &&
        _displayIndicator) {
      return _updatePosition(details.globalPosition);
    }
  }

  ///Update and refresh the position based on the current screen
  void _updatePosition(Offset globalPosition) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.globalToLocal(globalPosition);
    if (position == null) return;
    return setState(
          () {
        final fixedPosition = Offset(
            position.dx + _scrollController.offset - horizontalPadding,
            position.dy);
        _verticalIndicatorPosition = fixedPosition;
      },
    );
  }

  ///After long press this method is called to display the bubble indicator if is not visible
  ///An animation and snap sound are triggered
  _onDisplayIndicator(details, {bool updatePosition = true}) {
    if (!_displayIndicator) {
      _displayIndicator = true;
      _animationController.forward(
        from: 0.0,
      );
      if (widget.onIndicatorVisible != null) {
        widget.onIndicatorVisible!(true);
      }
    }
    _onDataPointSnap(double.maxFinite);
    if (updatePosition) _updatePosition(details.globalPosition);
  }

  ///Hide the vertical/bubble indicator and refresh the widget
  _onHideIndicator() {
    if (_displayIndicator) {
      if (widget.onIndicatorVisible != null) {
        widget.onIndicatorVisible!(false);
      }
      _animationController.reverse(from: 1.0).whenCompleteOrCancel(
            () {
          setState(
                () {
              _displayIndicator = false;
            },
          );
        },
      );
    }
  }

  ///When the current indicator reach any data point a feedback is triggered
  void _onDataPointSnap(double value) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (_lastValueSnapped != value && widget.config.snap) {
      if (isIOS) {
        HapticFeedback.heavyImpact();
      } else {
        Feedback.forTap(context);
      }
      _lastValueSnapped = value;
    }
  }

  _checkMissingValues(DateTime newDate) {
    for (BezierLine line in widget.series) {
      if (line.onMissingValue != null) {
        final newValue = line.onMissingValue!(newDate);
        if (!_tempYValues.contains(newValue)) _tempYValues.add(newValue);
        //if there is no missingvalue specified we should use 0 as minimum value to avoid overlap
      } else if (widget.config.startYAxisFromNonZeroValue &&
          line.onMissingValue == null) {
        if (!_tempYValues.contains(0)) _tempYValues.add(0);
      }
    }
  }

  ///Building the data points for the `X` axis based on the `_currentBezierChartScale`
  void _buildXDataPoints() {
    _xAxisDataPoints = [];
    _tempYValues = [];
    final scale = _currentBezierChartScale;
    if (scale == BezierChartScale.CUSTOM) {
      _xAxisDataPoints = widget.xAxisCustomValues
          .map((val) => DataPoint<double>(value: val, xAxis: val))
          .toList();
    } else if (scale == BezierChartScale.HOURLY) {
      final hours = widget.toDate!.difference(widget.fromDate!).inHours;
      for (int i = 0; i < hours; i++) {
        final tempDate = widget.fromDate!.add(
          Duration(
            hours: (i + 1),
          ),
        );
        final newDate = DateTime(
            tempDate.year, tempDate.month, tempDate.day, tempDate.hour, 0);
        _xAxisDataPoints.add(
          DataPoint<DateTime>(value: (i * 5).toDouble(), xAxis: newDate),
        );
        _checkMissingValues(newDate);
      }
    } else if (scale == BezierChartScale.WEEKLY) {
      final days = _convertToDateOnly(widget.toDate!)
          .difference(_convertToDateOnly(widget.fromDate!))
          .inDays;
      for (int i = 0; i <= days; i++) {
        final newDate = widget.fromDate!.add(
          Duration(
            days: (i),
          ),
        );
        _xAxisDataPoints.add(
          DataPoint<DateTime>(value: (i * 5).toDouble(), xAxis: newDate),
        );
        _checkMissingValues(newDate);
      }
    } else if (scale == BezierChartScale.MONTHLY) {
      DateTime startDate = DateTime(
        widget.fromDate!.year,
        widget.fromDate!.month,
      );
      DateTime endDate = DateTime(
        widget.toDate!.year,
        widget.toDate!.month,
      );
      for (int i = 0;
      (startDate.isBefore(endDate) || areEqualDates(startDate, endDate));
      i++) {
        _xAxisDataPoints.add(
          DataPoint<DateTime>(value: (i * 5).toDouble(), xAxis: startDate),
        );
        _checkMissingValues(startDate);
        startDate = DateTime(startDate.year, startDate.month + 1);
      }
    } else if (scale == BezierChartScale.YEARLY) {
      DateTime startDate = DateTime(
        widget.fromDate!.year,
      );
      DateTime endDate = DateTime(
        widget.toDate!.year,
      );
      for (int i = 0;
      (startDate.isBefore(endDate) || areEqualDates(startDate, endDate));
      i++) {
        _xAxisDataPoints.add(
          DataPoint<DateTime>(value: (i * 5).toDouble(), xAxis: startDate),
        );
        _checkMissingValues(startDate);
        startDate = DateTime(
          startDate.year + 1,
        );
      }
    }
  }

  DateTime _convertToDateOnly(DateTime date) {
    int year = date.year;
    int month = date.month;
    int day = date.day;
    return DateTime(year, month, day);
  }

  ///Calculating the size of the content based on the parent constraints and on the `_currentBezierChartScale`
  double _buildContentWidth(BoxConstraints constraints) {
    final scale = _currentBezierChartScale;
    if (scale == BezierChartScale.CUSTOM) {
      return widget.config.contentWidth ??
          constraints.maxWidth - 2 * horizontalPadding;
    } else {
      if (scale == BezierChartScale.HOURLY) {
        horizontalSpacing = constraints.maxWidth / 7;
        return _xAxisDataPoints.length * (horizontalSpacing * _currentScale) -
            horizontalPadding / 2;
      } else if (scale == BezierChartScale.WEEKLY) {
        horizontalSpacing = constraints.maxWidth / 7;
        return _xAxisDataPoints.length * (horizontalSpacing * _currentScale) -
            horizontalPadding / 2;
      } else if (scale == BezierChartScale.MONTHLY) {
        horizontalSpacing = constraints.maxWidth / 12;
        return _xAxisDataPoints.length * (horizontalSpacing * _currentScale) -
            horizontalPadding / 2;
      } else if (scale == BezierChartScale.YEARLY) {
        if (_xAxisDataPoints.length > 12) {
          horizontalSpacing = constraints.maxWidth / 12;
        } else if (_xAxisDataPoints.length < 6) {
          horizontalSpacing = constraints.maxWidth / 6;
        } else {
          horizontalSpacing = constraints.maxWidth / _xAxisDataPoints.length;
        }
        return _xAxisDataPoints.length * (horizontalSpacing * _currentScale) -
            horizontalPadding;
      }
      return 0.0;
    }
  }

  ///When the widget finish rendering for the first time
  _onLayoutDone(_) {
    _yAxisWidth = _keyLastYAxisItem.currentContext?.size?.width ?? 0;
    //Move to selected position
    if ((widget.selectedDate != null &&
        _currentBezierChartScale != BezierChartScale.CUSTOM) ||
        (widget.selectedValue != null &&
            _currentBezierChartScale == BezierChartScale.CUSTOM)) {
      int index = -1;
      if (_currentBezierChartScale == BezierChartScale.WEEKLY) {
        index = _xAxisDataPoints.indexWhere(
                (dp) => areEqualDates((dp.xAxis as DateTime), widget.selectedDate!));
      } else if (_currentBezierChartScale == BezierChartScale.HOURLY) {
        index = _xAxisDataPoints.indexWhere((dp) =>
        (dp.xAxis as DateTime).year == widget.selectedDate!.year &&
            (dp.xAxis as DateTime).month == widget.selectedDate!.month &&
            (dp.xAxis as DateTime).day == widget.selectedDate!.day &&
            (dp.xAxis as DateTime).hour == widget.selectedDate!.hour);
      } else if (_currentBezierChartScale == BezierChartScale.MONTHLY) {
        index = _xAxisDataPoints.indexWhere((dp) =>
        (dp.xAxis as DateTime).year == widget.selectedDate!.year &&
            (dp.xAxis as DateTime).month == widget.selectedDate!.month);
      } else if (_currentBezierChartScale == BezierChartScale.YEARLY) {
        index = _xAxisDataPoints.indexWhere(
                (dp) => (dp.xAxis as DateTime).year == widget.selectedDate!.year);
      } else if (_currentBezierChartScale == BezierChartScale.CUSTOM) {
        index = _xAxisDataPoints
            .indexWhere((dp) => (dp.xAxis as double) == widget.selectedValue);
      }

      //If it's a valid index then scroll to the date selected based on the current position
      if (index >= 0) {
        Offset fixedPosition;
        if (_currentBezierChartScale == BezierChartScale.CUSTOM) {
          final space = (_contentWidth / _xAxisDataPoints.length);
          fixedPosition =
              Offset(isOnlyOneAxis ? 0.0 : (index * space) + space / 2, 0.0);
          _scrollController.jumpTo((index * space));
          setState(
                () {
              _verticalIndicatorPosition = fixedPosition;
              _onDisplayIndicator(
                LongPressMoveUpdateDetails(
                  globalPosition: fixedPosition,
                  offsetFromOrigin: fixedPosition,
                ),
                updatePosition: false,
              );
            },
          );
        } else {
          final jumpToX = (index * horizontalSpacing) -
              horizontalPadding / 2 -
              _keyScroll.currentContext!.size!.width / 2;
          _scrollController.jumpTo(jumpToX);

          fixedPosition = Offset(
              isOnlyOneAxis
                  ? 0.0
                  : (index * horizontalSpacing + 2 * horizontalPadding) -
                  _scrollController.offset,
              0.0);
          _verticalIndicatorPosition = fixedPosition;
          _onDisplayIndicator(
            LongPressMoveUpdateDetails(
              globalPosition: fixedPosition,
              offsetFromOrigin: fixedPosition,
            ),
          );
        }
      }
    }
    _checkIfNeedScroll();
    if (_isScrollable) {
      setState(() {});
    }
  }

  _checkIfNeedScroll() {
    if (_contentWidth >
        _keyScroll.currentContext!.size!.width - horizontalPadding * 2) {
      _isScrollable = true;
    }
  }

  ///Calculating the new series based on the `_currentBezierChartScale`
  _computeSeries() {
    computedSeries = [];
    _yValues = [];
    //fill data series for DateTime scale type

    if (_currentBezierChartScale == BezierChartScale.MONTHLY ||
        _currentBezierChartScale == BezierChartScale.YEARLY ||
        _currentBezierChartScale == BezierChartScale.WEEKLY ||
        _currentBezierChartScale == BezierChartScale.HOURLY) {
      for (BezierLine line in widget.series) {
        Map<String, List<double>> tmpMap = Map();
        for (DataPoint dataPoint in line.data) {
          String key;
          if (_currentBezierChartScale == BezierChartScale.MONTHLY) {
            key =
            '${dataPoint.xAxis.year},${dataPoint.xAxis.month.toString().padLeft(2, '0')}';
          } else if (_currentBezierChartScale == BezierChartScale.YEARLY) {
            key = '${dataPoint.xAxis.year}';
          } else if (_currentBezierChartScale == BezierChartScale.WEEKLY) {
            key =
            '${dataPoint.xAxis.year},${dataPoint.xAxis.month.toString().padLeft(2, '0')},${dataPoint.xAxis.day.toString().padLeft(2, '0')}';
          } else {
            key =
            '${dataPoint.xAxis.year},${dataPoint.xAxis.month.toString().padLeft(2, '0')},${dataPoint.xAxis.day.toString().padLeft(2, '0')},${dataPoint.xAxis.hour.toString().padLeft(2, '0')}';
          }

          //support aggregations for y axis
          if (!tmpMap.containsKey(key)) {
            tmpMap[key] = <double>[];
          }
          tmpMap[key]?.add(dataPoint.value);
        }

        Map<String, double> valueMap = Map();
        if (widget.bezierChartAggregation == BezierChartAggregation.SUM) {
          valueMap = tmpMap.map((k, v) => MapEntry(
              k,
              v.reduce(
                      (c1, c2) => double.parse((c1 + c2).toStringAsFixed(2)))));
        } else if (widget.bezierChartAggregation ==
            BezierChartAggregation.FIRST) {
          valueMap =
              tmpMap.map((k, v) => MapEntry(k, v.reduce((c1, c2) => c1)));
        } else if (widget.bezierChartAggregation ==
            BezierChartAggregation.AVERAGE) {
          valueMap = tmpMap.map(
                  (k, v) => MapEntry(k, v.reduce((c1, c2) => c1 + c2) / v.length));
        } else if (widget.bezierChartAggregation ==
            BezierChartAggregation.COUNT) {
          valueMap = tmpMap.map((k, v) => MapEntry(k, v.length.toDouble()));
        } else if (widget.bezierChartAggregation ==
            BezierChartAggregation.MAX) {
          valueMap = tmpMap.map(
                  (k, v) => MapEntry(k, v.reduce((c1, c2) => c1 > c2 ? c1 : c2)));
        } else if (widget.bezierChartAggregation ==
            BezierChartAggregation.MIN) {
          valueMap = tmpMap.map(
                  (k, v) => MapEntry(k, v.reduce((c1, c2) => c1 < c2 ? c1 : c2)));
        }

        List<DataPoint<DateTime>> newDataPoints = [];
        valueMap.keys.forEach(
              (key) {
            final value = valueMap[key];
            if (!_yValues.contains(value)) _yValues.add(value!);

            ///Sum all the values corresponding to each month and create a new data serie
            if (_currentBezierChartScale == BezierChartScale.HOURLY) {
              List<String> split = key.split(',');
              int year = int.parse(split[0]);
              int month = int.parse(split[1]);
              int day = int.parse(split[2]);
              int hour = int.parse(split[3]);
              final date = DateTime(year, month, day, hour, 0);
              newDataPoints.add(
                DataPoint<DateTime>(
                  value: value!,
                  xAxis: date,
                ),
              );
            }

            ///Sum all the values corresponding to each month and create a new data serie
            else if (_currentBezierChartScale == BezierChartScale.MONTHLY) {
              List<String> split = key.split(',');
              int year = int.parse(split[0]);
              int month = int.parse(split[1]);
              final date = DateTime(year, month);
              newDataPoints.add(
                DataPoint<DateTime>(
                  value: value!,
                  xAxis: date,
                ),
              );
            } else if (_currentBezierChartScale == BezierChartScale.WEEKLY) {
              List<String> split = key.split(',');
              int year = int.parse(split[0]);
              int month = int.parse(split[1]);
              int day = int.parse(split[2]);
              final date = DateTime(year, month, day, 0);
              newDataPoints.add(
                DataPoint<DateTime>(
                  value: value!,
                  xAxis: date,
                ),
              );
            } else {
              ///Sum all the values corresponding to each year and create a new data serie
              int year = int.parse(key);
              final date = DateTime(year);
              newDataPoints.add(
                DataPoint<DateTime>(
                  value: value!,
                  xAxis: date,
                ),
              );
            }
          },
        );

        BezierLine newBezierLine = BezierLine.copy(
          bezierLine: BezierLine(
            lineColor: line.lineColor,
            label: line.label,
            lineStrokeWidth: line.lineStrokeWidth,
            onMissingValue: line.onMissingValue,
            dataPointFillColor: line.dataPointFillColor,
            dataPointStrokeColor: line.dataPointStrokeColor,
            data: newDataPoints,
          ),
        );
        computedSeries.add(newBezierLine);
      }
    } else {
      for (BezierLine line in widget.series) {
        for (double val in line.data.map((dp) => dp.value).toList()) {
          if (!_yValues.contains(val)) _yValues.add(val);
        }
      }
      computedSeries = widget.series;
    }

    for (double temp in _tempYValues) {
      if (!_yValues.contains(temp)) _yValues.add(temp);
    }
    //sort yValues
    _yValues.sort((val1, val2) => (val1 > val2) ? 1 : -1);
  }

  ///Pinch and zoom based on the scale reported by the gesture detector
  _onPinchZoom(double scale) {
    scale = double.parse(scale.toStringAsFixed(1));
    if (isPinchZoomActive) {
      BezierChartScale lastScale = BezierChartScale.WEEKLY;
      if (_currentBezierChartScale == BezierChartScale.MONTHLY) {
        lastScale = BezierChartScale.MONTHLY;
      } else if (_currentBezierChartScale == BezierChartScale.YEARLY) {
        lastScale = BezierChartScale.YEARLY;
      }

      //when the scale is below 1 then we'll try to change the chart scale depending of the `_currentBezierChartScale`
      if (scale < 1) {
        if (_currentBezierChartScale == BezierChartScale.WEEKLY) {
          _currentBezierChartScale = BezierChartScale.MONTHLY;
          _previousScale = 1.5;
        } else if (_currentBezierChartScale == BezierChartScale.MONTHLY) {
          _currentBezierChartScale = BezierChartScale.YEARLY;
        }
        _currentScale = 1.0;
        setState(
              () {
            _buildXDataPoints();
            _computeSeries();
            _checkIfNeedScroll();
          },
        );
        _notifyScaleChanged(lastScale);
        return;
        //if the scale is greater than 1.5 then we'll try to change the chart scale depending of the `_currentBezierChartScale`
      } else if (scale > 1.5 || (isOnlyOneAxis && scale > 1.2)) {
        if (_currentBezierChartScale == BezierChartScale.YEARLY) {
          _currentBezierChartScale = BezierChartScale.MONTHLY;
          _currentScale = 1.0;
          _previousScale = 1.0 / scale;
          setState(
                () {
              _buildXDataPoints();
              _computeSeries();
              _checkIfNeedScroll();
            },
          );
          _notifyScaleChanged(lastScale);
        } else if (_currentBezierChartScale == BezierChartScale.MONTHLY) {
          _currentBezierChartScale = BezierChartScale.WEEKLY;
          _currentScale = 1.0;
          _previousScale = 1.0 / scale;
          setState(
                () {
              _buildXDataPoints();
              _computeSeries();
              _checkIfNeedScroll();
            },
          );
          _notifyScaleChanged(lastScale);
          return;
        }
      } else {
        if (scale > 2.5) scale = 2.5;
        if (scale != _currentScale) {
          setState(
                () {
              _currentScale = scale;
            },
          );
        }
      }
    }
  }

  void _notifyScaleChanged(BezierChartScale lastScale) {
    if (widget.onScaleChanged != null &&
        lastScale != _currentBezierChartScale) {
      widget.onScaleChanged!(_currentBezierChartScale);
    }
  }

  bool areSeriesDifferent = false;

  @override
  void didUpdateWidget(BezierChart oldWidget) {
    /// Rebuild data points and series in case:
    /// 1. if the BezierChartScale is different from the old one
    /// 2. if the series are different
    /// 3. if either fromDate or toDate are different
//    areSeriesDifferent = false;
//
//    if (oldWidget.series.length != widget.series.length) {
//      areSeriesDifferent = true;
//    } else {
//      if (oldWidget.series.length == widget.series.length) {
//        for (int i = 0; i < oldWidget.series.length; i++) {
//          final size1 = oldWidget.series[i];
//          final size2 = widget.series[i];
//          if (size1.data.length != size2.data.length) {
//            areSeriesDifferent = true;
//            break;
//          }
//        }
//      }
//
//      if (!areSeriesDifferent) {
//        for (int i = 0; i < oldWidget.series.length; i++) {
//          final line1 = oldWidget.series[i];
//          final line2 = widget.series[i];
//          if (line1 != line2) {
//            areSeriesDifferent = true;
//            break;
//          }
//        }
//      }
//    }
//
//    if (oldWidget.bezierChartScale != widget.bezierChartScale ||
//        areSeriesDifferent ||
//        oldWidget.fromDate != widget.fromDate ||
//        oldWidget.toDate != widget.toDate) {
//      _currentBezierChartScale = widget.bezierChartScale;
//      _buildXDataPoints();
//      _computeSeries();
//    }
    // TODO(weilu): 修改处
    if (oldWidget.series != widget.series) {
      _currentBezierChartScale = widget.bezierChartScale;
      _buildXDataPoints();
      _computeSeries();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _currentBezierChartScale = widget.bezierChartScale;
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _buildXDataPoints();
    _computeSeries();
    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  int _touchFingers = 0;

  @override
  Widget build(BuildContext context) {
    //using `Listener` to fix the issue with single touch for multitouch gesture like pinch/zoom
    //https://github.com/flutter/flutter/issues/13102
    return Semantics(
      label: '长按查看详细数据',
      child: Container(
        decoration: BoxDecoration(
          // TODO(weilu): 修改处
//        color: widget.config.backgroundGradient != null
//            ? null
//            : widget.config.backgroundColor,
          gradient: widget.config.backgroundGradient,
        ),
        alignment: Alignment.center,
        child: Listener(
          onPointerDown: (_) {
            _touchFingers++;
            if (_touchFingers > 1) {
              setState(() {});
            }
          },
          onPointerUp: (_) {
            _touchFingers--;
            if (_touchFingers < 2) {
              setState(() {});
            }
          },
          child: GestureDetector(
            onLongPressStart: widget.config.updatePositionOnTap
                ? null
                : (isPinchZoomActive ? null : _onDisplayIndicator),
            onLongPressMoveUpdate: isPinchZoomActive ? null : _refreshPosition,
            onScaleStart: (_) {
              _previousScale = _currentScale;
            },
            onScaleUpdate: _currentBezierChartScale != BezierChartScale.CUSTOM &&
                //Hourly chart doesn't support pinch/zoom for now
                _currentBezierChartScale != BezierChartScale.HOURLY &&
                !_displayIndicator
                ? (details) => _onPinchZoom(_previousScale * details.scale)
                : null,
            onTap: widget.config.updatePositionOnTap
                ? null
                : (isPinchZoomActive ? null : _onHideIndicator),
            onTapDown: widget.config.updatePositionOnTap
                ? (isPinchZoomActive ? null : _refreshPosition)
                : null,
            child: LayoutBuilder(
              builder: (context, constraints) {
                _contentWidth = _buildContentWidth(constraints);
                final items = <Widget>[];
                final maxHeight = constraints.biggest.height * 0.75;
                items.add(
                  MySingleChildScrollView(
                    controller: _scrollController,
                    physics: isPinchZoomActive || !_isScrollable
                        ? const NeverScrollableScrollPhysics()
                        : widget.config.physics,
                    key: _keyScroll,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Align(
                      alignment: Alignment(0.0, 0.7),
                      child: CustomPaint(
                        size: Size(
                          _contentWidth,
                          maxHeight,
                        ),
                        painter: _BezierChartPainter(
                          shouldRepaintChart: areSeriesDifferent,
                          config: widget.config,
                          maxYValue: _yValues.last,
                          minYValue: _yValues.first,
                          bezierChartScale: _currentBezierChartScale,
                          verticalIndicatorPosition: _verticalIndicatorPosition,
                          series: computedSeries,
                          showIndicator: _displayIndicator,
                          animation: CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              0.0,
                              1.0,
                              curve: Curves.elasticOut,
                            ),
                          ),
                          xAxisDataPoints: _xAxisDataPoints,
                          onDataPointSnap: _onDataPointSnap,
                          maxWidth: MediaQuery.of(context).size.width,
                          scrollOffset: _scrollController.hasClients
                              ? _scrollController.offset
                              : 0.0,
                          footerValueBuilder: widget.footerValueBuilder,
                          bubbleLabelValueBuilder: widget.bubbleLabelValueBuilder,
                          footerDateTimeBuilder: widget.footerDateTimeBuilder,
                          bubbleLabelDateTimeBuilder:
                          widget.bubbleLabelDateTimeBuilder,
                          onValueSelected: (val) {
                            if (widget.onValueSelected != null) {
                              if (_valueSelected == null) {
                                _valueSelected = val;
                                widget.onValueSelected!(_valueSelected!);
                              } else {
                                if (_valueSelected != val) {
                                  _valueSelected = val;
                                  widget.onValueSelected!(_valueSelected!);
                                }
                              }
                            }
                          },
                          onDateTimeSelected: (val) {
                            if (widget.onDateTimeSelected != null) {
                              if (_dateTimeSelected == null) {
                                _dateTimeSelected = val;
                                widget.onDateTimeSelected!(_dateTimeSelected!);
                              } else {
                                if (_dateTimeSelected != val) {
                                  _dateTimeSelected = val;
                                  widget.onDateTimeSelected!(_dateTimeSelected!);
                                }
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
                if (widget.config.displayYAxis) {
                  if (_yValues != null && _yValues.isNotEmpty) {
                    //add a background container for the Y Axis
                    items.add(Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: _yAxisWidth + 10,
                        decoration: widget.config.backgroundGradient != null
                            ? BoxDecoration(
                            gradient: widget.config.backgroundGradient)
                            : null,
                        color: widget.config.backgroundGradient != null
                            ? null
                            : widget.config.backgroundColor,
                      ),
                    ));
                  }

                  final fontSize = widget.config.yAxisTextStyle?.fontSize ?? 8.0;
                  final maxValue = _yValues.last -
                      (widget.config.startYAxisFromNonZeroValue
                          ? _yValues.first
                          : 0.0);
                  final steps = widget.config.stepsYAxis != null &&
                      widget.config.stepsYAxis! > 0
                      ? widget.config.stepsYAxis
                      : null;
                  _addYItem(double value, {Key? key}) {
                    items.add(
                      Positioned(
                        bottom: _getRealValue(
                            value -
                                (widget.config.startYAxisFromNonZeroValue
                                    ? _yValues.first
                                    : 0.0),
                            maxHeight - widget.config.footerHeight,
                            maxValue) +
                            widget.config.footerHeight +
                            fontSize / 2,
                        left: 10.0,
                        child: Text(
                          formatAsIntOrDouble(value),
                          key: key,
                          style: widget.config.yAxisTextStyle ??
                              TextStyle(color: Colors.white, fontSize: fontSize),
                        ),
                      ),
                    );
                  }

                  if (steps != null) {
                    final max = _yValues.last;
                    final min = widget.config.startYAxisFromNonZeroValue
                        ? _yValues.first.ceil()
                        : 0;
                    for (int i = min; i < max + steps; i++) {
                      if (i % steps == 0) {
                        bool isLast =
                            (i + steps) > max && (i + steps) >= (max + steps);
                        _addYItem(i.toDouble(),
                            key: isLast ? _keyLastYAxisItem : null);
                      }
                    }
                  } else {
                    for (double val in _yValues) {
                      _addYItem(val,
                          key: val == _yValues.last ? _keyLastYAxisItem : null);
                    }
                  }
                }
                return Stack(
                  children: items,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

///return the real value of canvas
_getRealValue(double value, double maxConstraint, double maxValue) =>
    maxConstraint * value / (maxValue == 0 ? 1 : maxValue);

//BezierChart
class _BezierChartPainter extends CustomPainter {
  final BezierChartConfig config;
  final Offset? verticalIndicatorPosition;
  final List<BezierLine> series;
  final List<DataPoint> xAxisDataPoints;
  double _maxValueY = 0.0;
  double _maxValueX = 0.0;
  List<_CustomValue> _currentCustomValues = [];
  DataPoint? _currentXDataPoint;
  final double radiusDotIndicatorMain = 7;
  final double radiusDotIndicatorItems = 3.5;
  final bool showIndicator;
  final Animation animation;
  final ValueChanged<double>? onDataPointSnap;
  final BezierChartScale bezierChartScale;
  final double maxWidth;
  final double scrollOffset;
  bool footerDrawed = false;
  final FooterValueBuilder? footerValueBuilder;
  final FooterValueBuilder? bubbleLabelValueBuilder;
  final FooterDateTimeBuilder? footerDateTimeBuilder;
  final FooterDateTimeBuilder? bubbleLabelDateTimeBuilder;
  final double maxYValue;
  final double minYValue;
  final ValueChanged<double>? onValueSelected;
  final ValueChanged<DateTime>? onDateTimeSelected;
  final bool shouldRepaintChart;

  _BezierChartPainter({
    required this.shouldRepaintChart,
    required this.config,
    this.verticalIndicatorPosition,
    required this.series,
    required this.showIndicator,
    required this.xAxisDataPoints,
    required this.animation,
    required this.bezierChartScale,
    this.onDataPointSnap,
    required this.maxWidth,
    this.footerValueBuilder,
    this.bubbleLabelValueBuilder,
    required this.scrollOffset,
    this.footerDateTimeBuilder,
    this.bubbleLabelDateTimeBuilder,
    required this.maxYValue,
    required this.minYValue,
    this.onDateTimeSelected,
    this.onValueSelected,
  }) : super(repaint: animation) {
    _maxValueY = _getMaxValueY();
    _maxValueX = _getMaxValueX();
  }

  ///return the max value of the Axis X
  double _getMaxValueX() {
    double x = double.negativeInfinity;
    for (DataPoint dp in xAxisDataPoints) {
      if (dp.value > x) x = dp.value;
    }
    return x;
  }

  ///return the max value of the Axis Y
  double _getMaxValueY() {
    /*
    double y = double.negativeInfinity;
    for (BezierLine line in series) {
      for (DataPoint dp in line.data) {
        if (dp.value > y) y = dp.value;
      }
    }*/
    if (maxYValue == 0.0) return 1.0;
    return maxYValue - (config.startYAxisFromNonZeroValue ? minYValue : 0.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height - config.footerHeight;
    Paint paintVerticalIndicator = Paint();
    try {
      paintVerticalIndicator
        ..color = config.verticalIndicatorColor
        ..strokeWidth = config.verticalIndicatorStrokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.square;
    } catch (ex) {
      print('err: $ex');
    }

    Paint paintControlPoints = Paint()..strokeCap = StrokeCap.round;

    double verticalX = 0.0;
    //fixing verticalIndicator outbounds
    if (verticalIndicatorPosition != null) {
      verticalX = verticalIndicatorPosition!.dx;
      if (verticalIndicatorPosition!.dx < 0) {
        verticalX = 0.0;
      } else if (verticalIndicatorPosition!.dx > size.width) {
        verticalX = size.width;
      }
    }

    //variables for the last item on the list (this is required to display the indicator)
    late Offset p0, p1, p2, p3;
    void _drawBezierLinePath(BezierLine line) {
      Path path = Path();
      List<Offset> dataPoints = [];

      TextPainter textPainterXAxis = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      TextStyle xAxisTextStyle = config.xAxisTextStyle ??
          TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 11,
          );

      Paint paintLine = Paint()
        ..color = line.lineColor
        ..strokeWidth = line.lineStrokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      Paint paintXLines = Paint()
        ..color = config.xLinesColor
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      _AxisValue? lastPoint;

      //display each data point
      for (int i = 0; i < xAxisDataPoints.length; i++) {
        double value = 0.0;

        double axisX = xAxisDataPoints[i].value;

        final double valueX = _getRealValue(
          axisX,
          size.width,
          _maxValueX,
        );

        //Only calculate and display the necessary data to improve the performance of the scrolling
        final range = maxWidth * 10;
        if (scrollOffset - range >= valueX || scrollOffset + range <= valueX) {
          continue;
        }
        bool isMissingValue = false;
        if (bezierChartScale == BezierChartScale.CUSTOM) {
          value = line.data[i].value;
        } else {
          //search from axis
          for (DataPoint dp in line.data) {
            final dateTime = (xAxisDataPoints[i].xAxis as DateTime);

            if (bezierChartScale == BezierChartScale.HOURLY) {
              if (areEqualDatesIncludingHour(dateTime, dp.xAxis)) {
                value = dp.value;
                axisX = xAxisDataPoints[i].value;
                break;
              }
            } else {
              if (areEqualDates(dateTime, dp.xAxis)) {
                value = dp.value;
                axisX = xAxisDataPoints[i].value;
                break;
              }
            }
          }

          if (value == 0) {
            if (line.onMissingValue != null) {
              isMissingValue = true;
              value = line.onMissingValue!(xAxisDataPoints[i].xAxis as DateTime);
            }
          }
        }

        final double axisY = value;
        final double valueY = height -
            _getRealValue(
              axisY - (config.startYAxisFromNonZeroValue ? minYValue : 0.0),
              height,
              _maxValueY,
            );

        if (config.displayLinesXAxis && series.length == 1) {
          canvas.drawLine(
              Offset(valueX, height), Offset(valueX, valueY), paintXLines);
        }

        if (lastPoint == null) {
          lastPoint = _AxisValue(x: valueX, y: valueY);
          path.moveTo(valueX, valueY);
        }

        final double controlPointX = lastPoint.x + (valueX - lastPoint.x) / 2;
        path.cubicTo(
            controlPointX, lastPoint.y, controlPointX, valueY, valueX, valueY);
        if (isMissingValue) {
          if (config.displayDataPointWhenNoValue) {
            dataPoints.add(Offset(valueX, valueY));
          }
        } else {
          dataPoints.add(Offset(valueX, valueY));
        }

        if (verticalIndicatorPosition != null &&
            verticalX >= lastPoint.x &&
            verticalX <= valueX) {
          //points to draw the info
          p0 = Offset(lastPoint.x, height - lastPoint.y);
          p1 = Offset(controlPointX, height - lastPoint.y);
          p2 = Offset(controlPointX, height - valueY);
          p3 = Offset(valueX, height - valueY);
        }

        if (verticalIndicatorPosition != null) {
          //get current information
          double nextX = double.infinity;
          double lastX = double.negativeInfinity;
          if (xAxisDataPoints.length > (i + 1)) {
            nextX = _getRealValue(
              xAxisDataPoints[i + 1].value,
              size.width,
              _maxValueX,
            );
          }
          if (i > 0) {
            lastX = _getRealValue(
              xAxisDataPoints[i - 1].value,
              size.width,
              _maxValueX,
            );
          }

          //if vertical indicator is in range then display the bubble info
          if (verticalX >= valueX - (valueX - lastX) / 2 &&
              verticalX <= valueX + (nextX - valueX) / 2) {
            _currentXDataPoint = xAxisDataPoints[i];
            if (_currentCustomValues.length < series.length) {
              bool isDouble = (xAxisDataPoints[i].xAxis is double);
              if (isDouble) {
                if (onValueSelected != null) {
                  onValueSelected!(xAxisDataPoints[i].xAxis);
                }
              } else {
                if (onDateTimeSelected != null) {
                  onDateTimeSelected!(xAxisDataPoints[i].xAxis);
                }
              }

              onDataPointSnap!(xAxisDataPoints[i].value);
              _currentCustomValues.add(
                _CustomValue(
                  value: '${formatAsIntOrDouble(axisY)}',
                  label: line.label,
                  color: line.lineColor,
                ),
              );
            }
          }
        }

        lastPoint = _AxisValue(x: valueX, y: valueY);

        //draw footer
        textPainterXAxis.text = TextSpan(
          text: _getFooterText(xAxisDataPoints[i]),
          style: xAxisTextStyle,
        );
        textPainterXAxis.layout();
        textPainterXAxis.paint(
          canvas,
          Offset(valueX - textPainterXAxis.width / 2,
              height + textPainterXAxis.height / 1.5),
        );
      }

      //only draw the footer for the first line because it is the same for all the lines
      if (!footerDrawed) footerDrawed = true;

      canvas.drawPath(path, paintLine);
      if (config.showDataPoints) {
        //draw data points
        //Data points won't work until Flutter team fix this issue : https://github.com/flutter/flutter/issues/32218
//        if (!kIsWeb) { // TODO(weilu): web已支持
          canvas.drawPoints(
              PointMode.points,
              dataPoints,
              paintControlPoints
                ..style = PaintingStyle.stroke
                ..strokeWidth = 9
                ..color = line.dataPointStrokeColor);
          canvas.drawPoints(
            PointMode.points,
            dataPoints,
            paintControlPoints
              ..style = PaintingStyle.fill
              ..strokeWidth = line.lineStrokeWidth * 2
              ..color = line.dataPointFillColor,
          );
//        }
      }
    }

    final reversedSeries = series.reversed;
    for (BezierLine line in reversedSeries) {
      _drawBezierLinePath(line);
    }

    if (verticalIndicatorPosition != null && showIndicator) {
      if (config.snap) {
        if (_currentXDataPoint != null) {
          verticalX = _getRealValue(
            _currentXDataPoint!.value,
            size.width,
            _maxValueX,
          );
        } else {
          verticalX = 0.0;
        }
      }

      if (p0 != null) {
        final yValue = _getYValues(
          p0,
          p1,
          p2,
          p3,
          (verticalX - p0.dx) / (p3.dx - p0.dx),
        );

        double infoWidth = 0; //base value, modified based on the label text
        double infoHeight = 30;

        //bubble indicator padding
        // TODO 28
        final horizontalPadding = 18.0;
        // TODO 42
        double offsetInfo = 37 + ((_currentCustomValues.length - 1.0) * 10.0);
        final centerForCircle = Offset(verticalX, height - yValue);
        final center = config.verticalIndicatorFixedPosition
            ? Offset(verticalX, offsetInfo)
            : centerForCircle;

        if (config.showVerticalIndicator) {
          canvas.drawLine(
            Offset(verticalX, height),
            Offset(verticalX, config.verticalLineFullHeight ? 0.0 : center.dy),
            paintVerticalIndicator,
          );
        }

        //draw point
        canvas.drawCircle(
          centerForCircle,
          radiusDotIndicatorMain,
          Paint()
            ..color = series.reversed.toList().last.dataPointFillColor
            ..strokeWidth = 4.0,
        );

        //calculate the total lenght of the lines
        List<TextSpan> textValues = [];
        List<Offset> centerCircles = [];
        // TODO(weilu): 修改处 infoHeight / (8.75)
        double space =
            10 - ((infoHeight / (4)) * _currentCustomValues.length);
        infoHeight =
            infoHeight + (_currentCustomValues.length - 1) * (infoHeight / 3);

        for (_CustomValue customValue in _currentCustomValues.reversed.toList()) {
          textValues.add(
            TextSpan(
              text: '${customValue.value} ',
              style: config.bubbleIndicatorValueStyle.copyWith(fontSize: 11),
              children: [
                TextSpan(
                  text: '${customValue.label}\n',
                  style: config.bubbleIndicatorLabelStyle.copyWith(fontSize: 9),
                ),
              ],
            ),
          );
          centerCircles.add(
            // Offset(center.dx - infoWidth / 2 + radiusDotIndicatorItems * 1.5,
            Offset(
                center.dx,
                center.dy -
                    offsetInfo -
                    radiusDotIndicatorItems +
                    space +
                    (_currentCustomValues.length == 1 ? 1 : 0)),
          );
          space += 12.5;
        }

        //Calculate Text size
        TextPainter textPainter = TextPainter(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: _getInfoTitleText(),
            // TODO(weilu): 修改处 9.5
            style: config.bubbleIndicatorTitleStyle.copyWith(fontSize: 5.0),
            children: textValues,
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        infoWidth =
            textPainter.width + radiusDotIndicatorItems * 2 + horizontalPadding;

        ///Draw Bubble Indicator Info
        /// Draw shadow bubble info
        if (animation.isCompleted) {
          Path path = Path();
          path.moveTo(center.dx - infoWidth / 2 + 4,
              center.dy - offsetInfo + infoHeight / 1.8);
          path.lineTo(center.dx + infoWidth / 2 + 4,
              center.dy - offsetInfo + infoHeight / 1.8);
          path.lineTo(center.dx + infoWidth / 2 + 4,
              center.dy - offsetInfo - infoHeight / 3);
          //path.close();
          // canvas.drawShadow(path, Colors.black, 20.0, false);
          canvas.drawPath(path, paintControlPoints..color = Colors.black12);
        }

        final paintInfo = Paint()
          ..color = config.bubbleIndicatorColor
          ..style = PaintingStyle.fill;

        //Draw Bubble info
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            _fromCenter(
              center: Offset(
                center.dx,
                (center.dy - offsetInfo * animation.value),
              ),
              width: infoWidth,
              height: infoHeight,
            ),
            Radius.circular(5),
          ),
          paintInfo,
        );

        //Draw triangle Bubble
        final double triangleSize = 6;

        Path pathArrow = Path();

        pathArrow.moveTo(center.dx - triangleSize,
            center.dy - offsetInfo * animation.value + infoHeight / 2.1);
        pathArrow.lineTo(
            center.dx,
            center.dy -
                offsetInfo * animation.value +
                infoHeight / 2.1 +
                triangleSize * 1.5);
        pathArrow.lineTo(center.dx + triangleSize,
            center.dy - offsetInfo * animation.value + infoHeight / 2.1);
        pathArrow.close();
        canvas.drawPath(
          pathArrow,
          paintInfo,
        );
        //End triangle

        if (animation.isCompleted) {
          //Paint Text , title and description
          textPainter.paint(
            canvas,
            Offset(
              center.dx - textPainter.width / 2 + 6,  // TODO 0
              center.dy - offsetInfo - infoHeight / 2.5,
            ),
          );

          //draw circle indicators and text
          for (int z = 0; z < _currentCustomValues.length; z++) {
            _CustomValue customValue = _currentCustomValues[z];
            Offset centerIndicator = centerCircles.reversed.toList()[z];
            Offset fixedCenter = Offset(
                centerIndicator.dx -
                    infoWidth / 2 +
                    radiusDotIndicatorItems +
                    6, // TODO 4
                centerIndicator.dy);
            canvas.drawCircle(
                fixedCenter,
                radiusDotIndicatorItems,
                Paint()
                  ..color = customValue.color
                  ..style = PaintingStyle.fill);
            canvas.drawCircle(
                fixedCenter,
                radiusDotIndicatorItems,
                Paint()
                  ..color = Colors.black
                  ..strokeWidth = 0.5
                  ..style = PaintingStyle.stroke);
          }
        }
      }
    }
  }

  String _getInfoTitleText() {
    final scale = bezierChartScale;
    if (bubbleLabelValueBuilder != null && scale == BezierChartScale.CUSTOM) {
      return bubbleLabelValueBuilder!(_currentXDataPoint!.value);
    }
    if (bubbleLabelDateTimeBuilder != null &&
        scale != BezierChartScale.CUSTOM) {
      return bubbleLabelDateTimeBuilder!(
          _currentXDataPoint!.xAxis as DateTime, scale);
    }
    if (scale == BezierChartScale.CUSTOM) {
      return "${formatAsIntOrDouble(_currentXDataPoint!.value)}\n";
    } else if (scale == BezierChartScale.HOURLY) {
      final dateFormat = intl.DateFormat('dd/MM HH:mm');
      final date = _currentXDataPoint!.xAxis as DateTime;
      final now = DateTime.now();
      if (areEqualDatesIncludingHour(date, now)) {
        return 'Now\n';
      } else {
        return '${dateFormat.format(_currentXDataPoint!.xAxis)}\n';
      }
    } else if (scale == BezierChartScale.WEEKLY) {
      final dateFormat = intl.DateFormat('EEE d');
      final date = _currentXDataPoint!.xAxis as DateTime;
      final now = DateTime.now();
      if (areEqualDates(date, now)) {
        return 'Current\n';
      } else {
        return '${dateFormat.format(_currentXDataPoint!.xAxis)}\n';
      }
    } else if (scale == BezierChartScale.MONTHLY) {
      final dateFormat = intl.DateFormat('MMM y');
      final date = _currentXDataPoint!.xAxis as DateTime;
      final now = DateTime.now();
      if (date.year == now.year && now.month == date.month) {
        return 'Current Month\n';
      } else {
        return '${dateFormat.format(_currentXDataPoint!.xAxis)}\n';
      }
    } else if (scale == BezierChartScale.YEARLY) {
      final dateFormat = intl.DateFormat('y');
      final date = _currentXDataPoint!.xAxis as DateTime;
      final now = DateTime.now();
      if (date.year == now.year) {
        return 'Current Year\n';
      } else {
        return '${dateFormat.format(_currentXDataPoint!.xAxis)}\n';
      }
    }
    return '';
  }

  String _getFooterText(DataPoint dataPoint) {
    final scale = bezierChartScale;
    if (footerValueBuilder != null && scale == BezierChartScale.CUSTOM) {
      return footerValueBuilder!(dataPoint.value);
    }
    if (footerDateTimeBuilder != null && scale != BezierChartScale.CUSTOM) {
      return footerDateTimeBuilder!(dataPoint.xAxis as DateTime, scale);
    }
    if (scale == BezierChartScale.CUSTOM) {
      return '${formatAsIntOrDouble(dataPoint.value)}\n';
    } else if (scale == BezierChartScale.HOURLY) {
      final dateFormat = intl.DateFormat('HH:mm\n');
      return '${dateFormat.format(dataPoint.xAxis as DateTime)}';
    } else if (scale == BezierChartScale.WEEKLY) {
      final dateFormat = intl.DateFormat('EEE\nd');
      return '${dateFormat.format(dataPoint.xAxis as DateTime)}';
    } else if (scale == BezierChartScale.MONTHLY) {
      final dateFormat = intl.DateFormat('MMM');
      final dateFormatYear = intl.DateFormat('y');
      final year =
      dateFormatYear.format(dataPoint.xAxis as DateTime).substring(2);
      return "${dateFormat.format(dataPoint.xAxis as DateTime)}\n'$year";
    } else if (scale == BezierChartScale.YEARLY) {
      final dateFormat = intl.DateFormat('y');
      return '${dateFormat.format(dataPoint.xAxis as DateTime)}';
    }
    return '';
  }

  _getYValues(Offset p0, Offset p1, Offset p2, Offset p3, double t) {
    if (t.isNaN) {
      t = 1.0;
    }
    //P0 = (X0,Y0)
    //P1 = (X1,Y1)
    //P2 = (X2,Y2)
    //P3 = (X3,Y3)
    //X(t) = (1-t)^3 * X0 + 3*(1-t)^2 * t * X1 + 3*(1-t) * t^2 * X2 + t^3 * X3
    //Y(t) = (1-t)^3 * Y0 + 3*(1-t)^2 * t * Y1 + 3*(1-t) * t^2 * Y2 + t^3 * Y3
    //source: https://stackoverflow.com/questions/8217346/cubic-bezier-curves-get-y-for-given-x
    final y0 = p0.dy; // x0 = p0.dx;
    final y1 = p1.dy; //x1 = p1.dx,
    final y2 = p2.dy; //x2 = p2.dx,
    final y3 = p3.dy; //x3 = p3.dx,

    //print('p0: $p0, p1: $p1, p2: $p2, p3: $p3 , t: $t');

    final y = pow(1 - t, 3) * y0 +
        3 * pow(1 - t, 2) * t * y1 +
        3 * (1 - t) * pow(t, 2) * y2 +
        pow(t, 3) * y3;
    return y;
  }

  Rect _fromCenter({required Offset center, required double width, required double height}) =>
      Rect.fromLTRB(
        center.dx - width / 2,
        center.dy - height / 2,
        center.dx + width / 2,
        center.dy + height / 2,
      );

  @override
  bool shouldRepaint(_BezierChartPainter oldDelegate) =>
//      shouldRepaintChart ||
//          oldDelegate.verticalIndicatorPosition != verticalIndicatorPosition ||
//          oldDelegate.scrollOffset != scrollOffset ||
//          oldDelegate.showIndicator != showIndicator;
  // TODO(weilu): 修改处
  oldDelegate.series != series || oldDelegate.verticalIndicatorPosition != verticalIndicatorPosition;
}

class _AxisValue {
  final double x;
  final double y;
  const _AxisValue({
    required this.x,
    required this.y,
  });
}

bool _compareLengths(int currentValue, List<BezierLine> val2) {
  for (BezierLine line in val2) {
    if (currentValue != line.data.length) {
      return false;
    }
  }
  return true;
}

bool _isSorted<T>(List<double> list, [int Function(double, double)? compare]) {
  if (list.length < 2) return true;
  compare ??= (double a, double b) => a.compareTo(b);
  double prev = list.first;
  for (var i = 1; i < list.length; i++) {
    double next = list[i];
    if (compare(prev, next) > 0) return false;
    prev = next;
  }
  return true;
}

bool _checkCustomValues(List<BezierLine> list) {
  for (BezierLine line in list) {
    if (!_areAllPositive(
      line.data.map((dp) => dp.value),
    )) return false;
  }
  return true;
}

bool _areAllPositive(Iterable<double> list) {
  for (double val in list) {
    if (val < 0) return false;
  }
  return true;
}

///This method remove the decimals if the value doesn't have decimals
String formatAsIntOrDouble(double str) {
  final values = str.toString().split('.');
  if (values.length > 1) {
    final int intDecimal = int.parse(values[1]);
    if (intDecimal == 0) {
      return str.toInt().toString();
    }
  }
  return str.toString();
}

class _CustomValue {
  final String value;
  final String label;
  final Color color;

  _CustomValue({
    required this.value,
    required this.label,
    required this.color,
  });
}

bool areEqualDates(DateTime dateTime1, DateTime dateTime2) =>
    dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;

bool areEqualDatesIncludingHour(DateTime dateTime1, DateTime dateTime2) =>
    dateTime1.year == dateTime2.year && 
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day &&
        dateTime1.hour == dateTime2.hour;
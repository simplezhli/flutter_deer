
import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/statistics/widgets/selected_date.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/bezier_chart/bezier_chart.dart';
import 'package:flutter_deer/util/date_utils.dart' as date;

/// design/5统计/index.html#artboard1
/// design/5统计/index.html#artboard6
class OrderStatisticsPage extends StatefulWidget {

  const OrderStatisticsPage(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  _OrderStatisticsPageState createState() => _OrderStatisticsPageState();
}

class _OrderStatisticsPageState extends State<OrderStatisticsPage> with TickerProviderStateMixin {
  
  int _selectedIndex = 2;
  DateTime _initialDay;
  Iterable<DateTime> _weeksDays;
  List<DateTime> _currentMonthsDays;
  // 周视图中选择的日期
  int _selectedWeekDay;
  // 月视图中选择的日期
  DateTime _selectedDay;
  // 年视图中选择的月份
  int _selectedMonth;
  final List<int> _monthList = [];
  bool _isExpanded = true;
  Color _unSelectedTextColor;
  
  static const List<String> _weeks = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

  @override
  void initState() {
    super.initState();
    _initialDay = DateTime.now();
    _selectedWeekDay = _initialDay.day;
    _selectedDay = _initialDay;
    _selectedMonth = _initialDay.month;
    _weeksDays = date.DateUtils.daysInRange(date.DateUtils.previousWeek(_initialDay), date.DateUtils.nextDay(_initialDay)).toList().sublist(1, 8);
    _currentMonthsDays = date.DateUtils.daysInMonth(_initialDay);
    _monthList.clear();
    for (int i = 1; i < 13; i ++) {
      _monthList.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    _unSelectedTextColor = context.isDark ? Colors.white : Colours.dark_text_gray;
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: widget.index == 1 ? '订单统计' : '交易额统计',
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gaps.vGap16,
              Row(
                children: <Widget>[
                  Gaps.hGap16,
                  _buildButton(_initialDay.year.toString(), const Key('year'), 0),
                  Gaps.hGap12,
                  Gaps.vLine,
                  Gaps.hGap12,
                  _buildButton('${_initialDay.month.toString()}月', const Key('month'), 1),
                  Gaps.hGap12,
                  Gaps.vLine,
                  Gaps.hGap12,
                  _buildButton('${date.DateUtils.previousWeekToString(_initialDay)} -${date.DateUtils.apiDayFormat2(_initialDay)}', const Key('day'), 2),
                ],
              ),
              Gaps.vGap16,
              Flexible(
                child: Container(
                  color: ThemeUtils.getStickyHeaderColor(context),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: _selectedIndex != 1 ? 4.0 : 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
//                      AnimatedCrossFade(
//                        firstChild: _buildCalendar(),
//                        secondChild: _buildCalendar(),
//                        firstCurve: const Interval(0.0, 0.0, curve: Curves.fastOutSlowIn),
//                        secondCurve: const Interval(0.0, 0.0, curve: Curves.fastOutSlowIn),
//                        sizeCurve: Curves.decelerate,
//                        crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//                        duration: const Duration(milliseconds: 300),
//                      ),
                      AnimatedSize(
                        child: _buildCalendar(),
                        vsync: this,
                        curve: Curves.decelerate,
                        duration: const Duration(milliseconds: 300),
                      ),
                      if (_selectedIndex == 1) InkWell(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Semantics(
                          label: _isExpanded ? '收起' : '展开',
                          child: Container(
                            height: 27.0,
                            alignment: Alignment.topCenter,
                            child: LoadAssetImage('statistic/${_isExpanded ? 'up' : 'down'}', width: 16.0, color: ThemeUtils.getIconColor(context),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.index == 1 ? '订单走势' : '交易额走势', style: TextStyles.textBold18),
                    Gaps.vGap16,
                    _buildChart(Colours.app_main, const Color(0x805793FA), widget.index == 1 ? '全部订单' : '交易额(元)', '3000'),
                    if (widget.index == 1) Column(
                      children: <Widget>[
                        Gaps.vGap16,
                        _buildChart(const Color(0xFFFFAA33), const Color(0x80FFAA33), '完成订单', '2000'),
                        Gaps.vGap16,
                        _buildChart(Theme.of(context).errorColor, const Color(0x80FF4759), '取消订单', '1000'),
                        Gaps.vGap16,
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildButton(String text, Key key, int index) {
    return SelectedDateButton(
      text,
      key: key,
      fontSize: Dimens.font_sp15,
      selected: _selectedIndex == index,
      unSelectedTextColor: _unSelectedTextColor,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
  
  Widget _buildChart(Color color, Color shadowColor, String title, String count) {
    
    final Column body = Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: const TextStyle(color: Colors.white)),
            Text(count, style: const TextStyle(color: Colors.white)),
          ],
        ),
        Gaps.vGap4,
        Expanded(
          child: BezierChart(
            bezierChartScale: BezierChartScale.CUSTOM,
            xAxisCustomValues: const <double>[0, 5, 10, 15, 20, 25, 30],
            footerValueBuilder: (double value) => '',
            bubbleLabelValueBuilder: (double value) => '\n',
            series: [
              BezierLine(
                dataPointStrokeColor: color,
                label: widget.index == 1 ? '单' : '元',
                data: _getRandomData(),
              ),
            ],
            config: BezierChartConfig(
              footerHeight: 0,
              showVerticalIndicator: false,
              verticalIndicatorFixedPosition: false,
              snap: true,
              backgroundColor: color,
            ),
          ),
        ),
      ],
    );
    
    return AspectRatio(
      aspectRatio: 3,
      child: MyCard(
        color: color,
        shadowColor: shadowColor,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ImageUtils.getAssetImage('statistic/chart_fg'),
              fit: BoxFit.fill,
            ),
          ),
          child: body,
        ),
      ),
    );
  }

  List<DataPoint> data = [];
  List<DataPoint> data1 = [];
  List<DataPoint> data2 = [];

  // 数据变化图标会刷新，否则不会
  List<DataPoint> _getRandomData() {
    if (data.isEmpty) {
      for (int i = 0; i < 7; i++) {
        data.add(DataPoint<double>(value: Random.secure().nextInt(3000).toDouble(), xAxis: (i * 5).toDouble()));
      }
      for (int i = 0; i < 7; i++) {
        data1.add(DataPoint<double>(value: Random.secure().nextInt(3000).toDouble(), xAxis: (i * 5).toDouble()));
      }
      for (int i = 0; i < 7; i++) {
        data2.add(DataPoint<double>(value: Random.secure().nextInt(3000).toDouble(), xAxis: (i * 5).toDouble()));
      }
    }

    if (_selectedIndex == 0) {
      return data;
    } else if (_selectedIndex == 1) {
      return data1;
    } else {
      return data2;
    }
  }

  Widget _buildCalendar() {
    List<Widget> children;
    if (_selectedIndex == 0) {
      children = _builderYearCalendar();
    } else if (_selectedIndex == 1) {
      children = _builderMonthCalendar();
    } else if (_selectedIndex == 2) {
      children = _builderWeekCalendar();
    }
    
    return GridView.count(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 7,
      children: children,
    );
  }
  
  List<Widget> _buildWeeks() {
    final List<Widget> widgets = [];
    _weeks.forEach((str) {
      widgets.add(Center(
        child: Text(str, style: Theme.of(context).textTheme.subtitle2),
      ));
    });
    return widgets;
  }

  List<Widget> _builderMonthCalendar() {
    final List<Widget> dayWidgets = [];
    List<DateTime> list;
    if (_isExpanded) {
      list = _currentMonthsDays;
    } else {
      list = date.DateUtils.daysInWeek(_selectedDay);
    }
    dayWidgets.addAll(_buildWeeks());
    list.forEach((day) {
      dayWidgets.add(
        Center(
          child: SelectedDateButton(
            day.day.toString().padLeft(2, '0'), // 不足2位左边补0
            selected: day.day == _selectedDay.day && !date.DateUtils.isExtraDay(day, _initialDay),
            // 不是本月的日期与超过当前日期的不可点击
            enable: day.day <= _initialDay.day && !date.DateUtils.isExtraDay(day, _initialDay),
            unSelectedTextColor: _unSelectedTextColor,
            /// 日历中的具体日期添加完整语义
            semanticsLabel: DateUtil.formatDate(day, format: DateFormats.zh_y_mo_d),
            onTap: () {
              setState(() {
                _selectedDay = day;
              });
            },
          ),
        ),
      );
    });
    return dayWidgets;
  }

  List<Widget> _builderYearCalendar() {
    final List<Widget> monthWidgets = [];
    _monthList.forEach((month) {
      monthWidgets.add(
        Center(
          child: SelectedDateButton(
            '$month月',
            selected: month == _selectedMonth,
            enable: month <= _initialDay.month,
            unSelectedTextColor: _unSelectedTextColor,
            onTap: () {
              setState(() {
                _selectedMonth = month;
              });
            },
          ),
        ),
      );
    });
    return monthWidgets;
  }
  
  List<Widget> _builderWeekCalendar() {
    final List<Widget> dayWidgets = [];
    _weeksDays.forEach((day) {
      dayWidgets.add(
        Center(
          child: SelectedDateButton(
            day.day.toString().padLeft(2, '0'),
            selected: day.day == _selectedWeekDay,
            unSelectedTextColor: _unSelectedTextColor,
            semanticsLabel: DateUtil.formatDate(day, format: DateFormats.zh_y_mo_d),
            onTap: () {
              setState(() {
                _selectedWeekDay = day.day;
              });
            },
          ),
        ),
      );       
    });
    return dayWidgets;
  }
}

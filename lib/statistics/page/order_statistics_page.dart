
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/date_utils.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/selected_text.dart';
import 'package:flutter_deer/widgets/bezier_chart/bezier_chart.dart';
import 'package:date_utils/date_utils.dart' as Date;

/// design/5统计/index.html#artboard1
/// design/5统计/index.html#artboard6
class OrderStatisticsPage extends StatefulWidget {

  const OrderStatisticsPage(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  _OrderStatisticsPageState createState() => _OrderStatisticsPageState();
}

class _OrderStatisticsPageState extends State<OrderStatisticsPage> {
  
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
  List _monthList = [];
  bool _isExpanded = true;
  
  static const List<String> _weeks = const ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];

  @override
  void initState() {
    super.initState();
    _initialDay = DateTime.now();
    _selectedWeekDay = _initialDay.day;
    _selectedDay = _initialDay;
    _selectedMonth = _initialDay.month;
    _weeksDays = Date.Utils.daysInRange(Date.Utils.previousWeek(_initialDay), DateUtils.nextDay(_initialDay)).toList().sublist(1, 8);
    _currentMonthsDays = DateUtils.daysInMonth(_initialDay);
    _monthList.clear();
    for (int i = 1; i < 13; i ++){
      _monthList.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: widget.index == 1 ? "订单统计" : "交易额统计",
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
                  _buildSelectedText(_initialDay.year.toString(), 0),
                  Gaps.hGap12,
                  Container(width: 0.6, height: 24.0, color: Colours.line),
                  Gaps.hGap12,
                  _buildSelectedText("${_initialDay.month.toString()}月", 1),
                  Gaps.hGap12,
                  Container(width: 0.6, height: 24.0, color: Colours.line),
                  Gaps.hGap12,
                  _buildSelectedText("${DateUtils.previousWeek(_initialDay)} -${DateUtils.apiDayFormat(_initialDay)}", 2),
                ],
              ),
              Gaps.vGap16,
              Flexible(
                child: Container(
                  color: const Color(0xFFFAFAFA),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: _selectedIndex != 1 ? 4.0 : 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AnimatedCrossFade(
                        firstChild: _buildGridView(),
                        secondChild:_buildGridView(),
                        firstCurve: const Interval(0.0, 0.0, curve: Curves.fastOutSlowIn),
                        secondCurve: const Interval(0.0, 0.0, curve: Curves.fastOutSlowIn),
                        sizeCurve: Curves.decelerate,
                        crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                      _selectedIndex == 1 ?
                          InkWell(
                            onTap: (){
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Container(
                              height: 27.0,
                              alignment: Alignment.topCenter,
                              child: LoadAssetImage("statistic/${_isExpanded ? "up" : "down"}", width: 16.0,),
                            ),
                          ) : Gaps.empty,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.index == 1 ? "订单走势" : "交易额走势", style: TextStyles.textBoldDark18),
                    Gaps.vGap16,
                    _buildChart(Colours.app_main, const Color(0x805793FA), widget.index == 1 ? "全部订单" : "交易额(元)", "3000"),
                    widget.index != 1 ? Gaps.empty : Column(
                      children: <Widget>[
                        Gaps.vGap16,
                        _buildChart(const Color(0xFFFFAA33), const Color(0x80FFAA33), "完成订单", "2000"),
                        Gaps.vGap16,
                        _buildChart(Colours.text_red, const Color(0x80FF4759), "取消订单", "1000"),
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
  
  _buildChart(Color color, Color shadowColor, String title, String count){
    return AspectRatio(
      aspectRatio: 3,
      child: MyCard(
        color: color,
        shadowColor: shadowColor,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ImageUtils.getAssetImage("statistic/chart_fg"),
                  fit: BoxFit.fill
              )
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(title, style: TextStyle(color: Colors.white)),
                  Text(count, style: TextStyle(color: Colors.white)),
                ],
              ),
              Gaps.vGap4,
              Expanded(
                child: BezierChart(
                  bezierChartScale: BezierChartScale.CUSTOM,
                  xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30],
                  footerValueBuilder: (double value) {return "";},
                  series: [
                    BezierLine(
                      label: widget.index == 1 ? "单" : "元",
                      data: _getRandomData()
                    ),
                  ],
                  config: BezierChartConfig(
                    footerHeight: 0,
                    showVerticalIndicator: false,
                    verticalIndicatorFixedPosition: false,
                    snap: true,
                    backgroundColor: color
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DataPoint> data = [];
  List<DataPoint> data1 = [];
  List<DataPoint> data2 = [];

  // 数据变化图标会刷新，否则不会
  _getRandomData(){
    if (data.isEmpty){
      for (int i = 0; i < 7; i++){
        data.add(DataPoint<double>(value: Random.secure().nextInt(3000).toDouble(), xAxis: (i * 5).toDouble()));
      }
      for (int i = 0; i < 7; i++){
        data1.add(DataPoint<double>(value: Random.secure().nextInt(3000).toDouble(), xAxis: (i * 5).toDouble()));
      }
      for (int i = 0; i < 7; i++){
        data2.add(DataPoint<double>(value: Random.secure().nextInt(3000).toDouble(), xAxis: (i * 5).toDouble()));
      }
    }

    if (_selectedIndex == 0){
      return data;
    }else if(_selectedIndex == 1){
      return data1;
    }else{
      return data2;
    }
  }
  
  _buildGridView(){
    return GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 7,
      children: _buildCalendar(),
    );
  }
  
  _buildCalendar(){
    if (_selectedIndex == 0){
      return _builderMonthCalendar();
    }else if (_selectedIndex == 1){
      return _builderCalendar();
    }else if (_selectedIndex == 2){
      return _builderWeekCalendar();
    }
  }
  
  List<Widget> _buildWeeks(){
    List<Widget> widgets = [];
    _weeks.forEach((str){
      widgets.add(Center(
        child: Text(str, style: TextStyles.textGray12),
      ));
    });
    return widgets;
  }

  List<Widget> _builderCalendar() {
    List<Widget> dayWidgets = [];
    List<DateTime> list;
    if (_isExpanded) {
      list = _currentMonthsDays;
    }else{
      list = DateUtils.daysInWeek(_selectedDay);
    }
    dayWidgets.addAll(_buildWeeks());
    list.forEach((day) {
      dayWidgets.add(
          Center(
            child: SelectedText(
              day.day < 10 ? "0${day.day}" : day.day.toString(),
              selected:(day.day == _selectedDay.day && !DateUtils.isExtraDay(day, _initialDay)),
              // 不是本月的日期与超过当前日期的不可点击
              enable: day.day <= _initialDay.day && !DateUtils.isExtraDay(day, _initialDay),
              onTap: (){
                setState(() {
                  _selectedDay = day;
                });
              },
            ),
          )
      );
    });
    return dayWidgets;
  }

  List<Widget> _builderMonthCalendar() {
    List<Widget> monthWidgets = [];
    _monthList.forEach((month){
      monthWidgets.add(
          Center(
            child: SelectedText(
              "$month月",
              selected: month == _selectedMonth,
              enable: month <= _initialDay.month,
              onTap: (){
                setState(() {
                  _selectedMonth = month;
                });
              },
            ),
          )
      );
    });
    return monthWidgets;
  }
  
  List<Widget> _builderWeekCalendar() {
    List<Widget> dayWidgets = [];
    _weeksDays.forEach((day) {
      dayWidgets.add(
          Center(
            child: SelectedText(
              day.day < 10 ? "0${day.day}" : day.day.toString(),
              selected: day.day == _selectedWeekDay,
              onTap: (){
                setState(() {
                  _selectedWeekDay = day.day;
                });
              },
            ),
          )
      );       
    });
    return dayWidgets;
  }
  
  _buildSelectedText(String text, int index){
    return SelectedText(
      text,
      fontSize: 15.0,
      selected: _selectedIndex == index,
      unSelectedTextColor: Colours.text_normal,
      onTap: (){
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}

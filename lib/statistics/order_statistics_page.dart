
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/date_utils.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/selected_text.dart';
import 'package:flutter_deer/widgets/bezier_chart/bezier_chart.dart';
import 'package:date_utils/date_utils.dart' as Date;

class OrderStatisticsPage extends StatefulWidget {

  const OrderStatisticsPage(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  _OrderStatisticsPageState createState() => _OrderStatisticsPageState();
}

class _OrderStatisticsPageState extends State<OrderStatisticsPage> {
  
  int selectedIndex = 2;
  DateTime initialDay;
  Iterable<DateTime> weeksDays;
  List<DateTime> currentMonthsDays;
  // 周视图中选择的日期
  int selectedWeekDay;
  // 月视图中选择的日期
  DateTime selectedDay;
  // 年视图中选择的月份
  int selectedMonth;
  List monthList = [];
  bool isExpanded = true;
  
  static const List<String> weeks = const ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];

  @override
  void initState() {
    super.initState();
    initialDay = DateTime.now();
    selectedWeekDay = initialDay.day;
    selectedDay = initialDay;
    selectedMonth = initialDay.month;
    weeksDays = Date.Utils.daysInRange(Date.Utils.previousWeek(initialDay), DateUtils.nextDay(initialDay)).toList().sublist(1, 8);
    currentMonthsDays = DateUtils.daysInMonth(initialDay);
    monthList.clear();
    for (int i = 1; i < 13; i ++){
      monthList.add(i);
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
                  Gaps.hGap8,
                  Gaps.hGap16,
                  _buildSelectedText(initialDay.year.toString(), 0),
                  Gaps.hGap16,
                  Container(width: 0.6, height: 24.0, color: Colours.line),
                  Gaps.hGap16,
                  _buildSelectedText("${initialDay.month.toString()}月", 1),
                  Gaps.hGap16,
                  Container(width: 0.6, height: 24.0, color: Colours.line),
                  Gaps.hGap16,
                  _buildSelectedText("${DateUtils.previousWeek(initialDay)} -${DateUtils.apiDayFormat(initialDay)}", 2),
                ],
              ),
              Gaps.vGap16,
              Flexible(
                child: Container(
                  color: Color(0xFFFAFAFA),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: selectedIndex != 1 ? 4.0 : 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AnimatedCrossFade(
                        firstChild: _buildGridView(),
                        secondChild:_buildGridView(),
                        firstCurve: const Interval(0.0, 0.0, curve: Curves.fastOutSlowIn),
                        secondCurve: const Interval(0.0, 0.0, curve: Curves.fastOutSlowIn),
                        sizeCurve: Curves.decelerate,
                        crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                      selectedIndex == 1 ?
                          InkWell(
                            onTap: (){
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Container(
                              height: 27.0,
                              alignment: Alignment.topCenter,
                              child: Image.asset(Utils.getImgPath("statistic/${isExpanded ? "up" : "down"}"), width: 16.0,),
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
                    _buildChart(const Color(0xFF4688FA), const Color(0x805793FA), widget.index == 1 ? "全部订单" : "交易额(元)", "3000"),
                    Offstage(
                      offstage: widget.index != 1,
                      child: Column(
                        children: <Widget>[
                          Gaps.vGap16,
                          _buildChart(const Color(0xFFFFAA33), const Color(0x80FFAA33), "完成订单", "2000"),
                          Gaps.vGap16,
                          _buildChart(const Color(0xFFFF4759), const Color(0x80FF4759), "取消订单", "1000"),
                          Gaps.vGap16,
                        ],
                      ),
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
                  image: AssetImage(Utils.getImgPath("statistic/chart_fg")),
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

    if (selectedIndex == 0){
      return data;
    }else if(selectedIndex == 1){
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
    if (selectedIndex == 0){
      return _builderMonthCalendar();
    }else if (selectedIndex == 1){
      return _builderCalendar();
    }else if (selectedIndex == 2){
      return _builderWeekCalendar();
    }
  }
  
  List<Widget> _buildWeeks(){
    List<Widget> widgets = [];
    weeks.forEach((str){
      widgets.add(Container(
        alignment: Alignment.center,
        child: Text(str, style: TextStyles.textGray12),
      ));
    });
    return widgets;
  }

  List<Widget> _builderCalendar() {
    List<Widget> dayWidgets = [];
    List<DateTime> list;
    if (isExpanded) {
      list = currentMonthsDays;
    }else{
      list = DateUtils.daysInWeek(selectedDay);
    }
    dayWidgets.addAll(_buildWeeks());
    list.forEach((day) {
      dayWidgets.add(
          Container(
            alignment: Alignment.center,
            child: SelectedText(
              day.day < 10 ? "0${day.day}" : day.day.toString(),
              selected:(day.day == selectedDay.day && !DateUtils.isExtraDay(day, initialDay)),
              // 不是本月的日期与超过当前日期的不可点击
              enable: day.day <= initialDay.day && !DateUtils.isExtraDay(day, initialDay),
              onTap: (){
                setState(() {
                  selectedDay = day;
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
    monthList.forEach((month){
      monthWidgets.add(
        Container(
          alignment: Alignment.center,
            child: SelectedText(
              "$month月",
              selected: month == selectedMonth,
              enable: month <= initialDay.month,
              onTap: (){
                setState(() {
                  selectedMonth = month;
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
    weeksDays.forEach((day) {
      dayWidgets.add(
        Container(
          alignment: Alignment.center,
          child: SelectedText(
            day.day < 10 ? "0${day.day}" : day.day.toString(),
            selected: day.day == selectedWeekDay,
            onTap: (){
              setState(() {
                selectedWeekDay = day.day;
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
      selected: selectedIndex == index,
      unSelectedTextColor: Colours.text_normal,
      onTap: (){
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}


import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/pie_chart/pie_data.dart';

///环形图 参考：https://github.com/apgapg/pie_chart
class PieChart extends StatefulWidget {
  
  const PieChart({
    Key key,
    @required this.data,
    @required this.name
  }) : super(key: key);
  
  final List<PieData> data;
  final String name;
  
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> with SingleTickerProviderStateMixin{

  int count;
  Animation<double> animation;
  AnimationController controller;
  double _fraction = 0.0;
  List<PieData> oldData;
  
  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = Tween<double>(begin: 0, end: 1).animate(curve);
    animation.addListener(() {
      setState(() {
        _fraction = animation.value;
      });
    });
    controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(PieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 数据变化时执行动画
    if (oldData != widget.data){
      controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    oldData = widget.data;
    count = 0;
    for (int i = 0; i < widget.data.length; i++){
      count += widget.data[i].number;
    }
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          const BoxShadow(color: Color(0x80C8DAFA), offset: Offset(0.0, 4.0), blurRadius: 8.0, spreadRadius: 0.0),
        ],
      ),
      child: CustomPaint(
        painter: PieChartPainter(
          widget.data,
          _fraction
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.name, style: TextStyles.textBoldDark16),
              Gaps.vGap4,
              Text("$count件", style: TextStyles.textDark14)
            ],
          ),
        ),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  
  PieChartPainter(this.data, double angleFactor) {
    if (data.length == null || data.isEmpty) {
      return;
    }
    int count = 0;
    for (int i = 0; i < data.length; i++){
      count += data[i].number;
    }
    PieData pieData;
    if (data.length == 11){
      // 获取“其他”数据
      pieData = data[10];
      pieData.percentage = pieData.number / count;
      pieData.color = Colours.text_gray_c;
      // 移除“其他”后，按数量排序
      data.removeAt(10);
    }
   
    data.sort((left,right) => right.number.compareTo(left.number));
    // 由大到小给予颜色
    for (int i = 0; i < data.length; i++){
      this.data[i].color = Constant.colorList[i];
      this.data[i].percentage = this.data[i].number / count;
      // 排序后的数据输出
//      print(data[i].toString());
    }
    if (pieData != null){
      data.add(pieData);
    }
    _mPaint = new Paint();
    totalAngle = angleFactor * math.pi * 2;
  }
  
  Rect mCircle;
  Paint _mPaint;
  // 半径
  double mRadius;
  List<PieData> data;
  double totalAngle;

  // 起始角度
  double prevAngle;
  
  @override
  void paint(Canvas canvas, Size size) {
    if (data.length == null || data.isEmpty) {
      return;
    }
    prevAngle = -math.pi;
    mRadius = math.min(size.width, size.height) / 2 - 4;
    // 圆心
    Offset offset = Offset(size.width / 2, size.height / 2);
    mCircle = Rect.fromCircle(center: offset, radius: mRadius);
    
    for (int i = 0; i < data.length; i++){
      _mPaint..color = data[i].color
        ..style = PaintingStyle.fill;
      canvas.drawArc(mCircle, prevAngle, totalAngle * data[i].percentage, true, _mPaint);
      prevAngle = prevAngle + totalAngle * data[i].percentage;
    }
    // 为了文字不被覆盖，在绘制完扇形后绘制文字
    prevAngle = -math.pi;
    for (int i = 0; i < data.length; i++){
      //计算扇形中心点的坐标
      var x = (size.height * 0.74 / 2) * math.cos(prevAngle + (totalAngle * data[i].percentage / 2));
      var y = (size.height * 0.74 / 2) * math.sin(prevAngle + (totalAngle * data[i].percentage / 2));
      // 保留一位小数
      var percentage = ((data[i].percentage * 100).toStringAsFixed(1) + '%');
      drawPercentage(canvas, percentage, x, y, size);
      prevAngle = prevAngle + totalAngle * data[i].percentage;
    }

    canvas.save();
    _mPaint..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offset, mRadius * 0.52, _mPaint);
    
    _mPaint..color = const Color(0x80FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    canvas.drawCircle(offset, mRadius * 0.52, _mPaint);
    
    canvas.restore();
  }

  void drawPercentage(Canvas context, String percentage, double x, double y, Size size) {
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 12.0),
        text: percentage);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.rtl);
    tp.layout();
    tp.paint(context, Offset(size.width / 2 + x - (tp.width / 2), size.height / 2 + y - (tp.height / 2)));
  }
  
  @override
  bool shouldRepaint(PieChartPainter oldDelegate) {
    // 数据不一致时，重新绘制
    return oldDelegate.data != data;
  }
}
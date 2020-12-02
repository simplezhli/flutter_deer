
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/pie_chart/pie_data.dart';

///环形图 参考：https://github.com/apgapg/pie_chart
class PieChart extends StatefulWidget {
  
  const PieChart({
    Key key,
    @required this.data,
    @required this.name
  }) : assert(data != null, 'The [data] argument must not be null.'),
       assert(name != null, 'The [name] argument must not be null.'),
       super(key: key);
  
  final List<PieData> data;
  final String name;
  static const List<Color> colorList = <Color>[
    Color(0xFFFFD147), Color(0xFFA9DAF2), Color(0xFFFAAF64),
    Color(0xFF7087FA), Color(0xFFA0E65C), Color(0xFF5CE6A1), Color(0xFFA364FA),
    Color(0xFFDA61F2), Color(0xFFFA64AE), Color(0xFFFA6464),
  ];
  
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> with SingleTickerProviderStateMixin {

  int count;
  Animation<double> animation;
  AnimationController controller;
  List<PieData> oldData;
  
  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    final Animation<double> curve = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = Tween<double>(begin: 0, end: 1).animate(curve);
    controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(PieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 数据变化时执行动画
    if (oldData != widget.data) {
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
    for (int i = 0; i < widget.data.length; i++) {
      count += widget.data[i].number;
    }
    final Color bgColor = context.backgroundColor;
    final Color shadowColor = context.isDark ? Colours.dark_bg_gray : const Color(0x80C8DAFA);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        boxShadow: <BoxShadow>[
          BoxShadow(color: shadowColor, offset: const Offset(0.0, 4.0), blurRadius: 8.0, spreadRadius: 0.0),
        ],
      ),
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: animation,
          builder: (_, Widget child) {
            return CustomPaint(
              painter: PieChartPainter(
                widget.data,
                animation.value,
                bgColor,
                widget.name,
                count
              ),
              child: child,
            );
          },
          child: Center(
            child: ExcludeSemantics(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(widget.name, style: TextStyles.textBold16),
                  Gaps.vGap4,
                  Text('$count件')
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  
  PieChartPainter(this.data, double angleFactor, this.bgColor, this.name, this.count) {
    if (data.length == null || data.isEmpty) {
      return;
    }
    int count = 0;
    for (int i = 0; i < data.length; i++) {
      count += data[i].number;
    }
    PieData pieData;
    if (data.length == 11) {
      // 获取“其他”数据
      pieData = data[10];
      pieData.percentage = pieData.number / count;
      pieData.color = Colours.text_gray_c;
      // 移除“其他”后，按数量排序
      data.removeAt(10);
    }
   
    data.sort((PieData left,PieData right) => right.number.compareTo(left.number));
    // 由大到小给予颜色
    for (int i = 0; i < data.length; i++) {
      data[i].color = PieChart.colorList[i];
      data[i].percentage = data[i].number / count;
      // 排序后的数据输出
//      print(data[i].toString());
    }
    if (pieData != null) {
      data.add(pieData);
    }
    _mPaint = Paint();
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
  Color bgColor;
  
  // 总数量
  int count;
  // 图表名称
  String name;
  
  @override
  void paint(Canvas canvas, Size size) {
    if (data.length == null || data.isEmpty) {
      return;
    }
    prevAngle = -math.pi;
    mRadius = math.min(size.width, size.height) / 2 - 4;
    // 圆心
    final Offset offset = Offset(size.width / 2, size.height / 2);
    mCircle = Rect.fromCircle(center: offset, radius: mRadius);
    
    for (int i = 0; i < data.length; i++) {
      _mPaint..color = data[i].color
        ..style = PaintingStyle.fill;
      canvas.drawArc(mCircle, prevAngle, totalAngle * data[i].percentage, true, _mPaint);
      prevAngle = prevAngle + totalAngle * data[i].percentage;
    }
    // 为了文字不被覆盖，在绘制完扇形后绘制文字
    prevAngle = -math.pi;
    for (int i = 0; i < data.length; i++) {
      //计算扇形中心点的坐标
      final double x = (size.height * 0.74 / 2) * math.cos(prevAngle + (totalAngle * data[i].percentage / 2));
      final double y = (size.height * 0.74 / 2) * math.sin(prevAngle + (totalAngle * data[i].percentage / 2));
      // 保留一位小数
      final String percentage = (data[i].percentage * 100).toStringAsFixed(1) + '%';
      drawPercentage(canvas, percentage, x, y, size);
      prevAngle = prevAngle + totalAngle * data[i].percentage;
    }

    canvas.save();
    _mPaint..color = bgColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offset, mRadius * 0.52, _mPaint);
    
    _mPaint..color = const Color(0x80FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    canvas.drawCircle(offset, mRadius * 0.52, _mPaint);
    
    canvas.restore();
  }

  void drawPercentage(Canvas context, String percentage, double x, double y, Size size) {
    final TextSpan span = TextSpan(
        style: const TextStyle(color: Colors.white, fontSize: Dimens.font_sp12),
        text: percentage);
    final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.rtl);
    tp.layout();
    tp.paint(context, Offset(size.width / 2 + x - (tp.width / 2), size.height / 2 + y - (tp.height / 2)));
  }
  
  @override
  bool shouldRepaint(PieChartPainter oldDelegate) {
    // 由于动画需要重绘，所以返true。避免重绘，交由RepaintBoundary处理。你也可以判断动画是否执行完成来处理时候重绘
    return true;
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder => _buildSemantics;

  /// 给饼状图上的各个扇形区域添加语义节点(为了便于阅读，将节点区域改为矩形)
  List<CustomPainterSemantics> _buildSemantics(Size size) {
    final List<CustomPainterSemantics> nodes = <CustomPainterSemantics>[];
    final double height = size.height / data.length;
    for (int i = 0; i < data.length; i++) {
      final String percentage = (data[i].percentage * 100).toStringAsFixed(1) + '%';
      final CustomPainterSemantics node = CustomPainterSemantics(
        rect: Rect.fromLTRB(
          0, height * i,
          size.width, height * i + height,
        ),
        properties: SemanticsProperties(
          sortKey: OrdinalSortKey(i.toDouble()),
          label: name + '$count件' + data[i].name + '占比'+ percentage,
          readOnly: true,
          textDirection: TextDirection.ltr,
        ),
        tags: const <SemanticsTag> {
          SemanticsTag('pieChart-label'),
        },
      );
      nodes.add(node);
    }
    return nodes;
  }
}
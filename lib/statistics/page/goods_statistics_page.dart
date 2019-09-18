
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/date_utils.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/pie_chart/pie_chart.dart';
import 'package:flutter_deer/widgets/pie_chart/pie_data.dart';
import 'package:flutter_deer/widgets/selected_text.dart';

/// design/5统计/index.html#artboard11
class GoodsStatisticsPage extends StatefulWidget {

  @override
  _GoodsStatisticsPageState createState() => _GoodsStatisticsPageState();
}

class _GoodsStatisticsPageState extends State<GoodsStatisticsPage> {

  DateTime _initialDay;
  int _selectedIndex = 2;
  /// false 待配货 true 已配货
  bool _type = false;
  
  @override
  void initState() {
    super.initState();
    _initialDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actionName: _type ? "待配货" : "已配货",
        onPressed: (){
          setState(() {
            _type = !_type;
          });
        },
      ),
      body: SingleChildScrollView(
        key: const Key('goods_statistics_list'),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Gaps.vGap4,
                Text(_type ? "已配货" : "待配货", style: TextStyles.textBoldDark24),
                Gaps.vGap16,
                Gaps.vGap16,
                Row(
                  children: <Widget>[
                    _buildSelectedText(_initialDay.year.toString(), 0),
                    Gaps.hGap12,
                    Container(width: 0.6, height: 24.0, color: Colours.line),
                    Gaps.hGap12,
                    _buildSelectedText("${_initialDay.month.toString()}月", 1),
                    Gaps.hGap12,
                    Container(width: 0.6, height: 24.0, color: Colours.line),
                    Gaps.hGap12,
                    _buildSelectedText(_type ? "${DateUtils.previousWeek(_initialDay)} -${DateUtils.apiDayFormat(_initialDay)}" : "${_initialDay.day.toString()}日", 2),
                  ],
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: _buildChart(),
                ),
                const Text("热销商品排行", style: TextStyles.textBoldDark18),
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemExtent: 76.0,
                  itemBuilder: (context, index) => _buildItem(index),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  _buildChart(){
    return AspectRatio(
      aspectRatio: 1.30,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: PieChart(
          name: _type ? "待配货" : "已配货",
          data: _getRandomData(),
        ),
      ),
    );
  }

  List<PieData> data = [];
  List<PieData> data1 = [];

  // 数据为前十名数据与剩余数量
  _getRandomData(){
    if (data.isEmpty){
      for (int i = 0; i < 9; i++){
        PieData pieData = PieData();
        pieData.name = "商品$i";
        pieData.number = Random.secure().nextInt(1000);
        data.add(pieData);
      }
      for (int i = 0; i < 11; i++){
        PieData pieData = PieData();
        if (i == 10){
          pieData.name = "其他";
          pieData.number = Random.secure().nextInt(1000);
          pieData.color = Colours.text_gray_c;
        }else{
          pieData.name = "商品$i";
          pieData.number = Random.secure().nextInt(1000);
        }
        data1.add(pieData);
      }
    }

    if (_type){
      return data;
    }else{
      return data1;
    }
  }
  
  _buildItem(int index){
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: MyCard(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 16.0),
          child: Row(
            children: <Widget>[
              index <= 2 ?
              LoadAssetImage("statistic/${index == 0 ? "champion" : index == 1 ? "runnerup" : "thirdplace"}", width: 40.0,) :
              Container(
                alignment: Alignment.center,
                width: 18.0, height: 18.0,
                margin: const EdgeInsets.symmetric(horizontal: 11.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Constant.colorList[index]
                ),
                child: Text("${index + 1}", style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
              Gaps.hGap4,
              Container(
                height: 36.0, width: 36.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: const Color(0xFFF7F8FA), width: 0.6),
                    image: DecorationImage(
                        image: ImageUtils.getAssetImage("order/icon_goods")
                    )
                ),
              ),
              Gaps.hGap8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("那鲁火多饮料", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colours.text_dark, fontWeight: FontWeight.bold, fontSize: 12.0)),
                    Text("250ml", style: TextStyles.textGray12),
                  ],
                ),
              ),
              Gaps.hGap8,
              Offstage(
                offstage: _type,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("100件", style: TextStyles.textGray12),
                    Text("未支付", style: TextStyles.textGray12),
                  ],
                ),
              ),
              Gaps.hGap16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: _type ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("400件", style: TextStyles.textGray12),
                  Offstage(offstage: _type, child: Text("已支付", style: TextStyles.textGray12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  _buildSelectedText(String text, int index){
    return SelectedText(
      text,
      fontSize: 15.0,
      selected: _type && _selectedIndex == index,
      unSelectedTextColor: Colours.text_normal,
      onTap: _type ? (){
        setState(() {
          _selectedIndex = index;
        });
      } : null,
    );
  }
}

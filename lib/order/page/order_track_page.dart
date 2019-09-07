

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/app_bar.dart';


/// design/3订单/index.html#artboard10
class OrderTrackPage extends StatefulWidget {
  @override
  _OrderTrackPageState createState() => _OrderTrackPageState();
}

class _OrderTrackPageState extends State<OrderTrackPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: "订单跟踪",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 21.0, left: 16.0, right: 16.0),
                child: Text(
                  "订单编号：14562364879",
                  style: TextStyles.textDark14,
                ),
              ),
              Stepper(
                physics: BouncingScrollPhysics(),
                currentStep: 4 - 1,
                controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(); //操作按钮置空
                },
                steps: List.generate(4, (i) => _buildStep(i)),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  var _titleList = ["订单已完成", "开始配送", "等待配送", "收到新订单"];
  var _timeList = ["2018/08/30 13:30", "2018/08/30 11:30", "2018/08/30 9:30", "2018/08/30 9:00"];
  
  Step _buildStep(int index){
    return Step(
      title: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Text(_titleList[index], style: index == 0 ? TextStyles.textMain14 : TextStyles.textDark14),
      ),
      subtitle: Text(_timeList[index], style: index == 0 ? TextStyles.textMain12 : TextStyles.textGray12),
      content: Text(""),
      isActive: index == 0,
      // TODO 这里的状态图标无法修改，暂时使用原生的。应该可以复制Step代码修改一下。
      state: index == 0 ? StepState.complete : StepState.indexed, 
    );
  }
}

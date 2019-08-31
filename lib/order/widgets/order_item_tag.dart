
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';

class OrderItemTag extends StatelessWidget {

  const OrderItemTag({
    Key key,
    @required this.date,
    @required this.orderTotal,
  }) : super(key: key);
  
  final String date;
  final int orderTotal;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
          child: Container(
            height: 34.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                const LoadAssetImage("order/icon_calendar", width: 14.0, height: 14.0),
                Gaps.hGap10,
                Text(
                  date,
                  style: TextStyles.textDark14,
                ),
                Expanded(child: Gaps.empty),
                Text(
                  "$orderTotal单",
                  style: TextStyles.textDark14,
                )
              ],
            ),
          )),
    );
  }
}
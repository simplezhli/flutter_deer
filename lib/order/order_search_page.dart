

import 'package:flutter/material.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/search_bar.dart';

class OrderSearch extends StatefulWidget {
  @override
  _OrderSearchState createState() => _OrderSearchState();
}

class _OrderSearchState extends State<OrderSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        hintText: "请输入手机号或姓名查询",
        onPressed: (text){
          Toast.show("搜索内容：$text");
        },
      ),
      body: Container(
      ),
    );
  }
}

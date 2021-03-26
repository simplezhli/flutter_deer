

import 'package:flutter/material.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/search_bar.dart';

class GoodsSearchPage extends StatefulWidget {

  const GoodsSearchPage({Key key}) : super(key: key);

  @override
  _GoodsSearchPageState createState() => _GoodsSearchPageState();
}

class _GoodsSearchPageState extends State<GoodsSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        hintText: '请输入商品名称查询',
        onPressed: (text) => Toast.show('搜索内容：$text'),
      ),
      body: Container(),
    );
  }
}


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/load_image.dart';


/// design/4商品/index.html#artboard20
class GoodsSortDialog extends StatefulWidget {

  const GoodsSortDialog({
    Key key,
    @required this.onSelected,
  }): super(key: key);

  final Function(String, String) onSelected;
  
  @override
  _GoodsSortDialogState createState() => _GoodsSortDialogState();
}

class _GoodsSortDialogState extends State<GoodsSortDialog> with SingleTickerProviderStateMixin{
  
  int _index = 0;
  TabController _tabController;
  ScrollController _controller = new ScrollController();
  // TabBar不能动态加载，所以初始化3个，其中两个文字置空，点击事件拦截住。
  List<Tab> myTabs = <Tab>[Tab(text: '请选择'), Tab(text: ''), Tab(text: '')];
  List _mGoodsSort = [];
  List _mGoodsSort1 = [];
  List _mGoodsSort2 = [];
  /// 当前列表数据
  List _mList = [];
  /// 三级联动选择的position
  var _positions = [0, 0, 0];
   
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    loadData();
  }

  void loadData() async {
    
    // 数据为固定的三个列表
    rootBundle.loadString('assets/data/sort_0.json').then((value) {
      _mGoodsSort = json.decode(value);
      setState(() {
        _mList = _mGoodsSort;
      });
    });
    rootBundle.loadString('assets/data/sort_1.json').then((value) {
      _mGoodsSort1 = json.decode(value);
    });
    rootBundle.loadString('assets/data/sort_2.json').then((value) {
      _mGoodsSort2 = json.decode(value);
    });
   
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 11.0 / 16.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: const Text(
                    "商品分类",
                    style: TextStyles.textBoldDark16,
                  ),
                ),
                Positioned(
                  child: InkWell(
                    onTap: (){
                      NavigatorUtils.goBack(context);
                    },
                    child: const SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: const LoadAssetImage("goods/icon_dialog_close")
                    ),
                  ),
                  right: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                )
              ],
            ),
            Gaps.line,
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                onTap: (index){
                  if (myTabs[index].text.isEmpty){
                    _tabController.animateTo(_index);
                    return;
                  }
                  switch(index){
                    case 0:
                      _mList = _mGoodsSort;
                      break;
                    case 1:
                      _mList = _mGoodsSort1;
                      break;
                    case 2:
                      _mList = _mGoodsSort2;
                      break;
                  }
                  setState(() {
                    _index = index;
                    _controller.animateTo(_positions[_index] * 48.0, duration: Duration(milliseconds: 10), curve: Curves.ease);
                  });
                },
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colours.text_dark,
                labelColor: Colours.app_main,
                tabs: myTabs,
              ),
            ),
            Gaps.line,
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemExtent: 48.0,
                itemBuilder: (_, index){
                  return InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Text(
                              _mList[index]["name"],
                            style: _mList[index]["name"] == myTabs[_index].text ? TextStyles.textMain14 : TextStyles.textDark14),
                          Gaps.hGap8,
                          Offstage(
                            offstage: _mList[index]["name"] != myTabs[_index].text,
                            child: const LoadAssetImage("goods/xz", height: 16.0, width: 16.0),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      myTabs[_index] = Tab(text: _mList[index]["name"]);
                      _positions[_index] = index;
                      _index++;
                      switch(_index){
                        case 1:
                          _mList = _mGoodsSort1;
                          myTabs[1] = Tab(text: "请选择");
                          myTabs[2] = Tab(text: "");
                          break;
                        case 2:
                          _mList = _mGoodsSort2;
                          myTabs[2] = Tab(text: "请选择");
                          break;
                        case 3:
                          _mList = _mGoodsSort2;
                          break;
                      }
                      setState(() {
                        if (_index > 2){
                          _index = 2;
                          widget.onSelected(_mList[index]["id"], _mList[index]["name"]);
                          NavigatorUtils.goBack(context);
                        }
                      });
                      _controller.animateTo(0.0, duration: Duration(milliseconds: 100), curve: Curves.ease);
                      _tabController.animateTo(_index);
                    },
                  );
                },
                itemCount: _mList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoodsSortProvider extends ChangeNotifier {

  int _index = 0;
  int get index => _index;

  // TabBar初始化3个，其中两个文字置空。
  List<Tab> _myTabs = <Tab>[Tab(text: '请选择'), Tab(text: ''), Tab(text: '')];
  get myTabs => _myTabs;

  List _mGoodsSort = [];
  List _mGoodsSort1 = [];
  List _mGoodsSort2 = [];

  /// 当前列表数据
  List _mList = [];
  get mList => _mList;

  /// 三级联动选择的position
  var _positions = [0, 0, 0];
  get positions => _positions;


  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void indexIncrement() {
    _index ++;
  }

  void setList(int index) {
    switch(index) {
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
  }

  void setListAndChangeTab() {
    switch(index) {
      case 1:
        _mList = _mGoodsSort1;
        _myTabs[1] = Tab(text: '请选择');
        _myTabs[2] = Tab(text: '');
        break;
      case 2:
        _mList = _mGoodsSort2;
        _myTabs[2] = Tab(text: '请选择');
        break;
      case 3:
        _mList = _mGoodsSort2;
        break;
    }
    notifyListeners();
  }

  void initData() {

    if (_mList.isNotEmpty) {
      return;
    }

    // 模拟数据，数据为固定的三个列表
    rootBundle.loadString('assets/data/sort_0.json').then((value) {
      _mGoodsSort = json.decode(value);
      _mList = _mGoodsSort;
      notifyListeners();
    });
    rootBundle.loadString('assets/data/sort_1.json').then((value) {
      _mGoodsSort1 = json.decode(value);
    });
    rootBundle.loadString('assets/data/sort_2.json').then((value) {
      _mGoodsSort2 = json.decode(value);
    });
  }
}
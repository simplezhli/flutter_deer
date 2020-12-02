import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoodsSortProvider extends ChangeNotifier {

  int _index = 0;
  int get index => _index;

  // TabBar初始化3个，其中两个文字置空。
  final List<Tab> _myTabs = <Tab>[const Tab(text: '请选择'), const Tab(text: ''), const Tab(text: '')];
  List<Tab> get myTabs => _myTabs;

  List<Object> _mGoodsSort = [];
  List<Object> _mGoodsSort1 = [];
  List<Object> _mGoodsSort2 = [];

  /// 当前列表数据
  List<Object> _mList = [];
  List get mList => _mList;

  /// 三级联动选择的position
  final List<int> _positions = [0, 0, 0];
  List<int> get positions => _positions;


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
        _myTabs[1] = const Tab(text: '请选择');
        _myTabs[2] = const Tab(text: '');
        break;
      case 2:
        _mList = _mGoodsSort2;
        _myTabs[2] = const Tab(text: '请选择');
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
    rootBundle.loadString('assets/data/sort_0.json').then((String value) {
      _mGoodsSort = json.decode(value) as List;
      _mList = _mGoodsSort;
      notifyListeners();
    });
    rootBundle.loadString('assets/data/sort_1.json').then((String value) {
      _mGoodsSort1 = json.decode(value) as List;
    });
    rootBundle.loadString('assets/data/sort_2.json').then((String value) {
      _mGoodsSort2 = json.decode(value) as List;
    });
  }
}
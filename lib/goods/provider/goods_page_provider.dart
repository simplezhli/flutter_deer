import 'package:flutter/material.dart';

class GoodsPageProvider extends ChangeNotifier {

  /// Tab的下标
  int _index = 0;
  int get index => _index;
 
  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }
 
}
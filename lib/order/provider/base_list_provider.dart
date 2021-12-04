import 'package:flutter/material.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

class BaseListProvider<T> extends ChangeNotifier {

  final List<T> _list = <T>[];
  List<T> get list => _list;

  bool hasMore = true;

  StateType stateType = StateType.loading;

  void setStateType(StateType stateType) {
    this.stateType = stateType;
    notifyListeners();
  }

  void add(T data) {
    _list.add(data);
    notifyListeners();
  }

  void addAll(List<T> data) {
    _list.addAll(data);
    notifyListeners();
  }

  void insert(int i, T data) {
    _list.insert(i, data);
    notifyListeners();
  }

  void insertAll(int i, List<T> data) {
    _list.insertAll(i, data);
    notifyListeners();
  }

  void remove(T data) {
    _list.remove(data);
    notifyListeners();
  }

  void removeAt(int i) {
    _list.removeAt(i);
    notifyListeners();
  }

  void clear() {
    _list.clear();
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}


import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// @weilu https://github.com/simplezhli/flutter_deer
/// 
/// 便于管理ChangeNotifier，不用重复写模板代码。
/// 之前：
/// ```dart
/// class TestPageState extends State<TestPage> {
///   final TextEditingController _controller = TextEditingController();
///   final FocusNode _nodeText = FocusNode();
///   
///   @override
///   void initState() {
///     _controller.addListener(callback);
///     super.initState();
///   }
///
///   @override
///   void dispose() {
///     _controller.removeListener(callback);
///     _controller.dispose();
///     _nodeText.dispose();
///     super.dispose();
///   }
/// }
/// ```
/// 使用示例：
/// ```dart
/// class TestPageState extends State<TestPage> with ChangeNotifierMixin<TestPage> {
///   final TextEditingController _controller = TextEditingController();
///   final FocusNode _nodeText = FocusNode();
///
///   @override
///   Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
///     return {
///       _controller: [callback],
///       _nodeText: null,
///     };
///   }
/// }
/// ```
mixin ChangeNotifierMixin<T extends StatefulWidget> on State<T> {

  Map<ChangeNotifier, List<VoidCallback>> _map;

  Map<ChangeNotifier, List<VoidCallback>> changeNotifier();
  
  @override
  void initState() {
    _map = changeNotifier();
    /// 遍历数据，如果callbacks不为空则添加监听
    _map?.forEach((changeNotifier, callbacks) { 
      if (callbacks != null && callbacks.isNotEmpty) {
        callbacks.forEach((callback) {
          changeNotifier?.addListener(callback);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _map?.forEach((changeNotifier, callbacks) {
      if (callbacks != null && callbacks.isNotEmpty) {
        callbacks.forEach((callback) {
          changeNotifier?.removeListener(callback);
        });
      }
      changeNotifier?.dispose();
    });
    super.dispose();
  }
}
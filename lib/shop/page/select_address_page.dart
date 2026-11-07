import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/models/poi_search.dart';
import 'package:flutter_deer/util/log_utils.dart';
import 'package:flutter_deer/util/other_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_search_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 地址选择页面。
/// 原生 flutter_2d_amap 不支持 arm64 模拟器，这里使用 WebView 内嵌高德 JS API 替代，
/// 实现方式与该库 Web 端一致（assets/map/amap.html），页面交互与数据结构保持不变。
class AddressSelectPage extends StatefulWidget {

  const AddressSelectPage({super.key});

  @override
  _AddressSelectPageState createState() => _AddressSelectPageState();
}

class _AddressSelectPageState extends State<AddressSelectPage> {

  List<PoiSearch> _list = [];
  int _index = 0;
  final ScrollController _controller = ScrollController();
  WebViewController? _webController;

  @override
  void initState() {
    super.initState();
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('AMapFlutter', onMessageReceived: (JavaScriptMessage message) {
        _handleMessage(message.message);
      })
      ..loadFlutterAsset('assets/map/amap.html');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleMessage(String raw) {
    try {
      final Map<String, dynamic> message = jsonDecode(raw) as Map<String, dynamic>;
      switch (message['type']) {
        case 'poi':
          final List<dynamic> data = message['data'] as List<dynamic>? ?? <dynamic>[];
          _index = 0;
          setState(() {
            _list = data
                .map((dynamic e) => PoiSearch.fromJsonMap(e as Map<String, dynamic>))
                .toList();
          });
          _controller.animateTo(0.0, duration: const Duration(milliseconds: 10), curve: Curves.ease);
        case 'error':
          Log.d('amap: ${message['message']}');
      }
    } catch (e) {
      Log.e('amap message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MySearchBar(
        hintText: '搜索地址',
        onPressed: (text) {
          _index = 0;
          _webController?.runJavaScript('typeof searchPoi === "function" && searchPoi(${jsonEncode(text)})');
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: WebViewWidget(controller: _webController!),
            ),
            Expanded(
              flex: 11,
              child:
//            _list.isEmpty ?
//              Container(
//                alignment: Alignment.center,
//                child: CircularProgressIndicator(),
//              ) :
              ListView.separated(
                controller: _controller,
                itemCount: _list.length,
                separatorBuilder: (_, index) => const Divider(),
                itemBuilder: (_, index) {
                  return _AddressItem(
                    isSelected: _index == index,
                    date: _list[index],
                    onTap: () {
                      _index = index;
                      _webController?.runJavaScript(
                        'typeof moveTo === "function" && moveTo(${jsonEncode(_list[index].latitude)}, ${jsonEncode(_list[index].longitude)})',
                      );
                      setState(() {
                      });
                    },
                  );
                },
              ),
            ),
            MyButton(
              onPressed: () {
                if (_list.isEmpty) {
                  Toast.show('未选择地址！');
                  return;
                }
                NavigatorUtils.goBackWithParams(context, _list[_index]);
              },
              text: '确认选择地址',
            )
          ],
        ),
      ),
    );
  }
}

class _AddressItem extends StatelessWidget {

  const _AddressItem({
    required this.date,
    this.isSelected = false,
    this.onTap,
  });

  final PoiSearch date;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '${date.provinceName.nullSafe} ${date.cityName.nullSafe} ${date.adName.nullSafe} ${date.title.nullSafe}',
              ),
            ),
            Visibility(
              visible: isSelected,
              child: const Icon(Icons.done, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}

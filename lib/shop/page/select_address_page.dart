
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/search_bar.dart';

class AddressSelectPage extends StatefulWidget {

  const AddressSelectPage({Key key}) : super(key: key);

  @override
  _AddressSelectPageState createState() => _AddressSelectPageState();
}

class _AddressSelectPageState extends State<AddressSelectPage> {
  
  List<PoiSearch> _list = [];
  int _index = 0;
  final ScrollController _controller = ScrollController();
  AMap2DController _aMap2DController;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    /// 配置key
    Flutter2dAMap.setApiKey(
      iOSKey: '4327916279bf45a044bb53b947442387',
      webKey: '4e479545913a3a180b3cffc267dad646',
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchBar(
        hintText: '搜索地址',
        onPressed: (text) {
          _controller.animateTo(0.0, duration: const Duration(milliseconds: 10), curve: Curves.ease);
          _index = 0;
          if (_aMap2DController != null) {
            _aMap2DController.search(text);
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: AMap2DView(
                onPoiSearched: (result) {
                  _controller.animateTo(0.0, duration: const Duration(milliseconds: 10), curve: Curves.ease);
                  _index = 0;
                  _list = result;
                  setState(() {
                   
                  });
                },
                onAMap2DViewCreated: (controller) {
                  _aMap2DController = controller;
                },
              ),
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
                      if (_aMap2DController != null) {
                        _aMap2DController.move(_list[index].latitude, _list[index].longitude);
                      }
                      setState(() {
                      });
                    },
                  );
                },
              ),
            ),
            MyButton(
              onPressed: () {
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
    Key key,
    @required this.date,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final PoiSearch date;
  final bool isSelected;
  final GestureTapCallback onTap;
  
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
                date.provinceName + ' ' +
                date.cityName + ' ' +
                date.adName + ' ' +
                date.title,
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


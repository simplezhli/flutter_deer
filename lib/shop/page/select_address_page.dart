
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/search_bar.dart';

class AddressSelectPage extends StatefulWidget {
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
    /// iOS配置key
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      Flutter2dAMap.setApiKey('4327916279bf45a044bb53b947442387');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchBar(
        hintText: '搜索地址',
        onPressed: (text) {
          _controller.animateTo(0.0, duration: Duration(milliseconds: 10), curve: Curves.ease);
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
                  _controller.animateTo(0.0, duration: Duration(milliseconds: 10), curve: Curves.ease);
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
                  shrinkWrap: true,
                  itemCount: _list.length,
                  separatorBuilder: (_, index) {
                    return const Divider();
                  },
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        _index = index;
                        if (_aMap2DController != null) {
                          _aMap2DController.move(_list[index].latitude, _list[index].longitude);
                        }
                        setState(() {
                        });
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 50.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _list[index].provinceName + ' ' +
                                    _list[index].cityName + ' ' +
                                    _list[index].adName + ' ' +
                                    _list[index].title,
                              ),
                            ),
                            Visibility(
                              visible: _index == index,
                              child: const Icon(Icons.done, color: Colors.blue)
                            )
                          ],
                        ),
                      ),
                    );
                  }
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

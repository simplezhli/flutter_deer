
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/account/models/city_entity.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:azlistview/azlistview.dart';

/// design/6店铺-账户/index.html#artboard34
class CitySelectPage extends StatefulWidget {
  @override
  _CitySelectPageState createState() => _CitySelectPageState();
}

class _CitySelectPageState extends State<CitySelectPage> {

  final List<CityEntity> _cityList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    // 获取城市列表
    // loadString源码中有对json大小进行判断，json过大会使用compute处理，集成测试无法使用compute，所以这里修改源码单独判断处理。
    String jsonStr;
    if (Constant.isDriverTest) {
      jsonStr = await _loadString('assets/data/city.json');
    } else {
      jsonStr = await rootBundle.loadString('assets/data/city.json');
    }
    List list = json.decode(jsonStr);
    list.forEach((value) {
      _cityList.add(CityEntity().fromJson(value));
    });
    setState(() {

    });
  }

  /// rootBundle.loadString源码修改
  Future<String> _loadString(String key, { bool cache = true }) async {
    final ByteData data = await rootBundle.load(key);
    if (data == null) {
      throw FlutterError('Unable to load asset: $key');
    }
    return utf8.decode(data.buffer.asUint8List());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '开户地点',
      ),
      body: SafeArea(
        child: AzListView(
          data: _cityList,
          itemBuilder: (context, model) => _buildListItem(model),
          isUseRealIndex: true,
          itemHeight: 40,
          suspensionWidget: null,
          suspensionHeight: 0,
          indexBarBuilder:(context, list, onTouch) {
            return IndexBar(
              onTouch: onTouch,
              data: list,
              itemHeight: 18,
              touchDownColor: Colors.transparent,
              textStyle: Theme.of(context).textTheme.subtitle2,
              touchDownTextStyle: ThemeUtils.isDark(context) ? TextStyles.textSize12 : const TextStyle(fontSize: 12.0, color: Colors.black),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListItem(CityEntity model) {
    return InkWell(
      onTap: () => NavigatorUtils.goBackWithParams(context, model),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 34.0),
        height: 40.0,
        child: Container(
          decoration: BoxDecoration(
            border: (model.isShowSuspension && model.cityCode != '0483') ? Border(
              top: Divider.createBorderSide(context, width: 0.6),
            ) : null
          ),
          child: Row(
            children: <Widget>[
              Opacity(
                opacity: model.isShowSuspension ? 1 : 0,
                child: SizedBox(
                  width: 28.0,
                  child: Text(model.firstCharacter),
                )
              ),
              Expanded(
                child: Text(model.name),
              )
            ],
          ),
        ),
      ),
    );
  }
}

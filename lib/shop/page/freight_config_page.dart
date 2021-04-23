import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/models/freight_config_model.dart';
import 'package:flutter_deer/shop/widgets/price_input_dialog.dart';
import 'package:flutter_deer/shop/widgets/range_price_input_dialog.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_card.dart';


/// design/7店铺-店铺配置/index.html
class FreightConfigPage extends StatefulWidget {

  const FreightConfigPage({Key? key}) : super(key: key);

  @override
  _FreightConfigPageState createState() => _FreightConfigPageState();
}

class _FreightConfigPageState extends State<FreightConfigPage> {
  
  final List<FreightConfigModel> _list = [];
  
  @override
  void initState() {
    super.initState();
    _reset();
  }

 void  _reset() {
    _list.clear();
    _list.add(FreightConfigModel('0', '', 1, false, ''));
    _list.add(FreightConfigModel('', '', 1, true, ''));
    _list.add(FreightConfigModel('', '-1', 1, false, ''));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: '运费比例配置',
        actionName: '重置',
        onPressed: () {
          setState(() {
            _reset();
          });
        },
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 8.0,
              child: MyButton(
                onPressed: () {
                  NavigatorUtils.goBack(context);
                },
                text: '完成',
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              bottom: 64.0,
              child: ListView.builder(
                itemExtent: 114.0,
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                itemBuilder: (_, index) => _buildItem(index),
                itemCount: _list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // 暂时没有对输入数据进行校验
  Widget _buildItem(int index) {
    return _list[index].isAdd ?
    Semantics(
      label: '添加区间',
      child: GestureDetector(
        onTap: () {
          final FreightConfigModel config = _list[index - 1];
          if (config.max.isNotEmpty && config.min.isNotEmpty) {
            setState(() {
              _list.insert(_list.length - 2, FreightConfigModel('', '', 1, false, ''));
            });
          } else {
            Toast.show('请先完善上一个区间金额！');
            return;
          }
        },
        child: Container(
          key: const Key('add'),
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          decoration: BoxDecoration(
            color: context.isDark ? Colours.dark_bg_gray : Colours.bg_gray,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const LoadAssetImage('shop/tj',),
        ),
      ),
    ) :
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: MyCard(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(index == 0 ? '订单金额小于' : (index == _list.length - 1 ? '订单金额不小于' : '订单金额区间')),
                  Expanded(
                    child: Semantics(
                      label: '填写订单金额',
                      child: InkWell(
                        onTap: () {
                          if (index == 0 || index == _list.length - 1) {
                            _showOrderPriceInputDialog(index);
                          } else {
                            _showRangePriceInputDialog(index);
                          }
                        },
                        child: Text(
                          _getPriceText(index).isEmpty ? '订单金额' : _getPriceText(index),
                          key: Key('订单金额$index'),
                          textAlign: TextAlign.end,
                          style: _getPriceText(index).isEmpty ? Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14) : null,
                        ),
                      ),
                    )),
                  Gaps.hGap5,
                  const Text('元'),
                ],
              ),
              Gaps.vGap15,
              Gaps.line,
              Gaps.vGap15,
              Row(
                children: <Widget>[
                  Semantics(
                    label: '选择比率',
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _list[index].type = 1;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          LoadAssetImage(_list[index].type == 1 ? 'shop/xzyf' : 'shop/wxzyf', width: 16.0,),
                          Gaps.hGap4,
                          const Text('比率'),
                        ],
                      ),
                    ),
                  ),
                  Gaps.hGap16,
                  Semantics(
                    label: '选择金额',
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _list[index].type = 0;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          LoadAssetImage(_list[index].type == 0 ? 'shop/xzyf' : 'shop/wxzyf', width: 16.0),
                          Gaps.hGap4,
                          const Text('金额'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Semantics(
                      label: '填写${_list[index].type == 1 ? '运费比率' : '运费金额'}',
                      child: InkWell(
                        onTap: () => _showFreightInputDialog(index),
                        child: Text(
                          _list[index].price.isEmpty ? (_list[index].type == 1 ? '运费比率' : '运费金额'): _list[index].price,
                          textAlign: TextAlign.end,
                          style: _list[index].price.isEmpty ? Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14) : null,
                        ),
                      ),
                    )),
                  Gaps.hGap5,
                  Text(_list[index].type == 1 ? '%' : '元'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderPriceInputDialog(int index) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PriceInputDialog(
          title: '订单金额',
          onPressed: (value) {
            setState(() {
              if (index == 0) {
                _list[index].max = value;
              } else {
                _list[index].min = value;
              }
            });
          },
        );
      }
    );
  }

  void _showRangePriceInputDialog(int index) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RangePriceInputDialog(
          title: '订单金额',
          onPressed: (min, max) {
            setState(() {
              _list[index].min = min;
              _list[index].max = max;
            });
          },
        );
      }
    );
  }

  void _showFreightInputDialog(int index) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PriceInputDialog(
          title: _list[index].type == 1 ? '运费比率' : '运费金额',
          inputMaxPrice: _list[index].type == 1 ? 100 : 100000,
          onPressed: (value) {
            setState(() {
              _list[index].price = value;
            });
          },
        );
      }
    );
  }
  
  String _getPriceText(int index) {
    if (index == 0) {
      if (_list[index].max.isEmpty) {
        return '';
      } else {
        return _list[index].max;
      }
    } else if (index == _list.length - 1) {
      if (_list[index].min.isEmpty) {
        return '';
      } else {
        return _list[index].min;
      }
    } else {
      if (_list[index].min.isEmpty || _list[index].max.isEmpty) {
        return '';
      } else {
        return _list[index].min + '~' + _list[index].max;
      }
    }
  }
}

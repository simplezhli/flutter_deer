
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/account/models/bank_entity.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter_deer/widgets/load_image.dart';

/// design/6店铺-账户/index.html#artboard33
class BankSelectPage extends StatefulWidget {
  
  const BankSelectPage({Key key, this.type}) : super(key: key);
  
  final int type;
  
  @override
  _BankSelectPageState createState() => _BankSelectPageState();
}

class _BankSelectPageState extends State<BankSelectPage> {

  final List<BankEntity> _bankList = [];
  final List<String> _bankNameList = [
    '工商银行', '建设银行', '中国银行', '农业银行', 
    '招商银行', '交通银行', '中信银行', '民生银行', 
    '兴业银行', '浦发银行'
  ];
  final List<String> _bankLogoList = [
    'gongshang', 'jianhang', 'zhonghang', 'nonghang', 
    'zhaohang', 'jiaohang', 'zhongxin', 'minsheng',
    'xingye', 'pufa'
  ];
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // 获取城市列表
    rootBundle.loadString(widget.type == 0 ? 'assets/data/bank.json' : 'assets/data/bank_2.json').then((value) {
      List list = json.decode(value);
      list.forEach((value) {
        _bankList.add(BankEntity().fromJson(value));
      });
      SuspensionUtil.sortListBySuspensionTag(_bankList);
      setState(() {
       
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.type == 0 ? '开户银行' : '选择支行',
      ),
      body: SafeArea(
        child: AzListView(
          data: _bankList,
          itemBuilder: (context, model) => _buildListItem(model),
          isUseRealIndex: true,
          itemHeight: 40,
          suspensionWidget: null,
          suspensionHeight: 0,
          indexBarBuilder:(context, list, onTouch) {
            return IndexBar(
              onTouch: onTouch,
              data: list,
              itemHeight: 25,
              touchDownColor: Colors.transparent,
              textStyle: Theme.of(context).textTheme.subtitle2,
              touchDownTextStyle: ThemeUtils.isDark(context) ? TextStyles.textSize12 : const TextStyle(fontSize: 12.0, color: Colors.black),
            );
          },
          header: widget.type == 0 ? AzListViewHeader(
            tag: '常用',
            height: 430, 
            builder: (_) => _buildHeader()
          ) : null,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 16.0),
          child: Text('常用', style: Theme.of(context).textTheme.subtitle2),
        ),
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemExtent: 40.0,
            itemCount: _bankNameList.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () => NavigatorUtils.goBackWithParams(context, BankEntity(id: 0, bankName: _bankNameList[index], firstLetter: '')),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      LoadAssetImage('account/${_bankLogoList[index]}',width: 24.0),
                      Gaps.hGap8,
                      Text(_bankNameList[index]),
                    ],
                  ),
                ),
              );
            }
          ),
        )
      ],
    );
  }

  Widget _buildListItem(BankEntity model) {
    return InkWell(
      onTap: () => NavigatorUtils.goBackWithParams(context, model),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 34.0),
        height: 40.0,
        child: Container(
          decoration: BoxDecoration(
            border: (model.isShowSuspension && model.id != 17749) ? Border(
              top: Divider.createBorderSide(context, width: 0.6),
            ) : null
          ),
          child: Row(
            children: <Widget>[
              Opacity(
                opacity: model.isShowSuspension ? 1 : 0,
                child: SizedBox(
                  width: 28.0,
                  child: Text(model.firstLetter),
                )
              ),
              Expanded(
                child: Text(model.bankName),
              )
            ],
          ),
        ),
      ),
    );
  }
}

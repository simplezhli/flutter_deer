
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';

import 'models/withdrawal_account_model.dart';

class WithdrawalAccountListPage extends StatefulWidget {
  @override
  _WithdrawalAccountListPageState createState() => _WithdrawalAccountListPageState();
}

class _WithdrawalAccountListPageState extends State<WithdrawalAccountListPage> {
  
  int selectIndex = 0;
  List<WithdrawalAccountModel> list = [];
  
  @override
  void initState() {
    super.initState();
    list.clear();
    list.add(WithdrawalAccountModel("尾号5236 李艺", "工商银行", 0, "123"));
    list.add(WithdrawalAccountModel("唯鹿", "微信", 1, ""));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: "选择账号",
        actionName: "添加",
        onPressed: (){}
      ),
      body: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (_, index) {
          return Divider(height: 0.6);
        },
        itemBuilder: (_, index){
          return InkWell(
            onTap: (){
              Navigator.pop(context, list[index]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              height: 74.0,
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Image.asset(Utils.getImgPath(list[index].type == 0 ? "account/yhk" : "account/wechat"), width: 24.0),
                  Gaps.hGap16,
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(list[index].typeName, style: TextStyles.textDark14),
                        Gaps.vGap8,
                        Text(list[index].name, style: TextStyles.textDark12),
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: selectIndex != index,
                    child: Image.asset(
                      Utils.getImgPath("account/selected"),
                      height: 24.0,
                      width: 24.0,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

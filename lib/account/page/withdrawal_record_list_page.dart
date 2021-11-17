import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:sticky_headers/sticky_headers.dart';

/// design/6店铺-账户/index.html#artboard19
class WithdrawalRecordListPage extends StatefulWidget {

  const WithdrawalRecordListPage({Key? key}) : super(key: key);

  @override
  _WithdrawalRecordListPageState createState() => _WithdrawalRecordListPageState();
}

class _WithdrawalRecordListPageState extends State<WithdrawalRecordListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '提现记录',
      ),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (_, index) {
          return Semantics(
            /// 将item默认合并的语义拆开，自行组合， 另一种方式见 account_record_list_page.dart
            explicitChildNodes: true,
            child: StickyHeader(
              header: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                color: ThemeUtils.getStickyHeaderColor(context),
                padding: const EdgeInsets.only(left: 16.0),
                height: 34.0,
                child: Text('2021/06/0${index + 1}'),
              ),
              content: _buildItem(index),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildItem(int index) {
    final list = List.generate(index + 1, (i) {
      final Widget content = Stack(
        children: <Widget>[
          Text(i.isEven ? '微信（唯鹿）' : '工商（尾号:4562 李一）'),
          const Positioned(
            top: 0.0,
            right: 0.0,
            child: Text('-10.00', style: TextStyles.textBold14),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Text(i.isEven ? '12:40:20' : '12:50:20', style: Theme.of(context).textTheme.subtitle2),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Text(
              i.isEven ? '审核失败' : '待审核',
              style: i.isEven ? TextStyle(
                fontSize: Dimens.font_sp12,
                color: Theme.of(context).errorColor,
              ) : const TextStyle(
                fontSize: Dimens.font_sp12,
                color: Colours.orange,
              ),
            ),
          ),
        ],
      );

      return Container(
        height: 72.0,
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.8),
          ),
        ),
        child: MergeSemantics(
          child: content,
        ),
      );
    });
    return Column(
      children: list
    );
  }
}

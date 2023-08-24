import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import '../../order/page/order_page.dart';

/// design/6店铺-账户/index.html#artboard19
class WithdrawalRecordListPage extends StatefulWidget {

  const WithdrawalRecordListPage({super.key});

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
      body: CustomScrollView(
        slivers: [
          for (int i = 0; i < 8; i++)
            _buildGroup(i)
        ],
      ),
    );
  }

  Widget _buildGroup(int index) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              color: ThemeUtils.getStickyHeaderColor(context),
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('2021/06/0${index + 1}'),
            )
            , 34.0,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((_, index) {
            return _buildItem(index);
          },
            childCount: index + 1,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(int i) {
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
          child: Text(i.isEven ? '12:40:20' : '12:50:20', style: Theme.of(context).textTheme.titleSmall),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Text(
            i.isEven ? '审核失败' : '待审核',
            style: i.isEven ? TextStyle(
              fontSize: Dimens.font_sp12,
              color: Theme.of(context).colorScheme.error,
            ) : const TextStyle(
              fontSize: Dimens.font_sp12,
              color: Colours.orange,
            ),
          ),
        ),
      ],
    );

    return MergeSemantics(
      child: Container(
        height: 72.0,
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.8),
          ),
        ),
        child: content,
      ),
    );
  }
}

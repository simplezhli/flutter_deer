import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import '../../order/page/order_page.dart';

/// design/6店铺-账户/index.html#artboard1
class AccountRecordListPage extends StatefulWidget {

  const AccountRecordListPage({super.key});

  @override
  _AccountRecordListPageState createState() => _AccountRecordListPageState();
}

class _AccountRecordListPageState extends State<AccountRecordListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '账户流水',
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
    return Container(
      height: 72.0,
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.8),
        ),
      ),
      child: IndexedSemantics(
        index: i,
        child: Stack(
          children: <Widget>[
            Text(i.isEven ? '采购订单结算营收' : '提现'),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Text(i.isEven ? '+10.00' : '-10.00',
                style: i.isEven ? TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ) : TextStyles.textBold14,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Text(i.isEven ? '18:20:10' : '08:20:11', style: Theme.of(context).textTheme.titleSmall),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Text('余额：20.00', style: Theme.of(context).textTheme.titleSmall),
            ),
          ],
        ),
      ),
    );
  }
}

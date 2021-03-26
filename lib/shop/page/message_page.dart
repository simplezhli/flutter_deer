
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/my_card.dart';

/// design/8设置/index.html#artboard2
class MessagePage extends StatefulWidget {

  const MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '消息',
        actionName: '全部已读',
        onPressed: () {},
      ),
      body: Scrollbar( // 加个滚动条
        controller: _scrollController,
        child: ListView.builder(
          itemCount: 20,
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 28.0),
          itemBuilder: (_, __) => _MessageItem(),
        ),
      ),
    );
  }
}


class _MessageItem extends StatefulWidget {
  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<_MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Gaps.vGap15,
        Text('2021-5-31 17:19:36', style: Theme.of(context).textTheme.subtitle2),
        Gaps.vGap8,
        MyCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Expanded(child: Text('系统通知')),
                    Container(
                      margin: const EdgeInsets.only(right: 4.0),
                      height: 8.0,
                      width: 8.0,
                      decoration: BoxDecoration(
                        color: Colours.app_main,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    Images.arrowRight,
                  ],
                ),
                Gaps.vGap8,
                Gaps.line,
                Gaps.vGap8,
                const Text('供货商由于[商品缺货]原因，取消了采购订单。', style: TextStyles.textSize12),
              ],
            ),
          ),
        )
      ],
    );
  }
}

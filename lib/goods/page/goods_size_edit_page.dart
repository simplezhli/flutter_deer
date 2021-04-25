import 'package:flutter/material.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/widgets/selected_image.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

/// design/4商品/index.html#artboard14
class GoodsSizeEditPage extends StatefulWidget {

  const GoodsSizeEditPage({Key? key}) : super(key: key);

  @override
  _GoodsSizeEditPageState createState() => _GoodsSizeEditPageState();
}

class _GoodsSizeEditPageState extends State<GoodsSizeEditPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '规格分类',
      ),
      body: MyScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: <Widget>[
          Gaps.vGap5,
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('基本信息', style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          const Center(
            child: SelectedImage(
              size: 96.0,
            ),
          ),
          Gaps.vGap8,
          Center(
            child: Text(
              '点击添加分类图片',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14),
            ),
          ),
          Gaps.vGap16,
          const TextFieldItem(
            title: '分类名称',
            hintText: '填写该分类名称',
          ),
          const TextFieldItem(
            title: '折后价格',
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            hintText: '填写该分类折后价格',
          ),
          const TextFieldItem(
            title: '库存数量',
            hintText: '填写该分类库存数量',
            keyboardType: TextInputType.number
          ),
          const TextFieldItem(
            title: '佣金金额',
            keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          const TextFieldItem(
            title: '起购数量',
            keyboardType: TextInputType.number
          ),
          Gaps.vGap32,
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('折扣立减', style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          const TextFieldItem(
            title: '立减金额',
            keyboardType: TextInputType.number,
          ),
          const TextFieldItem(
            title: '抵扣金额',
            keyboardType: TextInputType.number,
          ),
          Gaps.vGap8,
        ],
        bottomButton: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyButton(
            onPressed: () => NavigatorUtils.goBack(context),
            text: '确定',
          ),
        ),
      )
    );
  }
  
}

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/screen_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:vibration/vibration.dart';

/// design/6店铺-账户/index.html#artboard13
class WithdrawalPasswordSetting extends StatefulWidget {

  const WithdrawalPasswordSetting({Key? key}) : super(key: key);

  @override
  _WithdrawalPasswordSettingState createState() => _WithdrawalPasswordSettingState();
}

class _WithdrawalPasswordSettingState extends State<WithdrawalPasswordSetting> {

  int _index = 0;
  final _list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0];
  final List<String> _codeList = ['', '', '', '', '', ''];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.dialogBackgroundColor,
      height: context.height * 7 / 10.0,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: const Text(
                  '设置提现密码',
                  style: TextStyles.textBold18,
                ),
              ),
              Positioned(
                right: 16.0,
                top: 16.0,
                bottom: 16.0,
                child: Semantics(
                  label: '关闭',
                  child: GestureDetector(
                    onTap: () => NavigatorUtils.goBack(context),
                    child: const LoadAssetImage(
                      'goods/icon_dialog_close',
                      key: Key('close'),
                      width: 16.0,
                      height: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 45.0,
                  margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.6, color: Colours.text_gray_c),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: List.generate(_codeList.length, (i) => _buildInputWidget(i))
                  ),
                ),
                Gaps.vGap10,
                Text('提现密码不可为连续、重复的数字。', style: Theme.of(context).textTheme.subtitle2),
              ],
            ),
          ),
          Gaps.line,
          Container(
            color: Theme.of(context).dividerTheme.color,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.953,
                mainAxisSpacing: 0.6,
                crossAxisSpacing: 0.6,
              ),
              itemCount: 12,
              itemBuilder: (_, index) => _buildButton(index)
            ),
          ),
        ],
      )
    );
  }

  Widget _buildButton(int index) {
    final color = context.isDark ? Colours.dark_bg_gray : Colours.dark_button_text;
    return Material(
      color: (index == 9 || index == 11) ? color : null,
      child: InkWell(
        child: Center(
          child: index == 11 ? Semantics(
            label: '删除',
            child: const LoadAssetImage('account/del', width: 32.0),
          ) : index == 9 ? Semantics(
            label: '无效',
            child: Gaps.empty,
          ) : Text(
            _list[index].toString(),
            style: const TextStyle(fontSize: 26.0),
          ),
        ),
        onTap: () async {
          if (index == 9) {
            return;
          }

          /// 点击时给予振动反馈
          if (!Device.isDesktop && (await Vibration.hasVibrator() ?? false)) {
            Vibration.vibrate(duration: 10);
          }

          if (index == 11) {
            if (_index == 0) {
              return;
            }
            _codeList[_index - 1] = '';
            _index--;
            setState(() {

            });
            return;
          }
          _codeList[_index] = _list[index].toString();
          _index++;
          if (_index == _codeList.length) {

            var code = '';
            for (var i = 0; i < _codeList.length; i ++) {
              code = code + _codeList[i];
            }
            Toast.show('密码：$code');
            _index = 0;
            for (var i = 0; i < _codeList.length; i ++) {
              _codeList[i] = '';
            }
          }
          setState(() {

          });
        },
      ),
    );
  }

  Widget _buildInputWidget(int p) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: p != 5 ? Border(
            right: Divider.createBorderSide(context, color: Colours.text_gray_c, width: 0.6),
          ) : null,
        ),
        child: Text(_codeList[p].isEmpty ? '' : '●', style: TextStyles.textSize12,),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class WithdrawalPasswordSettingDialog extends StatefulWidget {
  @override
  _WithdrawalPasswordSettingDialogState createState() => _WithdrawalPasswordSettingDialogState();
}

class _WithdrawalPasswordSettingDialogState extends State<WithdrawalPasswordSettingDialog> {
  
  var _list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0];
  
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 7 / 10.0,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: const Text(
                          "设置提现密码",
                          style: TextStyles.textBoldDark18,
                        ),
                      ),
                      Positioned(
                        right: 16.0,
                        top: 16.0,
                        bottom: 16.0,
                        child: InkWell(
                          onTap: (){
                            NavigatorUtils.goBack(context);
                          },
                          child: const SizedBox(
                            height: 16.0,
                            width: 16.0,
                            child: const LoadAssetImage("goods/icon_dialog_close")
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
                        const Text(("提现密码不可为连续、重复的数字。"), style: TextStyles.textGray12),
                      ],
                    ),
                  ),
                  Gaps.line,
                  Container(
                    color: Colours.line,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.953,
                        mainAxisSpacing: 0.6,
                        crossAxisSpacing: 0.6
                      ),
                      itemCount: 12,
                      itemBuilder: (_, index){
                        return Material(
                          color: (index == 9 || index == 11) ? const Color(0xFFF2F2F2) : Colors.white,
                          child: InkWell(
                            child: Center(
                              child: index == 11 ? const LoadAssetImage("account/del", width: 32.0) : index == 9 ? Gaps.empty :
                              Text(_list[index].toString(), style: TextStyle(
                                  color: Colours.text_dark,
                                  fontSize: 26.0
                              )),
                            ),
                            onTap: (){
                              if(index == 9){
                                return;
                              }
                              if(index == 11){
                                if (_index == 0){
                                  return;
                                }
                                _codeList[_index - 1] = "";
                                _index--;
                                setState(() {

                                });
                                return;
                              }
                              _codeList[_index] = _list[index].toString();
                              _index++;
                              if (_index == _codeList.length){

                                String code = "";
                                for (int i = 0; i < _codeList.length; i ++){
                                  code = code + _codeList[i];
                                }
                                Toast.show("密码：$code");
                                _index = 0;
                                for (int i = 0; i < _codeList.length; i ++){
                                  _codeList[i] = "";
                                }
                              }
                              setState(() {

                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ],
            )),
          )
        ],
      ),
    );
  }

  int _index = 0;
  List<String> _codeList = ["", "", "", "", "", ""];

  Widget _buildInputWidget(int p){
    return Expanded(
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: p != 5 ? Border(
                right: Divider.createBorderSide(context, color: Colours.text_gray_c, width: 0.6),
              ) : null
          ),
          child: Text(_codeList[p].isEmpty ? "" : "●", style: TextStyles.textDark12,)
      ),
    );
  }
}

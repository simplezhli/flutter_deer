
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';

/// 自定义dialog的模板
class BaseDialog extends StatelessWidget {

  const BaseDialog({
    Key key,
    this.title,
    this.onPressed,
    this.hiddenTitle : false,
    @required this.child
  }) : super(key : key);

  final String title;
  final Function onPressed;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 270.0,
            child: Material(
              borderRadius: BorderRadius.circular(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Gaps.vGap24,
                  Visibility(
                    visible: !hiddenTitle,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        hiddenTitle ? '' : title,
                        style: TextStyles.textBold18,
                      ),
                    ),
                  ),
                  Flexible(child: child),
                  Gaps.vGap8,
                  Gaps.line,
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 48.0,
                          child: FlatButton(
                            child: const Text(
                              '取消',
                              style: TextStyle(
                                  fontSize: Dimens.font_sp18
                              ),
                            ),
                            textColor: Colours.text_gray,
                            onPressed: () {
                              NavigatorUtils.goBack(context);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 48.0,
                        width: 0.6,
                        child: const VerticalDivider(),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 48.0,
                          child: FlatButton(
                            child: const Text(
                              '确定',
                              style: TextStyle(
                                  fontSize: Dimens.font_sp18
                              ),
                            ),
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () {
                              onPressed();
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
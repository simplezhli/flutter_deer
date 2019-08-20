import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'dimens.dart';

class TextStyles {
  static const TextStyle textMain12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.app_main,
  );
  static const TextStyle textMain14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.app_main,
  );
  static const TextStyle textNormal12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_normal,
  );
  static const TextStyle textDark12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_dark,
  );
  static const TextStyle textDark14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_dark,
  );
  static const TextStyle textDark16 = const TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_dark,
  );
  static const TextStyle textBoldDark14 = const TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.text_dark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark16 = const TextStyle(
      fontSize: Dimens.font_sp16,
      color: Colours.text_dark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark18 = const TextStyle(
    fontSize: Dimens.font_sp18,
    color: Colours.text_dark,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark24 = const TextStyle(
      fontSize: 24.0,
      color: Colours.text_dark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark26 = const TextStyle(
      fontSize: 26.0,
      color: Colours.text_dark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textGray10 = const TextStyle(
    fontSize: Dimens.font_sp10,
    color: Colours.text_gray,
  );
  static const TextStyle textGray12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_gray,
  );
  static const TextStyle textGray14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray,
  );
  static const TextStyle textGray16 = const TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_gray,
  );
  static const TextStyle textGrayC12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_gray_c,
  );
  static const TextStyle textGrayC14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray_c,
  );
}

/// 间隔
class Gaps {
  /// 水平间隔
  static const Widget hGap5 = const SizedBox(width: Dimens.gap_dp5);
  static const Widget hGap10 = const SizedBox(width: Dimens.gap_dp10);
  static const Widget hGap15 = const SizedBox(width: Dimens.gap_dp15);
  static const Widget hGap16 = const SizedBox(width: Dimens.gap_dp16);
  /// 垂直间隔
  static const Widget vGap5 = const SizedBox(height: Dimens.gap_dp5);
  static const Widget vGap10 = const SizedBox(height: Dimens.gap_dp10);
  static const Widget vGap15 = const SizedBox(height: Dimens.gap_dp15);
  static const Widget vGap50 = const SizedBox(height: Dimens.gap_dp50);

  static const Widget vGap4 = const SizedBox(height: 4.0);
  static const Widget vGap8 = const SizedBox(height: 8.0);
  static const Widget vGap12 = const SizedBox(height: 12.0);
  static const Widget vGap16 = const SizedBox(height: Dimens.gap_dp16);

  static const Widget hGap4 = const SizedBox(width: 4.0);
  static const Widget hGap8 = const SizedBox(width: 8.0);
  static const Widget hGap12 = const SizedBox(width: 12.0);

  static Widget line = const SizedBox(
    height: 0.6,
    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
  );
  static const Widget empty = const SizedBox();
}

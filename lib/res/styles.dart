import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'dimens.dart';

class TextStyles {
  static const TextStyle textMain12 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.app_main,
  );
  static const TextStyle textMain14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.app_main,
  );
  static const TextStyle textNormal12 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_normal,
  );
  static const TextStyle textDark12 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_dark,
  );
  static const TextStyle textDark14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_dark,
  );
  static const TextStyle textDark16 = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_dark,
  );
  static const TextStyle textBoldDark14 = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.text_dark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark16 = TextStyle(
      fontSize: Dimens.font_sp16,
      color: Colours.text_dark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark18 = TextStyle(
    fontSize: Dimens.font_sp18,
    color: Colours.text_dark,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark24 = TextStyle(
      fontSize: 24.0,
      color: Colours.text_dark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark26 = TextStyle(
      fontSize: 26.0,
      color: Colours.text_dark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textGray10 = TextStyle(
    fontSize: Dimens.font_sp10,
    color: Colours.text_gray,
  );
  static const TextStyle textGray12 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_gray,
  );
  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray,
  );
  static const TextStyle textGray16 = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_gray,
  );
  static const TextStyle textGrayC12 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colours.text_gray_c,
  );
  static const TextStyle textGrayC14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray_c,
  );
}

/// 间隔
class Gaps {
  /// 水平间隔
  static const Widget hGap5 = SizedBox(width: Dimens.gap_dp5);
  static const Widget hGap10 = SizedBox(width: Dimens.gap_dp10);
  static const Widget hGap15 = SizedBox(width: Dimens.gap_dp15);
  static const Widget hGap16 = SizedBox(width: Dimens.gap_dp16);
  /// 垂直间隔
  static const Widget vGap5 = SizedBox(height: Dimens.gap_dp5);
  static const Widget vGap10 = SizedBox(height: Dimens.gap_dp10);
  static const Widget vGap15 = SizedBox(height: Dimens.gap_dp15);
  static const Widget vGap50 = SizedBox(height: Dimens.gap_dp50);

  static const Widget vGap4 = SizedBox(height: 4.0);
  static const Widget vGap8 = SizedBox(height: 8.0);
  static const Widget vGap12 = SizedBox(height: 12.0);
  static const Widget vGap16 = SizedBox(height: Dimens.gap_dp16);

  static const Widget hGap4 = SizedBox(width: 4.0);
  static const Widget hGap8 = SizedBox(width: 8.0);
  static const Widget hGap12 = SizedBox(width: 12.0);
  
  static Widget line = Container(height: 0.6, color: Colours.line);
  static const Widget empty = SizedBox();
}

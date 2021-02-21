import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///create by elileo on 2018/12/21
///https://github.com/elileo1/flutter_travel_friends/blob/master/lib/widget/PopupWindow.dart
///
/// weilu update： 去除了IntrinsicWidth限制，添加了默认蒙版
const Duration _kWindowDuration = Duration(milliseconds: 300);
const double _kWindowCloseIntervalEnd = 2.0 / 3.0;
const double _kWindowMaxWidth = 240.0;
const double _kWindowMinWidth = 48.0;
const double _kWindowVerticalPadding = 0.0;
const double _kWindowScreenPadding = 0.0;

///弹窗方法
Future<T> showPopupWindow<T>({
  @required BuildContext context,
  RelativeRect position,
  @required Widget child,
  double elevation = 8.0,
  String semanticLabel,
  bool fullWidth,
  bool isShowBg = false,
}) {
  assert(context != null);
  String label = semanticLabel;
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      label = semanticLabel;
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      label = semanticLabel ?? MaterialLocalizations.of(context)?.popupMenuLabel;
  }

  return Navigator.push(context,
      _PopupWindowRoute(
        position: position,
        child: child,
        elevation: elevation,
        semanticLabel: label,
        theme: Theme.of(context),
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        fullWidth: fullWidth,
        isShowBg: isShowBg
      ));
}

///自定义弹窗路由：参照_PopupMenuRoute修改的
class _PopupWindowRoute<T> extends PopupRoute<T> {
  _PopupWindowRoute({
    RouteSettings settings,
    this.child,
    this.position,
    this.elevation = 8.0,
    this.theme,
    this.barrierLabel,
    this.semanticLabel,
    this.fullWidth,
    this.isShowBg,
  }) : super(settings: settings);

  final Widget child;
  final RelativeRect position;
  double elevation;
  final ThemeData theme;
  final String semanticLabel;
  final bool fullWidth;
  final bool isShowBg;
  
  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Duration get transitionDuration => _kWindowDuration;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0.0, _kWindowCloseIntervalEnd));
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget win = _PopupWindow<T>(
      route: this,
      semanticLabel: semanticLabel,
      fullWidth: fullWidth,
    );
    if (theme != null) {
      win = Theme(data: theme, child: win);
    }

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: isShowBg ? const Color(0x99000000) : null,
                child: CustomSingleChildLayout(
                  delegate: _PopupWindowLayoutDelegate(
                    position, null, Directionality.of(context)
                  ),
                  child: win,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

///自定义弹窗控件：对自定义的弹窗内容进行再包装，添加长宽、动画等约束条件
class _PopupWindow<T> extends StatelessWidget {
  const _PopupWindow({
    Key key,
    this.route,
    this.semanticLabel,
    this.fullWidth = false,
  }) : super(key: key);

  final _PopupWindowRoute<T> route;
  final String semanticLabel;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    const double length = 10.0;
    const double unit = 1.0 /
        (length + 1.5); // 1.0 for the width and 0.5 for the last item's fade.

    final CurveTween opacity = CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = CurveTween(curve: const Interval(0.0, unit));
    final CurveTween height = CurveTween(curve: const Interval(0.0, unit * length));

    final Widget child = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: fullWidth ? double.infinity : _kWindowMinWidth,
        maxWidth: fullWidth ? double.infinity : _kWindowMaxWidth,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: _kWindowVerticalPadding),
        child: route.child,
      )
    );

    return AnimatedBuilder(
      animation: route.animation,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.evaluate(route.animation),
          child: Material(
            type: route.elevation == 0 ? MaterialType.transparency : MaterialType.card,
            elevation: route.elevation,
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              widthFactor: width.evaluate(route.animation),
              heightFactor: height.evaluate(route.animation),
              child: Semantics(
                scopesRoute: true,
                namesRoute: true,
                explicitChildNodes: true,
                label: semanticLabel,
                child: child,
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}

///自定义委托内容：子控件大小及其位置计算
class _PopupWindowLayoutDelegate extends SingleChildLayoutDelegate {
  _PopupWindowLayoutDelegate(
      this.position, this.selectedItemOffset, this.textDirection);

  final RelativeRect position;
  final double selectedItemOffset;
  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return BoxConstraints.loose(constraints.biggest -
        const Offset(_kWindowScreenPadding * 2.0, _kWindowScreenPadding * 2.0) as Size);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    double y;
    if (selectedItemOffset == null) {
      y = position.top;
    } else {
      y = position.top +
          (size.height - position.top - position.bottom) / 2.0 -
          selectedItemOffset;
    }

    // Find the ideal horizontal position.
    double x;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      assert(textDirection != null);
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < _kWindowScreenPadding)
      x = _kWindowScreenPadding;
    else if (x + childSize.width > size.width - _kWindowScreenPadding)
      x = size.width - childSize.width - _kWindowScreenPadding;
    if (y < _kWindowScreenPadding)
      y = _kWindowScreenPadding;
    else if (y + childSize.height > size.height - _kWindowScreenPadding)
      y = size.height - childSize.height - _kWindowScreenPadding;
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupWindowLayoutDelegate oldDelegate) {
    return position != oldDelegate.position;
  }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_deer/account/models/withdrawal_account_model.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class WithdrawalAccountItem extends StatefulWidget {

  const WithdrawalAccountItem({
    Key? key,
    required this.data,
    required this.onLongPress,
  }): super(key: key);
  
  final WithdrawalAccountModel data;
  final GestureLongPressCallback onLongPress;
  
  @override
  _WithdrawalAccountItemState createState() => _WithdrawalAccountItemState();
}

/// 3D翻转动画 https://medium.com/flutterpub/flutter-flip-card-animation-with-3d-effect-4284af04f5a
class _WithdrawalAccountItemState extends State<WithdrawalAccountItem> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(end: 1.0, begin: 0).animate(_animationController)
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final Widget front = Stack(
      children: <Widget>[
        Positioned(
          top: 25.0,
          left: 24.0,
          child: Container(
            height: 40.0,
            width: 40.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: LoadAssetImage(widget.data.type == 1 ? 'account/wechat' : 'account/yhk'),
          ),
        ),
        Positioned(
          top: 22.0,
          left: 72.0,
          child: Text(widget.data.typeName, style: const TextStyle(color: Colors.white, fontSize: Dimens.font_sp18)),
        ),
        Positioned(
          top: 48.0,
          left: 72.0,
          child: Text(widget.data.name, style: const TextStyle(color: Colors.white, fontSize: Dimens.font_sp12)),
        ),
        Positioned(
          bottom: 24.0,
          left: 72.0,
          child: Text(widget.data.code, style: const TextStyle(color: Colors.white, fontSize: Dimens.font_sp18, letterSpacing: 1.0)),
        ),
      ],
    );
    
    final Widget back = Center(
      child: GestureDetector(
        onTap: () => Toast.show('提现'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          decoration: BoxDecoration(
            border: Border.all(width: 0.6, color: Colors.white),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Transform(
            // 文字翻转，保证文字的方向
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateX(pi),
            child: const Text('提现',
                style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp16)
            ),
          ),
        ),
      ),
    );
    return Container(
      height: 152.0,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22.0),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, child) {
          return Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateX(pi * _animation.value),
            child: AccountCard(
              type: widget.data.type,
              child: InkWell(
                // 长按删除账号
                onLongPress: () => widget.onLongPress(),
                onTap: () {
                  /// 避免动画中重复执行
                  if (_animationStatus == AnimationStatus.dismissed) {
                    _animationController.forward();
                  }
                  if (_animationStatus == AnimationStatus.completed) {
                    _animationController.reverse();
                  }
                },
                child: _animation.value <= 0.5 ?  front : back,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AccountCard extends StatefulWidget {

  const AccountCard({
    Key? key,
    required this.child,
    required this.type
  }): super(key: key);

  final Widget child;
  final int type;

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    /// 添加RepaintBoundary原因见docs/Web问题汇总.md
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: context.isDark ? null : [
            BoxShadow(
              color: widget.type == 1 ? const Color(0x804EE07A) : Colours.shadow_blue,
              offset: const Offset(0.0, 2.0),
              blurRadius: 8.0,
              spreadRadius: 0.0,
            ),
          ],
          gradient: LinearGradient(
            colors: widget.type == 1 ?
            const [Color(0xFF40E6AE), Color(0xFF2DE062)] :
            const [Color(0xFF57C4FA), Colours.app_main],
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

part of oktoast;

/// use the [dismiss] to dismiss toast.
class ToastFuture {
  final OverlayEntry _entry;
  final VoidCallback _onDismiss;
  bool _isShow = true;
  final GlobalKey<__ToastContainerState> _containerKey;

  ToastFuture._(
    this._entry,
    this._onDismiss,
    this._containerKey,
  );

  void dismiss({bool showAnim = false}) {
    if (!_isShow) {
      return;
    }
    _isShow = false;
    _onDismiss?.call();
    ToastManager().removeFuture(this);

    if (showAnim) {
      _containerKey.currentState.showDismissAnim();
      Future.delayed(_opacityDuration, () {
        _entry.remove();
      });
    } else {
      _entry.remove();
    }
  }
}

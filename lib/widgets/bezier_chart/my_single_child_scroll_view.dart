import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

class MySingleChildScrollView extends StatelessWidget {
  /// Creates a box in which a single widget can be scrolled.
  const MySingleChildScrollView({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    bool? primary,
    this.physics,
    this.controller,
    required this.child,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(scrollDirection != null),
        assert(dragStartBehavior != null),
        assert(
            !(controller != null && primary == true),
            'Primary ScrollViews obtain their ScrollController via inheritance from a PrimaryScrollController widget. '
            'You cannot both set primary to true and pass an explicit controller.'),
        primary = primary ??
            controller == null && identical(scrollDirection, Axis.vertical),
        super(key: key);

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the scroll view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the scroll view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry? padding;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  ///
  /// Must be null if [primary] is true.
  ///
  /// A [ScrollController] serves several purposes. It can be used to control
  /// the initial scroll position (see [ScrollController.initialScrollOffset]).
  /// It can be used to control whether the scroll view should automatically
  /// save and restore its scroll position in the [PageStorage] (see
  /// [ScrollController.keepScrollOffset]). It can be used to read the current
  /// scroll position (see [ScrollController.offset]), or change it (see
  /// [ScrollController.animateTo]).
  final ScrollController? controller;

  /// Whether this is the primary scroll view associated with the parent
  /// [PrimaryScrollController].
  ///
  /// On iOS, this identifies the scroll view that will scroll to top in
  /// response to a tap in the status bar.
  ///
  /// Defaults to true when [scrollDirection] is vertical and [controller] is
  /// not specified.
  final bool primary;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// The widget that scrolls.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  AxisDirection _getDirection(BuildContext context) {
    return getAxisDirectionFromAxisReverseAndDirectionality(
        context, scrollDirection, reverse);
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);
    Widget contents = child;
    if (padding != null) contents = Padding(padding: padding!, child: contents);
    final ScrollController? scrollController =
        primary ? PrimaryScrollController.of(context) : controller;
    final Scrollable scrollable = Scrollable(
      dragStartBehavior: dragStartBehavior,
      axisDirection: axisDirection,
      controller: scrollController,
      physics: physics,
      viewportBuilder: (BuildContext context, ViewportOffset offset) {
        return _SingleChildViewport(
          axisDirection: axisDirection,
          offset: offset,
          child: contents,
        );
      },
    );
    return primary && scrollController != null
        ? PrimaryScrollController.none(child: scrollable)
        : scrollable;
  }
}

class _SingleChildViewport extends SingleChildRenderObjectWidget {
  const _SingleChildViewport({
    Key? key,
    this.axisDirection = AxisDirection.down,
    required this.offset,
    Widget? child,
  })  : assert(axisDirection != null),
        super(key: key, child: child);

  final AxisDirection axisDirection;
  final ViewportOffset offset;

  @override
  _RenderSingleChildViewport createRenderObject(BuildContext context) {
    return _RenderSingleChildViewport(
      axisDirection: axisDirection,
      offset: offset,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSingleChildViewport renderObject) {
    // Order dependency: The offset setter reads the axis direction.
    renderObject
      ..axisDirection = axisDirection
      ..offset = offset;
  }
}

class _RenderSingleChildViewport extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>
    implements RenderAbstractViewport {
  _RenderSingleChildViewport({
    AxisDirection axisDirection = AxisDirection.down,
    required ViewportOffset offset,
    double cacheExtent = RenderAbstractViewport.defaultCacheExtent,
    RenderBox? child,
  })  : assert(axisDirection != null),
        assert(offset != null),
        assert(cacheExtent != null),
        _axisDirection = axisDirection,
        _offset = offset,
        _cacheExtent = cacheExtent {
    this.child = child;
  }

  AxisDirection get axisDirection => _axisDirection;
  AxisDirection _axisDirection;
  set axisDirection(AxisDirection value) {
    assert(value != null);
    if (value == _axisDirection) return;
    _axisDirection = value;
    markNeedsLayout();
  }

  Axis get axis => axisDirectionToAxis(axisDirection);

  ViewportOffset get offset => _offset;
  ViewportOffset _offset;
  set offset(ViewportOffset value) {
    assert(value != null);
    if (value == _offset) return;
    if (attached) _offset.removeListener(_hasScrolled);
    _offset = value;
    if (attached) _offset.addListener(_hasScrolled);
    markNeedsLayout();
  }

  /// {@macro flutter.rendering.viewport.cacheExtent}
  double get cacheExtent => _cacheExtent;
  double _cacheExtent;
  set cacheExtent(double value) {
    assert(value != null);
    if (value == _cacheExtent) return;
    _cacheExtent = value;
    markNeedsLayout();
  }

  void _hasScrolled() {
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  @override
  void setupParentData(RenderObject child) {
    // We don't actually use the offset argument in BoxParentData, so let's
    // avoid allocating it at all.
    if (child.parentData is! ParentData) child.parentData = ParentData();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _offset.addListener(_hasScrolled);
  }

  @override
  void detach() {
    _offset.removeListener(_hasScrolled);
    super.detach();
  }

  @override
  bool get isRepaintBoundary => true;

  double get _viewportExtent {
    assert(hasSize);
    switch (axis) {
      case Axis.horizontal:
        return size.width;
      case Axis.vertical:
        return size.height;
    }
  }

  double get _minScrollExtent {
    assert(hasSize);
    return 0.0;
  }

  double get _maxScrollExtent {
    assert(hasSize);
    if (child == null)
      return 0.0;
    switch (axis) {
      case Axis.horizontal:
        return math.max(0.0, child!.size.width - size.width);
      case Axis.vertical:
        return math.max(0.0, child!.size.height - size.height);
    }
  }

  BoxConstraints _getInnerConstraints(BoxConstraints constraints) {
    switch (axis) {
      case Axis.horizontal:
        return constraints.heightConstraints();
      case Axis.vertical:
        return constraints.widthConstraints();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null)
      return child!.getMinIntrinsicWidth(height);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null)
      return child!.getMaxIntrinsicWidth(height);
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null)
      return child!.getMinIntrinsicHeight(width);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null)
      return child!.getMaxIntrinsicHeight(width);
    return 0.0;
  }

  // We don't override computeDistanceToActualBaseline(), because we
  // want the default behavior (returning null). Otherwise, as you
  // scroll, it would shift in its parent if the parent was baseline-aligned,
  // which makes no sense.

  @override
  void performLayout() {
    if (child == null) {
      size = constraints.smallest;
    } else {
      child!.layout(_getInnerConstraints(constraints), parentUsesSize: true);
      size = constraints.constrain(child!.size);
    }

    offset.applyViewportDimension(_viewportExtent);
    offset.applyContentDimensions(_minScrollExtent, _maxScrollExtent);
  }

  Offset get _paintOffset => _paintOffsetForPosition(offset.pixels);

  Offset _paintOffsetForPosition(double position) {
    assert(axisDirection != null);
    switch (axisDirection) {
      case AxisDirection.up:
        return Offset(0.0, position - child!.size.height + size.height);
      case AxisDirection.down:
        return Offset(0.0, -position);
      case AxisDirection.left:
        return Offset(position - child!.size.width + size.width, 0.0);
      case AxisDirection.right:
        return Offset(-position, 0.0);
    }
  }

  bool _shouldClipAtPaintOffset(Offset paintOffset) {
    assert(child != null);
    return paintOffset < Offset.zero ||
        !(Offset.zero & size).contains((paintOffset & child!.size).bottomRight);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final Offset paintOffset = _paintOffset;

      void paintContents(PaintingContext context, Offset offset) {
        context.paintChild(child!, offset + paintOffset);
      }

      if (_shouldClipAtPaintOffset(paintOffset)) {
        final Rect clipRect =
            Rect.fromLTWH(0.0, -size.height / 2, size.width, size.height * 1.5);
        context.pushClipRect(needsCompositing, offset, clipRect, paintContents);
      } else {
        paintContents(context, offset);
      }
    }
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    final Offset paintOffset = _paintOffset;
    transform.translate(paintOffset.dx, paintOffset.dy);
  }

  @override
  Rect? describeApproximatePaintClip(RenderObject child) {
    if (child != null && _shouldClipAtPaintOffset(_paintOffset))
      return Offset.zero & size;
    return null;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (child != null) {
      final Offset transformed = position + -_paintOffset;
      return child!.hitTest(result, position: transformed);
    }
    return false;
  }

  @override
  RevealedOffset getOffsetToReveal(RenderObject target, double alignment,
      {Rect? rect}) {
    rect ??= target.paintBounds;
    if (target is! RenderBox)
      return RevealedOffset(offset: offset.pixels, rect: rect);

    final RenderBox targetBox = target as RenderBox;
    final Matrix4 transform = targetBox.getTransformTo(this);
    final Rect bounds = MatrixUtils.transformRect(transform, rect);
    final Size contentSize = child!.size;

    double leadingScrollOffset;
    double targetMainAxisExtent;
    double mainAxisExtent;

    assert(axisDirection != null);
    switch (axisDirection) {
      case AxisDirection.up:
        mainAxisExtent = size.height;
        leadingScrollOffset = contentSize.height - bounds.bottom;
        targetMainAxisExtent = bounds.height;
        break;
      case AxisDirection.right:
        mainAxisExtent = size.width;
        leadingScrollOffset = bounds.left;
        targetMainAxisExtent = bounds.width;
        break;
      case AxisDirection.down:
        mainAxisExtent = size.height;
        leadingScrollOffset = bounds.top;
        targetMainAxisExtent = bounds.height;
        break;
      case AxisDirection.left:
        mainAxisExtent = size.width;
        leadingScrollOffset = contentSize.width - bounds.right;
        targetMainAxisExtent = bounds.width;
        break;
    }

    final double targetOffset = leadingScrollOffset -
        (mainAxisExtent - targetMainAxisExtent) * alignment;
    final Rect targetRect = bounds.shift(_paintOffsetForPosition(targetOffset));
    return RevealedOffset(offset: targetOffset, rect: targetRect);
  }

  @override
  void showOnScreen({
    RenderObject? descendant,
    Rect? rect,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
  }) {
    if (!offset.allowImplicitScrolling) {
      return super.showOnScreen(
        descendant: descendant,
        rect: rect,
        duration: duration,
        curve: curve,
      );
    }

    final Rect? newRect = RenderViewportBase.showInViewport(
      descendant: descendant,
      viewport: this,
      offset: offset,
      rect: rect,
      duration: duration,
      curve: curve,
    );
    super.showOnScreen(
      rect: newRect,
      duration: duration,
      curve: curve,
    );
  }

  @override
  Rect describeSemanticsClip(RenderObject child) {
    assert(axis != null);
    switch (axis) {
      case Axis.vertical:
        return Rect.fromLTRB(
          semanticBounds.left,
          semanticBounds.top - cacheExtent,
          semanticBounds.right,
          semanticBounds.bottom + cacheExtent,
        );
      case Axis.horizontal:
        return Rect.fromLTRB(
          semanticBounds.left - cacheExtent,
          semanticBounds.top,
          semanticBounds.right + cacheExtent,
          semanticBounds.bottom,
        );
    }
  }
}

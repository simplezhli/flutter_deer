import 'package:flutter/widgets.dart';

/// https://github.com/letsar/flutter_slidable
/// A widget that positions its child to a fraction of the total available space.
class FractionallyAlignedSizedBox extends StatelessWidget {
  /// Creates a widget that positions its child to a fraction of the total available space.
  ///
  /// Only two out of the three horizontal values ([leftFactor], [rightFactor],
  /// [widthFactor]), and only two out of the three vertical values ([topFactor],
  /// [bottomFactor], [heightFactor]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// If non-null, the [widthFactor] and [heightFactor] arguments must be
  /// non-negative.
  const FractionallyAlignedSizedBox({
    super.key,
    required this.child,
    this.leftFactor,
    this.topFactor,
    this.rightFactor,
    this.bottomFactor,
    this.widthFactor,
    this.heightFactor,
  })  : assert(
            leftFactor == null || rightFactor == null || widthFactor == null),
        assert(
            topFactor == null || bottomFactor == null || heightFactor == null),
        assert(widthFactor == null || widthFactor >= 0.0),
        assert(heightFactor == null || heightFactor >= 0.0);

  /// The relative distance that the child's left edge is inset from the left of the parent.
  final double? leftFactor;

  /// The relative distance that the child's top edge is inset from the top of the parent.
  final double? topFactor;

  /// The relative distance that the child's right edge is inset from the right of the parent.
  final double? rightFactor;

  /// The relative distance that the child's bottom edge is inset from the bottom of the parent.
  final double? bottomFactor;

  /// The child's width relative to its parent's width.
  final double? widthFactor;

  /// The child's height relative to its parent's height.
  final double? heightFactor;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double dx = 0;
    double dy = 0;
    double? width = widthFactor;
    double? height = heightFactor;

    if (widthFactor == null) {
      final left = leftFactor ?? 0;
      final right = rightFactor ?? 0;
      width = 1 - left - right;

      if (width != 1) {
        dx = left / (1.0 - width);
      }
    }

    if (heightFactor == null) {
      final top = topFactor ?? 0;
      final bottom = bottomFactor ?? 0;
      height = 1 - top - bottom;
      if (height != 1) {
        dy = top / (1.0 - height);
      }
    }

    if (widthFactor != null && widthFactor != 1) {
      if (leftFactor != null) {
        dx = leftFactor! / (1 - widthFactor!);
      } else if (leftFactor == null && rightFactor != null) {
        dx = (1 - widthFactor! - rightFactor!) / (1 - widthFactor!);
      }
    }

    if (heightFactor != null && heightFactor != 1) {
      if (topFactor != null) {
        dy = topFactor! / (1 - heightFactor!);
      } else if (topFactor == null && bottomFactor != null) {
        dy = (1 - heightFactor! - bottomFactor!) / (1 - heightFactor!);
      }
    }

    return Align(
      alignment: FractionalOffset(
        dx,
        dy,
      ),
      child: FractionallySizedBox(
        widthFactor: width,
        heightFactor: height,
        child: child,
      ),
    );
  }
}

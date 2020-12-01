
import 'package:flutter/material.dart';


/// https://medium.com/flutter-community/neumorphic-designs-in-flutter-eab9a4de2059
class NeumorphicContainer extends StatefulWidget {

  NeumorphicContainer({
    Key key,
    this.child,
    this.bevel = 10.0,
    this.color,
  })  : blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  final Widget child;
  final double bevel;
  final Offset blurOffset;
  final Color color;

  @override
  _NeumorphicContainerState createState() => _NeumorphicContainerState();
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color ?? Colors.blueGrey.shade200;

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.bevel * 10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              if (_isPressed) color else color.mix(Colors.black, .1),
              if (_isPressed) color.mix(Colors.black, .05) else color,
              if (_isPressed) color.mix(Colors.black, .05) else color,
              color.mix(Colors.white, _isPressed ? .2 : .5),
            ],
            stops: const <double>[0.0, 0.3, 0.6, 1.0],
          ),
          boxShadow: _isPressed ? null : <BoxShadow>[
            BoxShadow(
              blurRadius: widget.bevel,
              offset: -widget.blurOffset,
              color: color.mix(Colors.white, .6),
            ),
            BoxShadow(
              blurRadius: widget.bevel,
              offset: widget.blurOffset,
              color: color.mix(Colors.black, .3),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
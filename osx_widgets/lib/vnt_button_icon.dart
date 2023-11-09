import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VNTButtonIcon extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final Color color;
  final bool isCircle;
  final bool isSelected;
  final Color hoverColor; // Color quan el cursor és sobre el botó
  final Color selectedColor; // Color quan el botó està seleccionat
  final Color pressedColor;

  const VNTButtonIcon({
    Key? key,
    required this.onPressed,
    this.icon = CupertinoIcons.bell_fill,
    this.size = 24.0,
    this.color = Colors.black,
    this.isCircle = false,
    this.isSelected = false,
    this.hoverColor =
        const Color.fromARGB(255, 240, 240, 240), // Gris subtil per hover
    this.selectedColor =
        const Color.fromARGB(255, 220, 220, 220), // Gris subtil per selected
    this.pressedColor =
        const Color.fromARGB(255, 200, 200, 200), // Gris més fort per pressed
  }) : super(key: key);

  @override
  VNTButtonIconState createState() => VNTButtonIconState();
}

class VNTButtonIconState extends State<VNTButtonIcon> {
  bool _isPressed = false;
  bool _isHovering = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  void _onMouseEnter(PointerEvent details) {
    setState(() => _isHovering = true);
  }

  void _onMouseExit(PointerEvent details) {
    setState(() => _isHovering = false);
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = _isPressed
        ? widget.pressedColor
        : _isHovering
            ? widget.hoverColor
            : widget.isSelected
                ? widget.selectedColor
                : Colors.transparent; // Cap fons per defecte

    return MouseRegion(
      onEnter: _onMouseEnter,
      onExit: _onMouseExit,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: widget.isCircle
                ? BorderRadius.circular(widget.size)
                : BorderRadius.circular(8), // Cantons arrodonits
          ),
          child: Container(
            width: widget.size,
            height: widget.size,
            alignment: Alignment.center,
            child: Icon(
              widget.icon,
              color: widget.color,
              size: widget.isCircle
                  ? widget.size * 0.5
                  : widget.size, // Icona més petita que el botó
            ),
          ),
        ),
      ),
    );
  }
}

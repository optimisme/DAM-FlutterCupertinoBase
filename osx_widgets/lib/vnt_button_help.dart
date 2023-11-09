import 'package:flutter/material.dart';

class VNTButtonHelp extends StatefulWidget {
  final VoidCallback onPressed;
  final double size;
  final Color color;
  final Color pressedColor;

  const VNTButtonHelp({
    Key? key,
    required this.onPressed,
    this.size = 24.0, // Mida més petita per al botó
    this.color = Colors.black,
    this.pressedColor =
        const Color.fromARGB(255, 231, 231, 231), // Color quan es premi
  }) : super(key: key);

  @override
  VNTButtonHelpState createState() => VNTButtonHelpState();
}

class VNTButtonHelpState extends State<VNTButtonHelp> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _isPressed ? widget.pressedColor : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border.all(
            color: const Color.fromARGB(
                255, 220, 220, 220), // Defineix el color del border
            width: 1, // Defineix l'amplada del border
          ),
        ),
        child: Container(
          width: widget.size,
          height: widget.size,
          alignment: Alignment.center,
          child: Text(
            '?',
            style: TextStyle(
              fontSize: widget.size / 1.5,
              color: widget.color,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}

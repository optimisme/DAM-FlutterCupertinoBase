import 'package:flutter/material.dart';

class VNTSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const VNTSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  VNTSwitchState createState() => VNTSwitchState();
}

class VNTSwitchState extends State<VNTSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 24.0, // Defineix l'altura del switch
        width: 48.0, // Defineix l'amplada del switch
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), // Borde arrodonit
          color: widget.value
              ? Colors.blue
              : Colors.grey, // Canvia el color en activar/desactivar
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              left: widget.value ? 24.0 : 0.0, // Canvia la posició del cercle
              right: widget.value ? 0.0 : 24.0,
              child: Container(
                height: 24.0,
                width: 24.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

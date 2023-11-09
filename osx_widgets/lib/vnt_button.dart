import 'package:flutter/material.dart';

enum VNTButtonStyle { action, normal, destructive }

class VNTButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final VNTButtonStyle style;
  final bool isLarge;
  final bool isDisabled;

  const VNTButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.style = VNTButtonStyle.normal,
    this.isLarge = false,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  VNTButtonState createState() => VNTButtonState();
}

class VNTButtonState extends State<VNTButton> with WidgetsBindingObserver {
  static const double _fontSize = 12.0;
  bool _isPressed = false;
  bool _hasAppFocus = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {
          _hasAppFocus = true;
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        setState(() {
          _hasAppFocus = false;
        });
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    TextStyle textStyle;
    BoxShadow shadow = BoxShadow(
      color: Colors.black.withOpacity(0.1),
      spreadRadius: 0,
      blurRadius: 1,
      offset: const Offset(0, 1),
    );

    if (widget.isDisabled) {
      switch (widget.style) {
        case VNTButtonStyle.action:
          decoration = BoxDecoration(
              color: const Color.fromRGBO(112, 175, 250, 1),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [shadow]);
          textStyle = const TextStyle(
            fontSize: _fontSize,
            color: Color.fromRGBO(92, 143, 203, 1),
          );
          break;

        case VNTButtonStyle.normal:
        case VNTButtonStyle.destructive:
          decoration = BoxDecoration(
              color: const Color.fromRGBO(247, 247, 247, 1),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [shadow]);
          textStyle = const TextStyle(
            fontSize: _fontSize,
            color: Color.fromRGBO(190, 190, 190, 1),
          );
          break;
      }
    } else {
      switch (widget.style) {
        case VNTButtonStyle.action:
          if (_hasAppFocus) {
            decoration = BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _isPressed
                        ? const Color.fromRGBO(25, 124, 245, 1)
                        : const Color.fromRGBO(35, 134, 255, 1),
                    _isPressed
                        ? const Color.fromRGBO(0, 98, 236, 1)
                        : const Color.fromRGBO(0, 111, 254, 1),
                  ],
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [shadow]);
            textStyle = TextStyle(
              fontSize: _fontSize,
              color: _isPressed
                  ? const Color.fromRGBO(175, 211, 255, 1)
                  : Colors.white,
            );
          } else {
            decoration = BoxDecoration(
                color: _isPressed ? Colors.grey.shade200 : Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [shadow]);
            textStyle = const TextStyle(
              fontSize: _fontSize,
              color: Colors.black,
            );
          }
          break;

        case VNTButtonStyle.destructive:
          decoration = BoxDecoration(
              color: _isPressed ? Colors.grey.shade200 : Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [shadow]);
          textStyle = const TextStyle(
            fontSize: _fontSize,
            color: Colors.red,
          );
          break;

        default:
          decoration = BoxDecoration(
              color: _isPressed ? Colors.grey.shade200 : Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [shadow]);
          textStyle = const TextStyle(
            fontSize: _fontSize,
            color: Colors.black,
          );
      }
    }

    return GestureDetector(
      onTapDown: widget.isDisabled
          ? null
          : (details) => setState(() => _isPressed = true),
      onTapUp: widget.isDisabled
          ? null
          : (details) => setState(() => _isPressed = false),
      onTapCancel:
          widget.isDisabled ? null : () => setState(() => _isPressed = false),
      onTap: widget.isDisabled ? null : widget.onPressed,
      child: DecoratedBox(
        decoration: decoration,
        child: Padding(
          padding: widget.isLarge
              ? const EdgeInsets.fromLTRB(8, 8, 8, 10)
              : const EdgeInsets.fromLTRB(8, 4, 8, 6),
          child: DefaultTextStyle(
            style: textStyle,
            child: widget.isLarge ? Center(child: widget.child) : widget.child,
          ),
        ),
      ),
    );
  }
}

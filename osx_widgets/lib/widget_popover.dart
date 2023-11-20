import 'package:flutter/material.dart';

/*
  Exemple de com usar 'WidgetPopover'

  Primer cal crear una key amb les variables de la classe '...state'

  GlobalKey _settingsButtonKey = GlobalKey();

  Cal posar aquesta key al botó que obrirà el Popover:

  IconButton( 
    key: _settingsButtonKey, 
    icon: Icon(Icons.settings), 
    onPressed: () { ...

  Després es pot fer servir el widget:

  CupertinoButton(
    key: _settingsButtonKey,
    padding: const EdgeInsets.all(0.0),
    onPressed: () {
      WidgetPopover.showPopover(
          context: context,
          key: _settingsButtonKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print("Opció 1 premuda");
                    WidgetPopover.hidePopover();
                  },
                  child: Text('Opció 1'),
                ),
                GestureDetector(
                  onTap: () {
                    print("Opció 2 premuda");
                    WidgetPopover.hidePopover();
                  },
                  child: Text('Opció 2'),
                ),
              ],
            ),
          ));
    },
    child: const Icon(
      CupertinoIcons.settings,
      color: CupertinoColors.black,
      size: 24.0,
      semanticLabel: 'Text to announce in accessibility modes',
    ),
  )
*/

class WidgetPopover extends StatefulWidget {
  final Offset anchor;
  final double anchorWidth;
  final Widget child;
  static OverlayEntry? _currentOverlayEntry;

  const WidgetPopover({
    Key? key,
    required this.anchor,
    required this.child,
    required this.anchorWidth,
  }) : super(key: key);

  @override
  WidgetPopoverState createState() => WidgetPopoverState();

  static void showPopover({
    required BuildContext context,
    required GlobalKey key,
    required Widget child,
  }) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final anchorPosition = renderBox.localToGlobal(Offset.zero);
    final anchorSize = renderBox.size;

    WidgetPopover.hidePopover();

    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => WidgetPopover(
        anchor: anchorPosition + Offset(0.0, anchorSize.height),
        anchorWidth: anchorSize.width,
        child: child,
      ),
    );

    _currentOverlayEntry = overlayEntry;

    Overlay.of(context).insert(overlayEntry);
  }

  static void hidePopover() {
    _currentOverlayEntry?.remove();
    _currentOverlayEntry = null;
  }
}

class WidgetPopoverState extends State<WidgetPopover> {
  double? width;
  double? height;
  bool isSizeDetermined = false;
  GlobalKey childKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (childKey.currentContext != null) {
        final RenderBox childRenderBox =
            childKey.currentContext!.findRenderObject() as RenderBox;
        final childSize = childRenderBox.size;

        setState(() {
          width = childSize.width;
          height = childSize.height;
          isSizeDetermined = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const screenPadding = 10.0;

    double leftPosition, topPosition;

    if (isSizeDetermined) {
      leftPosition = widget.anchor.dx + (widget.anchorWidth / 2) - width! / 2;
      topPosition = widget.anchor.dy;

      if (leftPosition + width! > screenSize.width - screenPadding) {
        leftPosition = screenSize.width - width! - screenPadding;
      }
      if (leftPosition < screenPadding) {
        leftPosition = screenPadding;
      }

      if (topPosition + height! > screenSize.height - screenPadding) {
        topPosition = screenSize.height - height! - screenPadding;
      }
      if (topPosition < screenPadding) {
        topPosition = screenPadding;
      }
    } else {
      // Momentàniament, posiciona fora de la pantalla per determinar la mida
      leftPosition = -10000000;
      topPosition = -10000000;
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            WidgetPopover.hidePopover();
          },
          behavior: HitTestBehavior.translucent,
          child: Container(
            color: Colors.transparent,
            width: screenSize.width,
            height: screenSize.height,
          ),
        ),
        Positioned(
          left: leftPosition,
          top: topPosition,
          child: Container(
            key: childKey,
            constraints: BoxConstraints(
              maxWidth: screenSize.width - 2 * screenPadding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
        Positioned(
          left: widget.anchor.dx + 10,
          top: isSizeDetermined
              ? widget.anchor.dy - 10
              : -1000000, // Ajusta -10 segons la mida del triangle
          child: CustomPaint(
            size: Size(20,
                10), // Aquesta mida determina l'amplada i l'altura del triangle
            painter: TrianglePainter(triangleColor: Colors.white),
          ),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color triangleColor;
  final Color lineColor;
  final bool isUp;

  TrianglePainter({
    required this.triangleColor,
    this.lineColor = const Color(0xFFCCCCCC),
    this.isUp = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trianglePaint = Paint()
      ..color = triangleColor
      ..style = PaintingStyle.fill;

    final Paint linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.0;

    final path = Path();

    if (isUp) {
      path.moveTo(size.width / 2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);

      canvas.drawLine(
          Offset(size.width / 2, 0), Offset(0, size.height), linePaint);
      canvas.drawLine(Offset(size.width / 2, 0),
          Offset(size.width, size.height), linePaint);
    } else {
      path.moveTo(size.width / 2, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);

      // Aquí estan les dues línies per la part inferior
      canvas.drawLine(
          Offset(size.width / 2, size.height), Offset(0, 0), linePaint);
      canvas.drawLine(Offset(size.width / 2, size.height),
          Offset(size.width, 0), linePaint);
    }

    path.close();
    canvas.drawPath(path, trianglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

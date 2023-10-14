import 'package:flutter/cupertino.dart';

class LayoutMobile extends StatefulWidget {
  const LayoutMobile({super.key, required this.title});

  final String title;

  @override
  State<LayoutMobile> createState() => _LayoutMobileState();
}

class _LayoutMobileState extends State<LayoutMobile> {
  int _counter = 0;

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Flexible(
                    child: Text(
                      'Click on decrement to decrease the counter: ',
                    ),
                  ),
                  // Add text with the counter
                  Text(
                    ' $_counter',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            CupertinoButton(
              onPressed: _decrementCounter,
              child: const Text('Decrement'),
            ),
          ],
        ),
      ),
    );
  }
}

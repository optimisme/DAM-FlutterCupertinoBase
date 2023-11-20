import 'package:cupertino_base/vnt_switch.dart';
import 'package:flutter/cupertino.dart';
import 'vnt_button.dart';
import 'vnt_button_help.dart';
import 'vnt_button_icon.dart';

class LayoutDesktop extends StatefulWidget {
  const LayoutDesktop({super.key, required this.title});

  final String title;

  @override
  State<LayoutDesktop> createState() => _LayoutDesktopState();
}

class _LayoutDesktopState extends State<LayoutDesktop> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.title),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Buttons:',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    VNTButton(
                      style: VNTButtonStyle.action,
                      isLarge: true,
                      isDisabled: false,
                      onPressed: () {},
                      child: const Text('Action large'),
                    ),
                    const SizedBox(width: 20),
                    VNTButton(
                      style: VNTButtonStyle.action,
                      isLarge: false,
                      isDisabled: false,
                      onPressed: () {},
                      child: const Text('Action'),
                    ),
                    const SizedBox(width: 20),
                    VNTButton(
                      style: VNTButtonStyle.destructive,
                      isLarge: false,
                      isDisabled: false,
                      onPressed: () {},
                      child: const Text('Destructive'),
                    ),
                    const SizedBox(width: 20),
                    VNTButton(
                      style: VNTButtonStyle.normal,
                      isLarge: false,
                      isDisabled: false,
                      onPressed: () {},
                      child: const Text('Normal'),
                    ),
                    const SizedBox(width: 20),
                    VNTButton(
                      style: VNTButtonStyle.action,
                      isLarge: false,
                      isDisabled: true,
                      onPressed: () {},
                      child: const Text('Action disabled'),
                    ),
                    const SizedBox(width: 20),
                    VNTButton(
                      style: VNTButtonStyle.destructive,
                      isLarge: false,
                      isDisabled: true,
                      onPressed: () {},
                      child: const Text('Destructive disabled'),
                    ),
                    const SizedBox(width: 20),
                    VNTButton(
                      style: VNTButtonStyle.normal,
                      isLarge: false,
                      isDisabled: true,
                      onPressed: () {},
                      child: const Text('Normal disabled'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    VNTButtonHelp(size: 24, onPressed: () {}),
                    const SizedBox(width: 10),
                    VNTButtonIcon(
                        size: 28, icon: CupertinoIcons.back, onPressed: () {}),
                    const SizedBox(width: 10),
                    VNTButtonIcon(size: 28, isCircle: true, onPressed: () {}),
                    const SizedBox(width: 10),
                    VNTButtonIcon(
                        size: 28,
                        icon: CupertinoIcons.cloud_fill,
                        color: const Color.fromARGB(255, 70, 135, 250),
                        isCircle: true,
                        isSelected: true,
                        onPressed: () {}),
                    const SizedBox(width: 10),
                    VNTSwitch(
                      value: isSwitched,
                      onChanged: (bool newValue) {
                        setState(() {
                          isSwitched = newValue;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

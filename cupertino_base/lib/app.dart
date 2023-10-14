import 'package:flutter/cupertino.dart';
import 'layout_desktop.dart';
import 'layout_mobile.dart';

// Main application widget
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

// Main application state
class AppState extends State<App> {
  // Define the layout to use depending on the screen width
  Widget _setLayout(BuildContext context) {
    // Set different layouts depending on the screen width
    double width = MediaQuery.of(context).size.width;
    if (width >= 600) {
      return const LayoutDesktop();
    } else {
      return const LayoutMobile(title: "Layout Mobile");
    }
  }

  // Definir el contingut del widget 'App'
  @override
  Widget build(BuildContext context) {
    // Farem servir la base 'Cupertino'
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: _setLayout(context),
    );
  }
}

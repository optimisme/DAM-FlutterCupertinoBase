import 'package:flutter/cupertino.dart';
import 'layout_desktop.dart';

// Main application widget
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

// Main application state
class AppState extends State<App> {
  // Definir el contingut del widget 'App'
  @override
  Widget build(BuildContext context) {
    // Farem servir la base 'Cupertino'
    return const CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(brightness: Brightness.light),
        home: LayoutDesktop(title: "App Desktop Title"));
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppData with ChangeNotifier {
  // Access appData globaly with:
  // AppData appData = Provider.of<AppData>(context);
  // AppData appData = Provider.of<AppData>(context, listen: false)

  bool readyExample = false;

  late dynamic dataExample;

  // Tell if data is ready
  bool dataReady(String type) {
    switch (type) {
      case 'Example':
        return readyExample;
    }
    return false;
  }

  // Get data
  dynamic getData(String type) {
    switch (type) {
      case 'Example':
        return dataExample;
    }
    return;
  }

  // Get item from data
  dynamic getItemData(String type, int index) {
    if (dataReady(type)) {
      return getData(type)[index];
    }
    return;
  }

  // Load data from '.json' file
  void load(String type) async {
    var file = "";
    switch (type) {
      case 'Example':
        file = "assets/data/example.json";
        break;
    }

    // If development, wait 1 second to simulate a delay
    if (!kReleaseMode) {
      await Future.delayed(const Duration(seconds: 1));
    }

    // Load data from file
    var fileText = await rootBundle.loadString(file);
    var fileData = json.decode(fileText);

    // Set data
    switch (type) {
      case 'Example':
        readyExample = true;
        dataExample = fileData;
        break;
    }

    // Notify listeners to update UI
    notifyListeners();
  }
}
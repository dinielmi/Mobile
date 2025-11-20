import 'package:flutter/material.dart';

class AppSettings {
  bool isDarkMode = false;
  String username = "Teman";
  int fontSize = 20;

  Color get backgroundColor {
    return isDarkMode ? Colors.grey[900]! : Colors.white;
  }

  Color get textColor {
    return isDarkMode ? Colors.white : Colors.black;
  }

  String get greeting {
    return "Hello, $username!";
  }
}

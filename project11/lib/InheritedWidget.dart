import 'package:flutter/material.dart';
import 'package:project11/Model.dart';

void main() {
  runApp(MyApp());
}
class MyTheme extends InheritedWidget {
  final Color primaryColor;
  final bool isDarkMode;

  const MyTheme({
    super.key,
    required this.primaryColor,
    required this.isDarkMode,
    required super.child,
  });

  static MyTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyTheme>();
  }

  @override
  bool updateShouldNotify(MyTheme oldWidget) {
    return primaryColor != oldWidget.primaryColor ||
        isDarkMode != oldWidget.isDarkMode;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyTheme(
      primaryColor: Colors.blue,
      isDarkMode: false,
      child: MaterialApp(
        home: MyApp(),
      ),
    );
  }
}

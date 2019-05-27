import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/homeScreen.dart';
import 'package:whatsapp_clone/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final result =
      routeNamePath.map((name, path) => MapEntry(path, goToPageByRoute[name]));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        showPerformanceOverlay: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          indicatorColor: Colors.white,
          primaryIconTheme: IconThemeData(
            color: Colors.white,
          ),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          ),
        ),
        home: HomeScreen(title: 'WhatsApp Home'),
        routes: routeNamePath
            .map((name, path) => MapEntry(path, goToPageByRoute[name])));
  }
}

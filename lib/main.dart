import 'package:domainsearch/ui/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domain Search',
      theme: _buildTheme(),
      home: HomeScreen(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.blueAccent,
//      textTheme: TextTheme(
//        title: TextStyle(
//          color: Colors.white,
//        ),
//        body1: TextStyle(
//          color: Colors.white,
//        ),
//      ),
      cursorColor: Colors.white,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
        ),
        body1: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

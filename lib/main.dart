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
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.blueAccent,
      appBarTheme: AppBarTheme(
        color: Colors.indigo,
      ),
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

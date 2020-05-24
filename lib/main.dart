import 'package:domainsearch/i10n/app_localizations.dart';
import 'package:domainsearch/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).title,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("ru"),
        const Locale("uk"),
      ],
      title: AppLocalizations.of(context).title,
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

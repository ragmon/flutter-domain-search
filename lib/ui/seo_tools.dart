import 'package:flutter/material.dart';

class SEOToolsScreen extends StatefulWidget {
  final String domain;

  const SEOToolsScreen({Key key, this.domain}) : super(key: key);

  @override
  _SEOToolsScreenState createState() => _SEOToolsScreenState();
}

class _SEOToolsScreenState extends State<SEOToolsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SEO Tools"),
      ),
      body: Container(),
    );
  }
}

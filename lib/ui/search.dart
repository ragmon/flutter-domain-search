import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final String domain;

  const SearchScreen({Key key, this.domain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Domain: $domain"),
      ),
//      body: ,
    );
  }
}

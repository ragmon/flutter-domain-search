import 'package:domainsearch/model/status.dart';
import 'package:flutter/material.dart';

class DomainDetailsScreen extends StatelessWidget {
  final String domain;

  const DomainDetailsScreen({Key key, this.domain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Domain details"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          DomainStatus(),
          Divider(),
          SearchResults()
        ],
      ),
    );
  }
}

class DomainStatus extends StatefulWidget {
  @override
  _DomainStatusState createState() => _DomainStatusState();
}

class _DomainStatusState extends State<DomainStatus> {
  Future<Status> futureDomainStatus;
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:domainsearch/model/search_result.dart';
import 'package:domainsearch/model/status.dart';
import 'package:domainsearch/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        children: <Widget>[
          DomainStatus(domain: domain),
          Divider(
            color: Colors.white,
          ),
          SearchResults(domain: domain),
        ],
      ),
    );
  }
}

class DomainStatus extends StatefulWidget {
  final String domain;

  const DomainStatus({Key key, this.domain}) : super(key: key);

  @override
  _DomainStatusState createState() => _DomainStatusState();
}

class _DomainStatusState extends State<DomainStatus> {
  Future<dynamic> _futureDomainStatus;

  @override
  void initState() {
    super.initState();

    _futureDomainStatus = Network.fetchDomainStatus(widget.domain);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureDomainStatus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Received status list
          if (snapshot.data is StatusListModel) {
            return _buildStatusList(context, snapshot);
          }
          // Received errors list
          else {
            return _buildStatusErrorList(context, snapshot);
          }
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  String _getSummary(String summary) {
    switch (summary) {
      case "undelegated":
        return "The domain is not present in DNS";
      case "inactive":
        return "Available for new registration";
      case "pending":
        return "TLD not yet in the root zone file";
      case "disallowed":
        return "Disallowed by the registry, ICANN, or other (wrong script, etc.)";
      case "claimed":
        return "Claimed or reserved by some party (not available for new registration).";
      case "reserved":
        return "Explicitly reserved by ICANN, the registry, or another party";
      case "dpml":
        return "Domains Protected Marks List, reserved for trademark holders";
      case "invalid":
        return "Technically invalid, e.g. too long or too short";
      case "active":
        return "Registered, but possibly available via the aftermarket";
      case "parked":
        return "Active and parked, possibly available via the aftermarket";
      case "marketed":
        return "Explicitly marketed as for sale via the aftermarket";
      case "expiring":
        return "An expiring domain. e.g. in the Redemption Grace Period, and possibly available via a backorder service.";
      case "deleting":
        return "A expired domain pending removal from the registry. e.g. in the Pending Delete phase, and possibly available via a backorder service";
      case "priced":
        return "An aftermarket domain with an explicit price. e.g. via the BuyDomains service";
      case "transferable":
        return "An aftermarket domain available for fast-transfer. e.g. in the Afternic inventory";
      case "premium":
        return "Premium domain name for sale by the registry";
      case "suffix":
        return "A public suffix according to publicsuffix.org";
      case "zone":
        return "A zone (domain extension) in the Domainr database";
      case "tld	":
        return "A top-level domain";
      case "unknown":
      default:
        return "Unknown status";
    }
  }

  Color _getSummaryTextColor(summary) {
    switch (summary) {
      case "inactive":
        return Colors.lightGreenAccent;
      default:
        return Colors.white70;
    }
  }

  Widget _buildStatusList(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(
        color: Colors.white,
      ),
      itemCount: (snapshot.data as StatusListModel).statuses.length,
      itemBuilder: (context, index) {
        StatusModel status = (snapshot.data as StatusListModel).statuses[index];
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                status.domain,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Text(
              _getSummary(status.summary),
              style: TextStyle(
                color: _getSummaryTextColor(status.summary),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatusErrorList(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        StatusErrorModel statusError =
            (snapshot.data as StatusErrorList).statusErrors[index];
        return Column(
          children: <Widget>[
            Text("Code: ${statusError.code}"),
            Text("Message: ${statusError.message}"),
            Text("Details: ${statusError.detail}"),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: Colors.white,
      ),
      itemCount: (snapshot.data as StatusErrorList).statusErrors.length,
    );
  }
}

class SearchResults extends StatefulWidget {
  final String domain;

  const SearchResults({Key key, this.domain}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Future<SearchResultListModel> _futureSearchResults;

  @override
  void initState() {
    super.initState();

    _futureSearchResults = Network.fetchSearchResults(widget.domain);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureSearchResults,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildSearchResults(context, snapshot);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildSearchResults(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        SearchResultModel searchResult =
            (snapshot.data as SearchResultListModel).searchResultList[index];
        return Column(
          children: <Widget>[
            Text("${searchResult.domain}"),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () => _openRegisterURL(searchResult.registerURL),
              color: Colors.green,
              textColor: Colors.white,
              child: Text(
                "Register".toUpperCase(),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: Colors.white,
      ),
      itemCount:
          (snapshot.data as SearchResultListModel).searchResultList.length,
    );
  }

  _openRegisterURL(String registerURL) async {
    if (await canLaunch(registerURL)) {
      await launch(registerURL);
    } else {
      throw 'Could not launch $registerURL';
    }
  }
}

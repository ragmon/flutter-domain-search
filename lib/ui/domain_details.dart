import 'package:domainsearch/localization.dart';
import 'package:domainsearch/model/search_result.dart';
import 'package:domainsearch/model/status.dart';
import 'package:domainsearch/network.dart';
import 'package:domainsearch/ui/seo_tools.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DomainDetailsScreen extends StatelessWidget {
  final String domain;

  const DomainDetailsScreen({Key key, this.domain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).domainDetails),
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

  String _getSummary(String summary, BuildContext context) {
    switch (summary) {
      case "undelegated":
        return AppLocalizations.of(context).domainSummaryUndelegated;
      case "inactive":
        return AppLocalizations.of(context).domainSummaryInactive;
      case "pending":
        return AppLocalizations.of(context).domainSummaryPending;
      case "disallowed":
        return AppLocalizations.of(context).domainSummaryDisallowed;
      case "claimed":
        return AppLocalizations.of(context).domainSummaryClaimed;
      case "reserved":
        return AppLocalizations.of(context).domainSummaryReserved;
      case "dpml":
        return AppLocalizations.of(context).domainSummaryDpml;
      case "invalid":
        return AppLocalizations.of(context).domainSummaryInvalid;
      case "active":
        return AppLocalizations.of(context).domainSummaryActive;
      case "parked":
        return AppLocalizations.of(context).domainSummaryParked;
      case "marketed":
        return AppLocalizations.of(context).domainSummaryMarketed;
      case "expiring":
        return AppLocalizations.of(context).domainSummaryExpiring;
      case "deleting":
        return AppLocalizations.of(context).domainSummaryDeleting;
      case "priced":
        return AppLocalizations.of(context).domainSummaryPriced;
      case "transferable":
        return AppLocalizations.of(context).domainSummaryTransferable;
      case "premium":
        return AppLocalizations.of(context).domainSummaryPremium;
      case "suffix":
        return AppLocalizations.of(context).domainSummarySuffix;
      case "zone":
        return AppLocalizations.of(context).domainSummaryZone;
      case "tld":
        return AppLocalizations.of(context).domainSummaryTld;
      case "unknown":
      default:
        return AppLocalizations.of(context).domainSummaryUnknown;
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
      primary: false,
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
              _getSummary(status.summary, context),
              style: TextStyle(
                color: _getSummaryTextColor(status.summary),
              ),
            ),
            Visibility(
              visible: _getSEOToolsVisibility(status.summary),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () => _openSEOTools(context, widget.domain),
                color: Colors.indigo,
                textColor: Colors.white,
                child: Text(
                  AppLocalizations.of(context).seoTools.toUpperCase(),
                  style: TextStyle(fontSize: 14),
                ),
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
      primary: false,
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

  void _openSEOTools(BuildContext context, String domain) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SEOToolsScreen(domain: domain),
        ));
  }

  bool _getSEOToolsVisibility(String status) {
    switch (status) {
      case "active":
        return true;
      default:
        return false;
    }
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
      primary: false,
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
                AppLocalizations.of(context).register.toUpperCase(),
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

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
        children: <Widget>[DomainStatus(), Divider(), SearchResults()],
      ),
    );
  }
}

class DomainStatus extends StatefulWidget {
  @override
  _DomainStatusState createState() => _DomainStatusState();
}

class _DomainStatusState extends State<DomainStatus> {
  Future<StatusList> futureDomainStatus;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureDomainStatus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: (snapshot.data as StatusList).statuses.length,
            itemBuilder: (context, index) {
              Status status = snapshot.data[index];
              return Card(
                child: Row(
                  children: <Widget>[
                    Text(status.domain),
                    Text(_formatSummary(status.summary)),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  String _formatSummary(String summary) {
    switch (summary) {
      case "undelegated": return "The domain is not present in DNS";
      case "inactive": return "Available for new registration";
      case "pending": return "TLD not yet in the root zone file";
      case "disallowed": return "Disallowed by the registry, ICANN, or other (wrong script, etc.)";
      case "claimed": return "Claimed or reserved by some party (not available for new registration).";
      case "reserved": return "Explicitly reserved by ICANN, the registry, or another party";
      case "dpml": return "Domains Protected Marks List, reserved for trademark holders";
      case "invalid": return "Technically invalid, e.g. too long or too short";
      case "active": return "Registered, but possibly available via the aftermarket";
      case "parked": return "Active and parked, possibly available via the aftermarket";
      case "marketed": return "Explicitly marketed as for sale via the aftermarket";
      case "expiring": return "An expiring domain. e.g. in the Redemption Grace Period, and possibly available via a backorder service.";
      case "deleting": return "A expired domain pending removal from the registry. e.g. in the Pending Delete phase, and possibly available via a backorder service";
      case "priced": return "An aftermarket domain with an explicit price. e.g. via the BuyDomains service";
      case "transferable": return "An aftermarket domain available for fast-transfer. e.g. in the Afternic inventory";
      case "premium": return "Premium domain name for sale by the registry";
      case "suffix": return "A public suffix according to publicsuffix.org";
      case "zone": return "A zone (domain extension) in the Domainr database";
      case "tld	": return "A top-level domain";
      case "unknown":
      default:
        return "Unknown status";
    }
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

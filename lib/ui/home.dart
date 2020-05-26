import 'package:domainsearch/localization.dart';
import 'package:domainsearch/ui/domain_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController searchAnimationController;
  Animation<double> searchAnimation;

  @override
  void initState() {
    super.initState();

    searchAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    searchAnimation = CurvedAnimation(parent: searchAnimationController, curve: Curves.easeIn);

    searchAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Colors.blueAccent,
                Colors.lightBlueAccent,
              ],
            ),
          ),
          child: FadeTransition(
            opacity: searchAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SearchingForm(),
                BasedOnInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchingForm extends StatefulWidget {
  @override
  _SearchingFormState createState() => _SearchingFormState();
}

class _SearchingFormState extends State<SearchingForm> {
  final _searchFieldController = TextEditingController();
  bool _domainFieldValid = false;

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 6,
            child: TextField(
              decoration: InputDecoration(
                helperText: AppLocalizations.of(context).domainHelperText,
                prefix: Text(AppLocalizations.of(context).domainPrefix),
                labelText: AppLocalizations.of(context).enterTheDomain,
                errorText: _domainFieldValid == false
                    ? AppLocalizations.of(context).domainErrorText
                    : null,
              ),
              controller: _searchFieldController,
              maxLength: 64,
              onSubmitted: (String value) => _search(context),
            ),
          ),
          InkWell(
            child: Icon(
              Icons.search,
              color: Colors.greenAccent,
            ),
            onTap: () => _search(context),
          ),
        ],
      ),
    );
  }

  void _search(context) {
    setState(() {
      _domainFieldValid = _searchFieldController.text.isNotEmpty;
    });

    // Navigate to the Search Screen
    if (_searchFieldController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DomainDetailsScreen(
            domain: _searchFieldController.text,
          ),
        ),
      );
    }
  }
}

class BasedOnInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "powered by",
                style: TextStyle(fontSize: 12.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: _openDomainrUrl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SvgPicture.asset(
                  "images/domainr.svg",
                  color: Colors.white,
                ),
              ),
              Text(
                "Domainr.com",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _openDomainrUrl() async {
    const url = "https://domainr.com/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

import 'package:domainsearch/ui/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color> [
                Colors.blueAccent,
                Colors.lightBlueAccent,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SearchingForm(),
              BasedOnInfo(),
            ],
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
              inputFormatters: <TextInputFormatter>[DomainTextInputFormatter()],
              decoration: InputDecoration(
                helperText: "example.com",
                prefix: Text("Domain: "),
                labelText: "Enter the Domain",
                errorText: _domainFieldValid == false
                    ? "Domain field can\'t be empty"
                    : null,
              ),
              controller: _searchFieldController,
              maxLength: 63,
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
          builder: (_) => SearchScreen(
            domain: _searchFieldController.text,
          ),
        ),
      );
    }
  }
}

class DomainTextInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
        text: newValue.text.toLowerCase().replaceAll(" ", "").trim());
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
                "Domainr",
                style: TextStyle(
                  fontSize: 16.0,
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

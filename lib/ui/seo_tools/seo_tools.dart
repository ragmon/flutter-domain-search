import 'dart:async';

import 'package:domainsearch/model/seo_report.dart';
import 'package:domainsearch/network.dart';
import 'package:domainsearch/parser.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SEOToolsScreen extends StatefulWidget {
  final String domain;

  const SEOToolsScreen({Key key, this.domain}) : super(key: key);

  @override
  _SEOToolsScreenState createState() => _SEOToolsScreenState();
}

class _SEOToolsScreenState extends State<SEOToolsScreen> {
  // ignore: close_sinks
  StreamController<SEOReport> _streamController;

  @override
  void initState() {
    super.initState();

    _streamController = new StreamController<SEOReport>();

    _loadSEOToolsData(_streamController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SEO Tools"),
      ),
      body: StreamBuilder<SEOReport>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildSEOTools(context, snapshot);
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildSEOTools(
      BuildContext context, AsyncSnapshot<SEOReport> snapshot) {
    return ListView(
      children: <Widget>[
        DomainSection(domain: widget.domain),
        ExpansionSection(
          title: "Meta keywords",
          value: snapshot.data.page.metaKeywords,
        ),
        ExpansionSection(
          title: "Meta description",
          value: snapshot.data.page.metaDescription,
        ),
        ExpansionSection(
          title: "Title",
          value: snapshot.data.page.title,
        ),
        ExpansionSection(
          title: "H1",
          value: snapshot.data.page.h1,
        ),
        Visibility(
          visible: snapshot.data.files != null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ToolButton(
                title: "Open Sitemap.xml",
                visible: snapshot.data.files?.hasSitemap ?? false,
                onPressed: () => _openSitemapXml(widget.domain),
              ),
              ToolButton(
                title: "Open Robots.txt",
                visible: snapshot.data.files?.hasRobots ?? false,
                onPressed: () => _openRobotsTxt(widget.domain),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            onPressed: () => _openSite(widget.domain),
            color: Colors.indigo,
            textColor: Colors.white,
            child: Text(
              "View Site".toUpperCase(),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  void _openSite(String domain) async {
    final String url = "http://$domain";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openSitemapXml(String domain) async {
    final String url = "http://$domain/sitemap.xml";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openRobotsTxt(String domain) async {
    final String url = "http://$domain/robots.txt";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _loadSEOToolsData(StreamController controller) async {
    final SEOReport seoReport = new SEOReport();

    final String indexPageHtml = await Network.fetchIndexPage(widget.domain);

    seoReport.page = Parser.parsePageData(indexPageHtml);
    controller.add(seoReport);

    seoReport.files = await Network.checkFiles(widget.domain);
    controller.add(seoReport);

    controller.close();
  }
}

class DomainSection extends StatelessWidget {
  final String domain;

  const DomainSection({Key key, this.domain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15.0),
      child: Text(
        domain,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ExpansionSection extends StatelessWidget {
  final String title;
  final String value;
  final IconData successIcon;
  final IconData failIcon;
  final MaterialAccentColor successColor;
  final MaterialAccentColor failColor;

  const ExpansionSection(
      {Key key,
      this.title,
      this.value,
      this.successIcon = Icons.check_circle,
      this.failIcon = Icons.not_interested,
      this.successColor = Colors.greenAccent,
      this.failColor = Colors.redAccent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(
        value.length > 0 ? successIcon : failIcon,
        color: value.length > 0 ? successColor : failColor,
      ),
      title: Text(title),
      subtitle: Text("Total: ${value.length} symbols"),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: Text(value),
        )
      ],
    );
  }
}

class ToolButton extends StatelessWidget {
  final String title;
  final bool visible;
  final void Function() onPressed;

  const ToolButton({Key key, this.title, this.visible, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          onPressed: onPressed,
          color: Colors.indigo,
          textColor: Colors.white,
          child: Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}

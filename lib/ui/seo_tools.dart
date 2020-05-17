import 'dart:async';

import 'package:domainsearch/model/seo_report.dart';
import 'package:domainsearch/network.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class SEOToolsScreen extends StatefulWidget {
  final String domain;

  const SEOToolsScreen({Key key, this.domain}) : super(key: key);

  @override
  _SEOToolsScreenState createState() => _SEOToolsScreenState();
}

class _SEOToolsScreenState extends State<SEOToolsScreen> {
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
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15.0),
          child: Text(
            widget.domain,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
//        Container(
//          alignment: Alignment.center,
//          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
//          child: Text(
//            "Main tags",
//            style: TextStyle(fontSize: 16.0),
//          ),
//        ),
//        Divider(color: Colors.white),
        ExpansionTile(
          leading: Icon(
            snapshot.data.page.metaKeywords.length > 0
                ? Icons.check_circle
                : Icons.not_interested,
            color: snapshot.data.page.metaKeywords.length > 0
                ? Colors.greenAccent
                : Colors.redAccent,
          ),
          title: Text("Meta keywords"),
          subtitle:
              Text("Total: ${snapshot.data.page.metaKeywords.length} symbols"),
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(snapshot.data.page.metaKeywords),
            )
          ],
        ),
        ExpansionTile(
          leading: Icon(
            snapshot.data.page.metaDescription.length > 0
                ? Icons.check_circle
                : Icons.not_interested,
            color: snapshot.data.page.metaDescription.length > 0
                ? Colors.greenAccent
                : Colors.redAccent,
          ),
          title: Text("Meta description"),
          subtitle: Text("Total: ${snapshot.data.page.metaDescription.length} symbols"),
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(snapshot.data.page.metaDescription),
            )
          ],
        ),
        ExpansionTile(
          leading: Icon(
            snapshot.data.page.title.length > 0
                ? Icons.check_circle
                : Icons.not_interested,
            color: snapshot.data.page.title.length > 0
                ? Colors.greenAccent
                : Colors.redAccent,
          ),
          title: Text("Title"),
          subtitle: Text("Total: ${snapshot.data.page.title.length} symbols"),
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(snapshot.data.page.title),
            )
          ],
        ),
        ExpansionTile(
          leading: Icon(
            snapshot.data.page.h1.length > 0
                ? Icons.check_circle
                : Icons.not_interested,
            color: snapshot.data.page.h1.length > 0
                ? Colors.greenAccent
                : Colors.redAccent,
          ),
          title: Text("H1"),
          subtitle: Text("Total: ${snapshot.data.page.h1.length} symbols"),
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(snapshot.data.page.h1),
            )
          ],
        ),
//        Divider(color: Colors.white),
        Visibility(
          visible: snapshot.data.files != null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: snapshot.data.files?.hasSitemap ?? false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () => _openSitemapXml(widget.domain),
                    color: Colors.indigo,
                    textColor: Colors.white,
                    child: Text(
                      "Open Sitemap.xml",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: snapshot.data.files?.hasRobots ?? false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () => _openRobotsTxt(widget.domain),
                    color: Colors.indigo,
                    textColor: Colors.white,
                    child: Text(
                      "Open Robots.txt",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
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

  _openSitemapXml(String domain) async {
    final String url = "http://$domain/sitemap.xml";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openRobotsTxt(String domain) async {
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

    seoReport.page = _parsePageData(indexPageHtml);
    controller.add(seoReport);

    seoReport.files = await _checkFiles(widget.domain);
    controller.add(seoReport);
  }

  PageData _parsePageData(String html) {
    PageData meta = new PageData();

    var document = parse(html);
    var $title = document.querySelector("title");
    var $metaKeywords = document.querySelector("meta[name='keywords']");
    var $metaDescription = document.querySelector("meta[name='description']");
    var $h1 = document.querySelector("h1");

    meta.title = $title.text;
    meta.metaKeywords =
        $metaKeywords != null ? $metaKeywords.attributes["content"] : "";
    meta.metaDescription =
        $metaDescription != null ? $metaDescription.attributes["content"] : "";
    meta.h1 = $h1 != null ? $h1.text : "";

    return meta;
  }

  Future<FileStatuses> _checkFiles(String domain) async {
    FileStatuses files = new FileStatuses();

    files.hasRobots = await Network.checkFile(domain, "robots.txt");
    files.hasSitemap = await Network.checkFile(domain, "sitemap.xml");

    return files;
  }
}

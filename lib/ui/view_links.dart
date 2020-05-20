import 'dart:async';

import 'package:domainsearch/model/sitemap.dart';
import 'package:domainsearch/sitemap.dart';
import 'package:flutter/material.dart';

class ViewLinksScreen extends StatefulWidget {
  final String domain;

  const ViewLinksScreen({Key key, this.domain}) : super(key: key);

  @override
  _ViewLinksScreenState createState() => _ViewLinksScreenState();
}

class _ViewLinksScreenState extends State<ViewLinksScreen> {
  StreamController<SitemapUrlList> _streamController;

  @override
  void initState() {
    super.initState();

    _streamController = new StreamController<SitemapUrlList>();

    _loadSitemapLinks(_streamController);
  }

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.domain),
      ),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder:
            (BuildContext context, AsyncSnapshot<SitemapUrlList> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              primary: true,
              shrinkWrap: true,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    child: Text(
                      "Sitemap.xml",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Divider(),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data.list[index].loc),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "Priority: ${snapshot.data.list[index].priority}"),
                          Text(
                              "Change Frequency: ${snapshot.data.list[index].changefreq}"),
                          Text(
                              "Last Modification: ${snapshot.data.list[index].lastmod}"),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.white);
                  },
                  itemCount: snapshot.data.list.length,
                ),
                Visibility(
                  visible: snapshot.connectionState != ConnectionState.done,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _loadSitemapLinks(StreamController<SitemapUrlList> controller) async {
    final String url = "http://" + widget.domain + "/sitemap.xml";
    final SitemapParser parser = new SitemapParser(url);

    parser.onParseIteration((SitemapUrlList urlList) {
      controller.add(urlList);
    });

    parser.parse(onDone: () => controller.close());
  }
}

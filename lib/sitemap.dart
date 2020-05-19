import 'package:xml/xml.dart' as xml;

import 'package:domainsearch/model/sitemap.dart';
import 'package:domainsearch/network.dart';

class SitemapParser {
  final String rootLoc;
  final List<SitemapUrl> links = new List<SitemapUrl>();
  void Function(SitemapUrlList urlList) onParseIterationCallback;

  SitemapParser(this.rootLoc);

  Future<String> _load(String loc) async {
    return await Network.get(loc);
  }

  void parse({void Function() onDone, String loc}) async {
    if (loc == null) {
      loc = this.rootLoc;
    }

    final String content = await this._load(loc);

    final $document = xml.parse(content);
    final $sitemaps = $document.findAllElements("sitemap");
    final $urls = $document.findAllElements("url");

    if ($sitemaps.length > 0) {
      $sitemaps
          .map((node) => new Sitemap(loc: node.firstChild.text))
          .forEach((sitemap) => parse(loc: sitemap.loc));
    }
    if ($urls.length > 0) {
      $urls.map((node) {
        final $loc = node.findElements("loc");
        final $lastmod = node.findAllElements("lastmod");
        final $changefreq = node.findElements("changefreq");
        final $priority = node.findElements("priority");

        return SitemapUrl(
          loc: $loc.length > 0 ? $loc.first.text : "",
          lastmod: $lastmod.length > 0 ? $lastmod.first.text : "",
          changefreq: $changefreq.length > 0 ? $changefreq.first.text : "",
          priority: $priority.length > 0 ? $priority.first.text : "",
        );
      }).forEach((url) => links.add(url));
    }

    onParseIterationCallback(SitemapUrlList(list: links));

    if (onDone != null) {
      onDone();
    }
  }

  void onParseIteration(void Function(SitemapUrlList urlList) callback) {
    this.onParseIterationCallback = callback;
  }
}

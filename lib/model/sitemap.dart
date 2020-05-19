class Sitemap {
  final String loc;

  Sitemap({this.loc});
}

class SitemapUrl {
  final String loc;
  final String lastmod;
  final String changefreq;
  final String priority;

  SitemapUrl({this.loc, this.lastmod, this.changefreq, this.priority});
}

class SitemapUrlList {
  final List<SitemapUrl> list;

  SitemapUrlList({this.list});
}
class SEOReport {
  PageData page;
  FileStatuses files;
}

class PageData {
  String title;
  String metaKeywords;
  String metaDescription;
  String h1;
}

class FileStatuses {
  bool hasSitemap;
  bool hasRobots;

  @override
  String toString() {
    return "{hasSitemap: $hasSitemap, hasRobots: $hasRobots}";
  }
}
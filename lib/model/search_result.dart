class SearchResult {
  String domain;
  String host;
  String subdomain;
  String zone;
  String path;
  String registerURL;

  SearchResult(
      {this.domain,
      this.host,
      this.subdomain,
      this.zone,
      this.path,
      this.registerURL});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      domain: json["domain"],
      host: json["host"],
      subdomain: json["subdomain"],
      zone: json["zone"],
      path: json["path"],
      registerURL: json["registerURL"],
    );
  }
}

class SearchResultList {
  final List<SearchResult> searchResultList;

  SearchResultList({this.searchResultList});

  factory SearchResultList.fromJson(List<dynamic> parsedJson) {
    return SearchResultList(
        searchResultList:
            parsedJson.map((value) => SearchResult.fromJson(value)).toList());
  }
}

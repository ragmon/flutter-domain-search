class SearchResultModel {
  String domain;
  String host;
  String subdomain;
  String zone;
  String path;
  String registerURL;

  SearchResultModel(
      {this.domain,
      this.host,
      this.subdomain,
      this.zone,
      this.path,
      this.registerURL});

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      domain: json["domain"],
      host: json["host"],
      subdomain: json["subdomain"],
      zone: json["zone"],
      path: json["path"],
      registerURL: json["registerURL"],
    );
  }
}

class SearchResultListModel {
  final List<SearchResultModel> searchResultList;

  SearchResultListModel({this.searchResultList});

  factory SearchResultListModel.fromJson(List<dynamic> parsedJson) {
    return SearchResultListModel(
        searchResultList:
            parsedJson.map((value) => SearchResultModel.fromJson(value)).toList());
  }
}

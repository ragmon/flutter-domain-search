import 'dart:convert';

import 'package:domainsearch/model/search_result.dart';
import 'package:domainsearch/model/status.dart';

import 'package:http/http.dart' as http;

class Network {
  static final String host = "domainr.p.rapidapi.com";

  // X-RapidAPI-Key value
  // https://rapidapi.com/domainr/api/domainr/endpoints
  static String mashapeKey = "02e672673bmshd8b651c96496435p18388bjsn87009844c6b1";

  static Future<StatusList> fetchDomainStatus(String domain) async {
    final queryParameters = {
      "mashape-key": mashapeKey,
      "domain": domain,
    };
    final uri = Uri.https(host, "/v2/status", queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return StatusList.fromJson(json.decode(response.body)["status"]);
    } else {
      throw Exception("Faild to load domain status");
    }
  }

  static Future<SearchResultListModel> fetchSearchResults(String domain) async {
    final queryParameters = {
      "mashape-key": mashapeKey,
      "query": domain,
    };
    final uri = Uri.https(host, "/v2/search", queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return SearchResultListModel.fromJson(json.decode(response.body)["results"]);
    } else {
      throw Exception("Faild to load search result");
    }
  }
}
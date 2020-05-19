import 'dart:convert';

import 'package:domainsearch/model/search_result.dart';
import 'package:domainsearch/model/seo_report.dart';
import 'package:domainsearch/model/status.dart';

import 'package:http/http.dart' as http;

class Network {
  static final String host = "domainr.p.rapidapi.com";

  // X-RapidAPI-Key value
  // https://rapidapi.com/domainr/api/domainr/endpoints
  static String mashapeKey = "02e672673bmshd8b651c96496435p18388bjsn87009844c6b1";

  static /*Future<StatusList>*/ fetchDomainStatus(String domain) async {
    final queryParameters = {
      "mashape-key": mashapeKey,
      "domain": domain,
    };
    final Uri uri = Uri.https(host, "/v2/status", queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      if (parsedJson["errors"] == null) {
        return StatusListModel.fromJson(parsedJson["status"]);
      } else {
        return StatusErrorList.fromJson(parsedJson["errors"]);
      }
    } else {
      throw Exception("Fail to load domain status");
    }
  }

  static Future<SearchResultListModel> fetchSearchResults(String domain) async {
    final queryParameters = {
      "mashape-key": mashapeKey,
      "query": domain,
    };
    final Uri uri = Uri.https(host, "/v2/search", queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return SearchResultListModel.fromJson(json.decode(response.body)["results"]);
    } else {
      throw Exception("Fail to load search result");
    }
  }

  static Future<String> fetchIndexPage(String domain) async {
    final Uri uri = Uri.http(domain, "/");

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Fail to load index page");
    }
  }

  static Future<bool> checkFile(String domain, String file) async {
    final Uri uri = Uri.http(domain, "/$file");

    final response = await http.get(uri);

    return response.statusCode == 200;
  }

  static Future<FileStatuses> checkFiles(String domain) async {
    FileStatuses files = new FileStatuses();

    files.hasRobots = await Network.checkFile(domain, "robots.txt");
    files.hasSitemap = await Network.checkFile(domain, "sitemap.xml");

    return files;
  }

  static Future<String> get(String url) async {
    final Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Fail to load $uri");
    }
  }
}
import 'package:domainsearch/model/seo_report.dart';
import 'package:html/parser.dart';

class Parser {
  static PageData parsePageData(String html) {
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
}
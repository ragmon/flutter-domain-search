// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static m0(value) => "Частота обновленния: ${value}";

  static m1(value) => "Последняя модификация: ${value}";

  static m2(value) => "Приоритет: ${value}";

  static m3(total) => "Всего: ${total} символов";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "changeFrequency" : m0,
    "checkSitemapLinks" : MessageLookupByLibrary.simpleMessage("Открыть ссылки из sitemap.xml"),
    "domainDetails" : MessageLookupByLibrary.simpleMessage("Детальнее о домене"),
    "domainErrorText" : MessageLookupByLibrary.simpleMessage("Домен должен быть задан"),
    "domainHelperText" : MessageLookupByLibrary.simpleMessage("example.com"),
    "domainPrefix" : MessageLookupByLibrary.simpleMessage("Домен: "),
    "domainSummaryActive" : MessageLookupByLibrary.simpleMessage("Зарегистрирован, но возможно доступен через вторичный рынок"),
    "domainSummaryClaimed" : MessageLookupByLibrary.simpleMessage("Заявлено или зарезервировано какой-либо стороной (недоступно для новой регистрации)"),
    "domainSummaryDeleting" : MessageLookupByLibrary.simpleMessage("Истек срок действия домена, ожидающего удаления из реестра. например на этапе ожидания удаления и, возможно, доступны через службу отложенного заказа"),
    "domainSummaryDisallowed" : MessageLookupByLibrary.simpleMessage("Запрещено реестром, ICANN или другим (неправильный сценарий и т. Д.)"),
    "domainSummaryDpml" : MessageLookupByLibrary.simpleMessage("Список защищенных марок доменов, зарезервированный для владельцев товарных знаков"),
    "domainSummaryExpiring" : MessageLookupByLibrary.simpleMessage("Уходящий домен. например в льготный период погашения, и, возможно, доступны через услугу отложенного заказа"),
    "domainSummaryInactive" : MessageLookupByLibrary.simpleMessage("Доступнен для новой регистрации"),
    "domainSummaryInvalid" : MessageLookupByLibrary.simpleMessage("Технически недействительным, например, слишком длинный или слишком короткий"),
    "domainSummaryMarketed" : MessageLookupByLibrary.simpleMessage("Явно продается как для продажи через вторичный рынок"),
    "domainSummaryParked" : MessageLookupByLibrary.simpleMessage("Активный и припаркованный, возможно, доступен через вторичный рынок"),
    "domainSummaryPending" : MessageLookupByLibrary.simpleMessage("TLD еще не находится в файле корневой зоны"),
    "domainSummaryPremium" : MessageLookupByLibrary.simpleMessage("Премиум доменное имя для продажи по реестру"),
    "domainSummaryPriced" : MessageLookupByLibrary.simpleMessage("Домен вторичного рынка с явной ценой. например через сервис BuyDomains"),
    "domainSummaryReserved" : MessageLookupByLibrary.simpleMessage("Явно зарезервировано ICANN, реестром или другой стороной"),
    "domainSummarySuffix" : MessageLookupByLibrary.simpleMessage("Публичный суффикс в соответствии с publicsuffix.org"),
    "domainSummaryTld" : MessageLookupByLibrary.simpleMessage("Домен верхнего уровня"),
    "domainSummaryTransferable" : MessageLookupByLibrary.simpleMessage("Домен вторичного рынка доступен для быстрой передачи. например в афтерском инвентаре"),
    "domainSummaryUndelegated" : MessageLookupByLibrary.simpleMessage("Домена нет в DNS"),
    "domainSummaryUnknown" : MessageLookupByLibrary.simpleMessage("Неизвестный статус"),
    "domainSummaryZone" : MessageLookupByLibrary.simpleMessage("Зона (расширение домена) в базе данных домена"),
    "enterTheDomain" : MessageLookupByLibrary.simpleMessage("Ведите домен"),
    "h1" : MessageLookupByLibrary.simpleMessage("H1"),
    "lastModification" : m1,
    "metaDescription" : MessageLookupByLibrary.simpleMessage("Мета-описание"),
    "metaKeywords" : MessageLookupByLibrary.simpleMessage("Мета ключевые слова"),
    "openRobotsTxt" : MessageLookupByLibrary.simpleMessage("Открыть Robots.txt"),
    "openSitemapXml" : MessageLookupByLibrary.simpleMessage("Открыть Sitemap.xml"),
    "pageTitle" : MessageLookupByLibrary.simpleMessage("Заголовок"),
    "priorityValue" : m2,
    "register" : MessageLookupByLibrary.simpleMessage("Регистрация"),
    "seoTools" : MessageLookupByLibrary.simpleMessage("SEO инструменты"),
    "sitemapXml" : MessageLookupByLibrary.simpleMessage("Sitemap.xml"),
    "title" : MessageLookupByLibrary.simpleMessage("Поиск домена"),
    "titleTotalSymbols" : m3,
    "viewSite" : MessageLookupByLibrary.simpleMessage("Просмотреть сайт")
  };
}

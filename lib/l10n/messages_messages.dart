// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  static m0(value) => "Change Frequency: ${value}";

  static m1(value) => "Last modification: ${value}";

  static m2(value) => "Priority: ${value}";

  static m3(total) => "Total: ${total} symbols";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "changeFrequency" : m0,
    "checkSitemapLinks" : MessageLookupByLibrary.simpleMessage("Check Sitemap links"),
    "domainDetails" : MessageLookupByLibrary.simpleMessage("Domain details"),
    "domainErrorText" : MessageLookupByLibrary.simpleMessage("Domain field can\'t be empty"),
    "domainHelperText" : MessageLookupByLibrary.simpleMessage("example.com"),
    "domainPrefix" : MessageLookupByLibrary.simpleMessage("Domain: "),
    "domainSummaryActive" : MessageLookupByLibrary.simpleMessage("Registered, but possibly available via the aftermarket"),
    "domainSummaryClaimed" : MessageLookupByLibrary.simpleMessage("Claimed or reserved by some party (not available for new registration)."),
    "domainSummaryDeleting" : MessageLookupByLibrary.simpleMessage("A expired domain pending removal from the registry. e.g. in the Pending Delete phase, and possibly available via a backorder service"),
    "domainSummaryDisallowed" : MessageLookupByLibrary.simpleMessage("Disallowed by the registry, ICANN, or other (wrong script, etc.)"),
    "domainSummaryDpml" : MessageLookupByLibrary.simpleMessage("Domains Protected Marks List, reserved for trademark holders"),
    "domainSummaryExpiring" : MessageLookupByLibrary.simpleMessage("An expiring domain. e.g. in the Redemption Grace Period, and possibly available via a backorder service"),
    "domainSummaryInactive" : MessageLookupByLibrary.simpleMessage("Available for new registration"),
    "domainSummaryInvalid" : MessageLookupByLibrary.simpleMessage("Technically invalid, e.g. too long or too short"),
    "domainSummaryMarketed" : MessageLookupByLibrary.simpleMessage("Explicitly marketed as for sale via the aftermarket"),
    "domainSummaryParked" : MessageLookupByLibrary.simpleMessage("Active and parked, possibly available via the aftermarket"),
    "domainSummaryPending" : MessageLookupByLibrary.simpleMessage("TLD not yet in the root zone file"),
    "domainSummaryPremium" : MessageLookupByLibrary.simpleMessage("Premium domain name for sale by the registry"),
    "domainSummaryPriced" : MessageLookupByLibrary.simpleMessage("An aftermarket domain with an explicit price. e.g. via the BuyDomains service"),
    "domainSummaryReserved" : MessageLookupByLibrary.simpleMessage("Explicitly reserved by ICANN, the registry, or another party"),
    "domainSummarySuffix" : MessageLookupByLibrary.simpleMessage("A public suffix according to publicsuffix.org"),
    "domainSummaryTld" : MessageLookupByLibrary.simpleMessage("A top-level domain"),
    "domainSummaryTransferable" : MessageLookupByLibrary.simpleMessage("An aftermarket domain available for fast-transfer. e.g. in the Afternic inventory"),
    "domainSummaryUndelegated" : MessageLookupByLibrary.simpleMessage("The domain is not present in DNS"),
    "domainSummaryUnknown" : MessageLookupByLibrary.simpleMessage("Unknown status"),
    "domainSummaryZone" : MessageLookupByLibrary.simpleMessage("A zone (domain extension) in the Domainr database"),
    "enterTheDomain" : MessageLookupByLibrary.simpleMessage("Enter the domain"),
    "h1" : MessageLookupByLibrary.simpleMessage("H1"),
    "lastModification" : m1,
    "metaDescription" : MessageLookupByLibrary.simpleMessage("Meta description"),
    "metaKeywords" : MessageLookupByLibrary.simpleMessage("Meta keywords"),
    "openRobotsTxt" : MessageLookupByLibrary.simpleMessage("Open Robots.txt"),
    "openSitemapXml" : MessageLookupByLibrary.simpleMessage("Open Sitemap.xml"),
    "pageTitle" : MessageLookupByLibrary.simpleMessage("Title"),
    "priorityValue" : m2,
    "register" : MessageLookupByLibrary.simpleMessage("Register"),
    "seoTools" : MessageLookupByLibrary.simpleMessage("SEO Tools"),
    "sitemapXml" : MessageLookupByLibrary.simpleMessage("Sitemap.xml"),
    "title" : MessageLookupByLibrary.simpleMessage("Domain Search"),
    "titleTotalSymbols" : m3,
    "viewSite" : MessageLookupByLibrary.simpleMessage("View Site")
  };
}

import 'package:domainsearch/l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final String localName;

  AppLocalizations(this.localName);

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
    locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localName = Intl.canonicalizedLocale(name);

    return initializeMessages(localName).then((_) {
      return AppLocalizations(localName);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title => Intl.message(
    "Domain Search",
    name: "title",
    desc: "Title for the DomainSearch application",
    locale: localName,
  );

  // --- HomeScreen ----------------------------------------------------------

  String get enterTheDomain => Intl.message(
    "Enter the domain",
    name: "enterTheDomain",
    desc: "Domain search field intro text",
    locale: localName,
  );

  String get domainPrefix => Intl.message(
    "Domain: ",
    name: "domainPrefix",
    desc: "Domain search field prefix",
    locale: localName,
  );

  String get domainErrorText => Intl.message(
    "Domain field can\'t be empty",
    name: "domainErrorText",
    desc: "Domain search field error message",
    locale: localName,
  );

  String get domainHelperText => Intl.message(
    "example.com",
    name: "domainHelperText",
    desc: "Domain search field helper text",
    locale: localName,
  );

  String get domainDetails => Intl.message(
    "Domain details",
    name: "domainDetails",
    desc: "Domain details app bar title",
    locale: localName,
  );

  // --- End of HomeScreen ---------------------------------------------------

  // --- Domain summary messages ---------------------------------------------

  String get domainSummaryUndelegated => Intl.message(
    "The domain is not present in DNS",
    name: "domainSummaryUndelegated",
    desc: "Domain summary undelegated",
    locale: localName,
  );

  String get domainSummaryInactive => Intl.message(
    "Available for new registration",
    name: "domainSummaryInactive",
    desc: "Domain summary inactive",
    locale: localName,
  );

  String get domainSummaryPending => Intl.message(
    "TLD not yet in the root zone file",
    name: "domainSummaryPending",
    desc: "Domain summary pending",
    locale: localName,
  );

  String get domainSummaryDisallowed => Intl.message(
    "Disallowed by the registry, ICANN, or other (wrong script, etc.)",
    name: "domainSummaryDisallowed",
    desc: "Domain summary disallowed",
    locale: localName,
  );

  String get domainSummaryClaimed => Intl.message(
    "Claimed or reserved by some party (not available for new registration).",
    name: "domainSummaryClaimed",
    desc: "Domain summary claimed",
    locale: localName,
  );

  String get domainSummaryReserved => Intl.message(
    "Explicitly reserved by ICANN, the registry, or another party",
    name: "domainSummaryReserved",
    desc: "Domain summary reserved",
    locale: localName,
  );

  String get domainSummaryDpml => Intl.message(
    "Domains Protected Marks List, reserved for trademark holders",
    name: "domainSummaryDpml",
    desc: "Domain summary DPML",
    locale: localName,
  );

  String get domainSummaryInvalid => Intl.message(
    "Technically invalid, e.g. too long or too short",
    name: "domainSummaryInvalid",
    desc: "Domain summary invalid",
    locale: localName,
  );

  String get domainSummaryActive => Intl.message(
    "Registered, but possibly available via the aftermarket",
    name: "domainSummaryActive",
    desc: "Domain summary active",
    locale: localName,
  );

  String get domainSummaryParked => Intl.message(
    "Active and parked, possibly available via the aftermarket",
    name: "domainSummaryParked",
    desc: "Domain summary parked",
    locale: localName,
  );

  String get domainSummaryMarketed => Intl.message(
    "Explicitly marketed as for sale via the aftermarket",
    name: "domainSummaryMarketed",
    desc: "Domain summary marketed",
    locale: localName,
  );

  String get domainSummaryExpiring => Intl.message(
    "An expiring domain. e.g. in the Redemption Grace Period, and possibly available via a backorder service",
    name: "domainSummaryExpiring",
    desc: "Domain summary expiring",
    locale: localName,
  );

  String get domainSummaryDeleting => Intl.message(
    "A expired domain pending removal from the registry. e.g. in the Pending Delete phase, and possibly available via a backorder service",
    name: "domainSummaryDeleting",
    desc: "Domain summary deleting",
    locale: localName,
  );

  String get domainSummaryPriced => Intl.message(
    "An aftermarket domain with an explicit price. e.g. via the BuyDomains service",
    name: "domainSummaryPriced",
    desc: "Domain summary priced",
    locale: localName,
  );

  String get domainSummaryTransferable => Intl.message(
    "An aftermarket domain available for fast-transfer. e.g. in the Afternic inventory",
    name: "domainSummaryTransferable",
    desc: "Domain summary transferable",
    locale: localName,
  );

  String get domainSummaryPremium => Intl.message(
    "Premium domain name for sale by the registry",
    name: "domainSummaryPremium",
    desc: "Domain summary premium",
    locale: localName,
  );

  String get domainSummarySuffix => Intl.message(
    "A public suffix according to publicsuffix.org",
    name: "domainSummarySuffix",
    desc: "Domain summary suffix",
    locale: localName,
  );

  String get domainSummaryZone => Intl.message(
    "A zone (domain extension) in the Domainr database",
    name: "domainSummaryZone",
    desc: "Domain summary zone",
    locale: localName,
  );

  String get domainSummaryTld => Intl.message(
    "A top-level domain",
    name: "domainSummaryTld",
    desc: "Domain summary tld",
    locale: localName,
  );

  String get domainSummaryUnknown => Intl.message(
    "Unknown status",
    name: "domainSummaryUnknown",
    desc: "Domain summary unknown",
    locale: localName,
  );

  // --- End of Domain summary messages --------------------------------------

  String get seoTools => Intl.message(
    "SEO Tools",
    name: "seoTools",
    desc: "SEO Tools title",
    locale: localName,
  );

  String get register => Intl.message(
    "Register",
    name: "register",
    desc: "Register button title",
    locale: localName,
  );
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ["en", "ru", "uk"].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
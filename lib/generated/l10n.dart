// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Advanced Mayan Numerals Converter Squared`
  String get title {
    return Intl.message(
      'Advanced Mayan Numerals Converter Squared',
      name: 'title',
      desc: 'Title for the application',
      args: [],
    );
  }

  /// `From number to glyph`
  String get titleSectionOne {
    return Intl.message(
      'From number to glyph',
      name: 'titleSectionOne',
      desc: '',
      args: [],
    );
  }

  /// `From glyph to number`
  String get titleSectionTwo {
    return Intl.message(
      'From glyph to number',
      name: 'titleSectionTwo',
      desc: '',
      args: [],
    );
  }

  /// `Classifier list`
  String get classifierButton {
    return Intl.message(
      'Classifier list',
      name: 'classifierButton',
      desc: '',
      args: [],
    );
  }

  /// `Classifiers`
  String get classifierTitle {
    return Intl.message(
      'Classifiers',
      name: 'classifierTitle',
      desc: '',
      args: [],
    );
  }

  /// `What are classifiers?`
  String get classifierInfoButton {
    return Intl.message(
      'What are classifiers?',
      name: 'classifierInfoButton',
      desc: '',
      args: [],
    );
  }

  /// `write a number`
  String get numberFieldHint {
    return Intl.message(
      'write a number',
      name: 'numberFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Configuration`
  String get configurationTitle {
    return Intl.message(
      'Configuration',
      name: 'configurationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get configurationOption0 {
    return Intl.message(
      'Language',
      name: 'configurationOption0',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get languageOption0 {
    return Intl.message(
      'Spanish',
      name: 'languageOption0',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get languageOption1 {
    return Intl.message(
      'English',
      name: 'languageOption1',
      desc: '',
      args: [],
    );
  }

  /// `Text method`
  String get configurationOption1 {
    return Intl.message(
      'Text method',
      name: 'configurationOption1',
      desc: '',
      args: [],
    );
  }

  /// `To count halves or pieces`
  String get classifier_list0 {
    return Intl.message(
      'To count halves or pieces',
      name: 'classifier_list0',
      desc: '',
      args: [],
    );
  }

  /// `To count handfuls`
  String get classifier_list1 {
    return Intl.message(
      'To count handfuls',
      name: 'classifier_list1',
      desc: '',
      args: [],
    );
  }

  /// `To count pieces that have been broken out of something rigid`
  String get classifier_list2 {
    return Intl.message(
      'To count pieces that have been broken out of something rigid',
      name: 'classifier_list2',
      desc: '',
      args: [],
    );
  }

  /// `To count plants`
  String get classifier_list3 {
    return Intl.message(
      'To count plants',
      name: 'classifier_list3',
      desc: '',
      args: [],
    );
  }

  /// `To count bundles of tied things`
  String get classifier_list4 {
    return Intl.message(
      'To count bundles of tied things',
      name: 'classifier_list4',
      desc: '',
      args: [],
    );
  }

  /// `For things carried in someone's back`
  String get classifier_list5 {
    return Intl.message(
      'For things carried in someone\'s back',
      name: 'classifier_list5',
      desc: '',
      args: [],
    );
  }

  /// `To count how many times somethings has happened`
  String get classifier_list6 {
    return Intl.message(
      'To count how many times somethings has happened',
      name: 'classifier_list6',
      desc: '',
      args: [],
    );
  }

  /// `To count the amount of objects someone can carry on their arms`
  String get classifier_list7 {
    return Intl.message(
      'To count the amount of objects someone can carry on their arms',
      name: 'classifier_list7',
      desc: '',
      args: [],
    );
  }

  /// `For piles`
  String get classifier_list8 {
    return Intl.message(
      'For piles',
      name: 'classifier_list8',
      desc: '',
      args: [],
    );
  }

  /// `To count inert objects`
  String get classifier_list9 {
    return Intl.message(
      'To count inert objects',
      name: 'classifier_list9',
      desc: '',
      args: [],
    );
  }

  /// `To count lashes or strokes`
  String get classifier_list10 {
    return Intl.message(
      'To count lashes or strokes',
      name: 'classifier_list10',
      desc: '',
      args: [],
    );
  }

  /// `To count armfuls`
  String get classifier_list11 {
    return Intl.message(
      'To count armfuls',
      name: 'classifier_list11',
      desc: '',
      args: [],
    );
  }

  /// `To count how many times an action is done`
  String get classifier_list12 {
    return Intl.message(
      'To count how many times an action is done',
      name: 'classifier_list12',
      desc: '',
      args: [],
    );
  }

  /// `To count overlapping things`
  String get classifier_list13 {
    return Intl.message(
      'To count overlapping things',
      name: 'classifier_list13',
      desc: '',
      args: [],
    );
  }

  /// `To count long and slender things`
  String get classifier_list14 {
    return Intl.message(
      'To count long and slender things',
      name: 'classifier_list14',
      desc: '',
      args: [],
    );
  }

  /// `To count humans and creatures, alive or dead`
  String get classifier_list15 {
    return Intl.message(
      'To count humans and creatures, alive or dead',
      name: 'classifier_list15',
      desc: '',
      args: [],
    );
  }

  /// `For book pages or anything slender and flat`
  String get classifier_list16 {
    return Intl.message(
      'For book pages or anything slender and flat',
      name: 'classifier_list16',
      desc: '',
      args: [],
    );
  }

  /// `For round objects`
  String get classifier_list17 {
    return Intl.message(
      'For round objects',
      name: 'classifier_list17',
      desc: '',
      args: [],
    );
  }

  /// `To count a torn piece, fragment or shred`
  String get classifier_list18 {
    return Intl.message(
      'To count a torn piece, fragment or shred',
      name: 'classifier_list18',
      desc: '',
      args: [],
    );
  }

  /// `To count a cut piece, fragment or shred`
  String get classifier_list19 {
    return Intl.message(
      'To count a cut piece, fragment or shred',
      name: 'classifier_list19',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

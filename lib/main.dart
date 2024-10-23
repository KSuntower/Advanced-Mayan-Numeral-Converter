import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:advanced_mayan_numeral_converter/screens/converter_screen.dart';
import 'package:advanced_mayan_numeral_converter/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class SpecifiedLocalizationDelegate
    extends LocalizationsDelegate<S> {
  final Locale overriddenLocale;

  const SpecifiedLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => null != overriddenLocale;

  @override
  Future<S> load(Locale locale) =>
      S.load(overriddenLocale);

  @override
  bool shouldReload(SpecifiedLocalizationDelegate old) => true;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SpecifiedLocalizationDelegate _localeOverrideDelegate;
  bool isReady = false;

  final _prefs = SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(allowList: {'locale'}));
  late Future<String> _loadedLocale;
  String _externalLoadedLocale = Intl.getCurrentLocale();

  Future<void> _loadLanguagePreferences() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    _externalLoadedLocale = (await prefs.getString('locale')) ?? Intl.getCurrentLocale().split('_')[0];
  }

  void onLocaleChange(Locale l) {
    setState(() {
      _localeOverrideDelegate = SpecifiedLocalizationDelegate(l);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadedLocale = _prefs.then((SharedPreferencesWithCache prefs) {
      debugPrint("getting...");
      return prefs.getString('locale') ?? Intl.getCurrentLocale();
    });
    _localeOverrideDelegate = SpecifiedLocalizationDelegate(Locale(_externalLoadedLocale, ""));
    _loadLanguagePreferences();
    _loadedLocale.then((String str) {
      _localeOverrideDelegate = SpecifiedLocalizationDelegate(Locale(str, ""));
      debugPrint("saved loaded: $str");
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => S.of(context).title,
      localizationsDelegates: [
        _localeOverrideDelegate,
        const AppLocalizationDelegate(),
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', '')
      ],
      locale: const Locale("es", ""),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ConverterScreen(onLocaleChange: onLocaleChange, prefs: _prefs,),
      // home: LoaderScreen(readyToDisplay: isReady,
      //     onLocaleChange: onLocaleChange,
      //     prefs: _prefs)
    );
  }
}

import 'package:flutter/material.dart';
import 'package:advanced_mayan_numeral_converter/generated/l10n.dart';
//import 'package:number_converter/helpers/classifier_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:advanced_mayan_numeral_converter/helpers/constants.dart';

class ConfigurationScreen extends StatefulWidget {
  final LocaleChangeCallback onLocaleChange;
  final Future<SharedPreferencesWithCache> prefs;
  const ConfigurationScreen({super.key, required this.onLocaleChange, required this.prefs});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  List<String> languageCodes = ["es", "en"];
  List<String> languageOptions = [
    S.current.languageOption0,
    S.current.languageOption1
  ];
  List<String> textMethods = ["M. Zavala", "P. Romero"];
  Future<void> _saveLanguagePreferences(String value) async {
    final SharedPreferencesWithCache myPrefs = await widget.prefs;
    setState(() {
      myPrefs.setString('locale', value);
      widget.onLocaleChange(Locale(value, ""));
      // reloadClassifierList();
      languageOptions = [
        S.current.languageOption0,
        S.current.languageOption1
      ];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).configurationTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            myDropdownButton(
                S.of(context).configurationOption0,
                Icons.language,
                List.generate(
                    languageOptions.length,
                        (index) => DropdownMenuItem(
                      value: languageCodes[index],
                      child: Text(languageOptions[index]),)
                ), (String? value) {
              _saveLanguagePreferences(value ?? Intl.getCurrentLocale());
            }),
            myDropdownButton(S.of(context).configurationOption1, Icons.code,
                List.generate(textMethods.length,
                        (index) => DropdownMenuItem(
                      value: textMethods[index],
                      child: Text(textMethods[index]),
                    )), (String? value) {
                  _saveLanguagePreferences(value ?? Intl.getCurrentLocale());
                }),
          ],
        ),
      ),
    );
  }
  Widget myDropdownButton(String buttonTitle, IconData icon, List<DropdownMenuItem<String>>? items, void Function(String?)? onChanged) {
    return DropdownButton(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
      elevation: 0,
      icon: Icon(icon),
      isExpanded: true,
      itemHeight: null,
      hint: Text(
        buttonTitle,
        style: const TextStyle(color: Colors.black),
      ),
      style: const TextStyle(
        fontSize: 40,
        color: Colors.black,
      ),
      underline: const SizedBox.shrink(),
      onChanged: onChanged,
      items: items,
    );
  }
}

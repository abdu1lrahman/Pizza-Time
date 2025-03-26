import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;
  void changeLanguage(Locale locale) {
    locale.languageCode == 'en'
        ? _locale = const Locale('ar')
        : _locale = const Locale('en');
    notifyListeners();
  }
}

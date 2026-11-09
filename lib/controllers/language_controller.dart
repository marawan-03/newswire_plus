import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends ChangeNotifier {
  static const _key = 'language';

  Locale? _locale;
  Locale? get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved != null) _locale = Locale(saved);
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _locale = Locale(code);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
  }
}

final languageController = LanguageController();

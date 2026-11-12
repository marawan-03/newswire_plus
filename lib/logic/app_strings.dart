import 'package:flutter/material.dart';

class AppStrings {
  static const _t = {
    'en': {
      'news': 'News',
      'search': 'Search',
      'settings': 'Settings',
      'theme': 'Theme',
      'fontSize': 'Font size',
      'language': 'Language',
      'system': 'System',
      'light': 'Light',
      'dark': 'Dark',
      'more': 'More',
      'less': 'Less',
      'open source': 'Open Source'
    },
    'ar': {
      'news': 'الأخبار',
      'search': 'بحث',
      'settings': 'الإعدادات',
      'theme': 'المظهر',
      'fontSize': 'حجم الخط',
      'language': 'اللغة',
      'system': 'النظام',
      'light': 'فاتح',
      'dark': 'غامق',
      'more': 'أقرأ المزيد',
      'less': 'أقرأ أقل',
      'open source': 'فتح المصدر'
    },
  };

  static String of(BuildContext context, String key) {
    final lang = Localizations.localeOf(context).languageCode;
    return _t[lang]?[key] ?? _t['en']![key] ?? key;
  }
}

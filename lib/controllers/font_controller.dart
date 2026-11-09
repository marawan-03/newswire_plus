import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FontSizeOption { small, medium, large }

class FontController extends ChangeNotifier {
  static const _key = 'font_size';

  FontSizeOption _size = FontSizeOption.medium;
  FontSizeOption get size => _size;

  double get scale => switch (_size) {
    FontSizeOption.small => 0.85,
    FontSizeOption.medium => 1.0,
    FontSizeOption.large => 1.2,
  };

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    _size = FontSizeOption.values.firstWhere(
          (o) => o.name == saved,
      orElse: () => FontSizeOption.medium,
    );
    notifyListeners();
  }

  Future<void> setSize(FontSizeOption size) async {
    if (size == _size) return;
    _size = size;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, size.name);
  }
}

final fontController = FontController();
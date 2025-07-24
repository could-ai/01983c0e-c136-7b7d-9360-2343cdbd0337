import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final preferencesServiceProvider = Provider<PreferencesService>((ref) => throw UnimplementedError());

class PreferencesService {
  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  static Future<PreferencesService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferencesService(prefs);
  }

  // Theme preferences
  static const String _themeModeKey = 'themeMode';

  Future<ThemeMode?> getThemeMode() async {
    final themeIndex = _prefs.getInt(_themeModeKey);
    if (themeIndex == null) return null;
    return ThemeMode.values[themeIndex];
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await _prefs.setInt(_themeModeKey, mode.index);
  }
}

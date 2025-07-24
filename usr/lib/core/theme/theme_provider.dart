import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bubble_chat_connect/core/theme/app_themes.dart';
import 'package:bubble_chat_connect/core/services/preferences_service.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final preferencesService = ref.read(preferencesServiceProvider);
  return ThemeNotifier(preferencesService);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final PreferencesService _preferencesService;

  ThemeNotifier(this._preferencesService) : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = await _preferencesService.getThemeMode();
    state = savedTheme ?? ThemeMode.system;
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newTheme;
    await _preferencesService.saveThemeMode(newTheme);
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await _preferencesService.saveThemeMode(mode);
  }
}

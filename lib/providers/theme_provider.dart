import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  late final Box<String> _themeBox;

  ThemeNotifier() : super(ThemeMode.system) {
    _init();
  }

  Future<void> _init() async {
    try {
      _themeBox = await Hive.openBox<String>('theme');
      final savedTheme = _themeBox.get('themeMode');
      if (savedTheme != null) {
        switch (savedTheme) {
          case 'light':
            state = ThemeMode.light;
            break;
          case 'dark':
            state = ThemeMode.dark;
            break;
          default:
            state = ThemeMode.system;
        }
      }
    } catch (e) {
      print('Error initializing theme: $e');
    }
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    try {
      state = themeMode;
      String themeString;
      switch (themeMode) {
        case ThemeMode.light:
          themeString = 'light';
          break;
        case ThemeMode.dark:
          themeString = 'dark';
          break;
        case ThemeMode.system:
          themeString = 'system';
          break;
      }
      await _themeBox.put('themeMode', themeString);
    } catch (e) {
      print('Error saving theme: $e');
    }
  }

  void toggleTheme() {
    switch (state) {
      case ThemeMode.light:
        setTheme(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setTheme(ThemeMode.light);
        break;
      case ThemeMode.system:
        setTheme(ThemeMode.light);
        break;
    }
  }
}

import 'package:flutter/material.dart';
import 'themes.dart';

class ThemeProvider extends InheritedWidget {

  const ThemeProvider({
    super.key,
    required this.themeMode,
    required this.toggleTheme,
    required super.child,
  });
  final ThemeMode themeMode;
  final VoidCallback toggleTheme;

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) =>
      themeMode != oldWidget.themeMode;
}
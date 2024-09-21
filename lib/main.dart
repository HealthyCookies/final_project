import 'package:flutter/material.dart';
import 'app_router/app_router.dart';
import 'themes/theme_provider.dart';
import 'themes/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  final AppThemes appThemes = AppThemes();

  void _toggleTheme() {
    setState(() {
      _themeMode =
      (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeMode: _themeMode,
      toggleTheme: _toggleTheme,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: appThemes.lightTheme,
        darkTheme: appThemes.darkTheme,
        themeMode: _themeMode,
        routerConfig: widget._appRouter.config(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_router/app_router.dart';
import 'common/providers/locale_provider.dart';
import 'common/providers/shared_preferences_provider.dart';
import 'core/service_initializer.dart';
import 'features/l10n/s.dart';
import 'themes/theme_notifier.dart';
import 'themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final ServiceInitializer serviceInitializer = ServiceInitializer(prefs);
  await serviceInitializer.initializeServices();

  runApp(ProviderScope(
    overrides: <Override>[
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeProvider);
    final Locale locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: _appRouter.config(),
      supportedLocales: S.supportedLocales,
      locale: locale,
      localizationsDelegates: S.localizationDelegates,
    );
  }
}

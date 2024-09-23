import 'package:final_project/use_cases/first_launch_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router/app_router.dart';
import 'common/providers/shared_preferences_provider.dart';
import 'features/main/data/activityDbService.dart';
import 'features/main/data/foodDbService.dart';
import 'features/main/data/ingredientDbService.dart';
import 'features/main/data/mealDbService.dart';
import 'themes/theme_notifier.dart';
import 'themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final ActivityDbService activityDbService = ActivityDbService();
  final FoodDbService foodDbService = FoodDbService();
  final IngredientDbService ingredientDbService = IngredientDbService();
  final MealDbService mealDbService = MealDbService();

  final FirstLaunchUseCase firstLaunchUseCase = FirstLaunchUseCase(
    prefs,
    activityDbService,
    foodDbService,
    ingredientDbService,
    mealDbService,
  );

  await firstLaunchUseCase.execute();

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

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: _appRouter.config(),
    );
  }
}

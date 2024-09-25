import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app_router/app_router.gr.dart';
import '../../../../common/providers/locale_provider.dart';
import '../../../../common/widgets/default_sliver_app_bar.dart';
import '../../../../themes/theme_notifier.dart';
import '../state_notifiers/daily_info_notifier.dart';
import '../widgets/caloric_intake_widget.dart';
import '../widgets/meal_info_widget.dart';

@RoutePage()
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale currentLocale = ref.watch(localeProvider);
    final DailyInfoState state = ref.watch(dailyInfoStateNotifierProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          DefaultSliverAppBar(
            leading: Bounceable(
              onTap: () => context.pushRoute(const AddMealRoute()),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Icon(Icons.add_rounded),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Text(
                  currentLocale.languageCode.toUpperCase(),
                ),
                onPressed: () {
                  if (currentLocale.languageCode == 'en') {
                    ref.read(localeProvider.notifier).state =
                        const Locale('ru');
                  } else {
                    ref.read(localeProvider.notifier).state =
                        const Locale('en');
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  ref.watch(themeProvider) == ThemeMode.dark
                      ? Icons.wb_sunny
                      : Icons.nightlight_round,
                ),
                onPressed: ref.read(themeProvider.notifier).toggleTheme,
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 16.0),
            sliver: SliverToBoxAdapter(
              child: state.loading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CaloricIntakeWidget(
                          goalCalories: state.totalCalories!,
                          currentCalories: state.todaysCalories!,
                        ),
                        IconButton(
                          onPressed: () => ref
                              .read(dailyInfoStateNotifierProvider.notifier)
                              .editTotalCcal(context),
                          icon: const Icon(Icons.edit_rounded),
                        ),
                      ],
                    ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 100.0),
            sliver: _MealsInfo(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(dailyInfoStateNotifierProvider.notifier)
            .addDailyInfo(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class _MealsInfo extends ConsumerStatefulWidget {
  const _MealsInfo();

  @override
  ConsumerState<_MealsInfo> createState() => __MealsInfoState();
}

class __MealsInfoState extends ConsumerState<_MealsInfo> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dailyInfoStateNotifierProvider.notifier).refreshInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final DailyInfoState state = ref.watch(dailyInfoStateNotifierProvider);

    if (state.loading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!state.loading && state.meals.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Text("You dodn't add any meal yet!"),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: MealInfoWidget(state.meals[index]),
          );
        },
        childCount: state.meals.length,
      ),
    );
  }
}

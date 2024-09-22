import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app_router/app_router.gr.dart';
import '../../../../common/widgets/default_sliver_app_bar.dart';
import '../../../../themes/theme_notifier.dart';
import '../widgets/caloric_intake_widget.dart';
import '../widgets/meal_info_widget.dart';

@RoutePage()
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                icon: Icon(
                  ref.read(themeProvider) == ThemeMode.dark
                      ? Icons.wb_sunny
                      : Icons.nightlight_round,
                ),
                onPressed: ref.read(themeProvider.notifier).toggleTheme,
              ),
            ],
          ),
          const SliverToBoxAdapter(child: CaloricIntakeWidget()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: MealInfoWidget(
                    title: 'Meal $index',
                    index: index,
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../../../app_router/app_router.gr.dart';
import '../../../../common/widgets/default_sliver_app_bar.dart';
import '../../../../themes/theme_provider.dart';
import '../widgets/caloric_intake_widget.dart';
import '../widgets/meal_info_widget.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider? themeProvider = ThemeProvider.of(context);

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
            // Add actions to the AppBar
            actions: [
              IconButton(
                icon: Icon(
                  themeProvider?.themeMode == ThemeMode.dark
                      ? Icons.wb_sunny
                      : Icons.nightlight_round,
                ),
                onPressed: () {
                  themeProvider?.toggleTheme();
                },
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

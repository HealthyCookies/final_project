import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/default_sliver_app_bar.dart';
import '../../../../domain/use_cases/load_meals.dart';
import '../../../l10n/s.dart';
import '../state_notifiers/meals_list_notifier.dart';
import '../widgets/meal_card_widget.dart';

@RoutePage()
class AllMealsScreen extends ConsumerWidget {
  const AllMealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          DefaultSliverAppBar(title: Text(S.of(context).mealsListTitle)),
          // Insert SliverToBoxAdapter with TextFormField here
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: S.of(context).searchMealsLabel,
                  hintText: S.of(context).searchMealsHint,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
                onChanged: (String value) {
                  // Call loadMeals method from MealsStateNotifier
                  ref
                      .read(mealsListStateNotifierProvider.notifier)
                      .loadMeals(LoadMealsParams(name: value));
                },
              ),
            ),
          ),
          const _MealsList(),
        ],
      ),
    );
  }
}


class _MealsList extends ConsumerStatefulWidget {
  const _MealsList();

  @override
  ConsumerState<_MealsList> createState() => __MealsListState();
}

class __MealsListState extends ConsumerState<_MealsList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(mealsListStateNotifierProvider.notifier)
          .loadMeals(const LoadMealsParams());
    });
  }

  @override
  Widget build(BuildContext context) {
    final MealsListState state = ref.watch(mealsListStateNotifierProvider);

    if (state.meals.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return SizedBox(child: MealCard(meal: state.meals[index]));
        },
        childCount: state.meals.length,
      ),
    );
  }
}

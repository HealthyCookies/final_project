import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/default_sliver_app_bar.dart';
import '../../../../domain/use_cases/load_meals.dart';
import '../state_notifiers/meals_list_notifier.dart';
import '../../../l10n/s.dart';

@RoutePage()
class AllMealsScreen extends ConsumerWidget {
  const AllMealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          DefaultSliverAppBar(title: Text(S.of(context).mealsListTitle)),
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
          return SizedBox(
            child: Text(state.meals[index].name),
          );
        },
        childCount: state.meals.length,
      ),
    );
  }
}

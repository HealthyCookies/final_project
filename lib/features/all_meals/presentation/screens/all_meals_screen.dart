import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/default_sliver_app_bar.dart';

@RoutePage()
class AllMealsScreen extends ConsumerWidget {
  @RoutePage()
  const AllMealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const DefaultSliverAppBar(title: Text('Meals List')),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Meal $index'),
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

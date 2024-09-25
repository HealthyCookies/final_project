import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/default_text_form_filed.dart';
import '../../domain/models/meal.dart';
import '../state_notifiers/search_meal_notifier.dart';

Future<void> showAddDailyMealDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        insetPadding: EdgeInsets.all(16.0),
        content: _SearchWidget(),
      );
    },
  );
}

// class _AlertDialogBody extends StatelessWidget {
//   const _AlertDialogBody();

//   @override
//   Widget build(BuildContext context) {
//     return const ;
//   }
// }

class _SearchWidget extends ConsumerWidget {
  const _SearchWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meal> meals = ref.watch(searchMealStateNotifierProvider);

    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: DefaultTextFormField(
              labelText: 'Search for a meal:',
              onChanged: (String query) {
                ref
                    .read(searchMealStateNotifierProvider.notifier)
                    .searchMeals(query);
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => ListTile(
              title: Text(meals[index].name),
            ),
          ),
        ),
      ],
    );
  }
}

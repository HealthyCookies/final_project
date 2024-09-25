import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/default_text_form_filed.dart';
import '../../domain/models/meal.dart';

Future<void> showAddDailyMealDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(16.0),
        content: const _AlertDialogBody(),
      );
    },
  );
}

class _AlertDialogBody extends StatelessWidget {
  const _AlertDialogBody();

  @override
  Widget build(BuildContext context) {
    return _SearchWidget();
  }
}

class _SearchWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DefaultTextFormField(
            labelText: 'Search for a meal:',
            onChanged: null,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(index.toString()),
              );
            },
            itemCount: 2,
          ),
        ),
      ],
    );
  }
}

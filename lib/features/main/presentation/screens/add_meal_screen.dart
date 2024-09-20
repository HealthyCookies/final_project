import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../../../common/dialogs/show_confirm_dialog.dart';
import '../../../../common/widgets/default_sliver_app_bar.dart';
import '../../../../common/widgets/default_text_form_filed.dart';

@RoutePage()
class AddMealScreen extends StatelessWidget {
  const AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          DefaultSliverAppBar(
            leading: Bounceable(
              onTap: context.maybePop,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Input the dish name, its type (Breakfast, Lunch, Dinner) and Calories',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.0),
                  DefaultTextFormFiled(
                    labelText: 'Name',
                  ),
                  SizedBox(height: 40.0),
                  DefaultTextFormFiled(),
                  SizedBox(height: 40.0),
                  DefaultTextFormFiled(
                    inputType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () async {
          if (await showConfirmDialog(context)) {
            log('Implement saving');
            if (context.mounted) {
              context.maybePop();
            }
          }
        },
      ),
    );
  }
}

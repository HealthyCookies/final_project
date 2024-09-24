import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../../../common/dialogs/show_confirm_dialog.dart';
import '../../../../common/widgets/default_sliver_app_bar.dart';
import '../../../../common/widgets/default_text_form_filed.dart';

@RoutePage()
class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  AddMealScreenState createState() => AddMealScreenState();
}

enum MealType {
  breakfast,
  lunch,
  dinner,
}

extension MealTypeExtension on MealType {
  String get displayName {
    switch (this) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
    }
  }
}

class MealTypeDropdown extends StatefulWidget {
  final MealType? initialType;
  final ValueChanged<MealType?> onTypeChanged;

  const MealTypeDropdown({
    Key? key,
    this.initialType,
    required this.onTypeChanged,
  }) : super(key: key);

  @override
  _MealTypeDropdownState createState() => _MealTypeDropdownState();
}

class _MealTypeDropdownState extends State<MealTypeDropdown> {
  MealType? selectedMealType;

  @override
  void initState() {
    super.initState();
    selectedMealType = widget.initialType;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<MealType>(
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Type',
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
      value: selectedMealType,
      items: MealType.values
          .map((MealType type) => DropdownMenuItem<MealType>(
                value: type,
                child: Text(type.displayName),
              ))
          .toList(),
      onChanged: (MealType? value) {
        setState(() {
          selectedMealType = value;
        });
        widget.onTypeChanged(value);
      },
    );
  }
}

class AddMealScreenState extends State<AddMealScreen> {
  MealType? selectedMealType;

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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Input the dish name, its type (Breakfast, Lunch, Dinner) and Calories',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40.0),
                  const DefaultTextFormFiled(
                    labelText: 'Name',
                  ),
                  const SizedBox(height: 40.0),
                  MealTypeDropdown(
                    initialType: selectedMealType,
                    onTypeChanged: (MealType? value) {
                      setState(() {
                        selectedMealType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 40.0),
                  const DefaultTextFormFiled(
                    labelText: 'Kilocalories',
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



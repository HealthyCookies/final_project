import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/dialogs/show_confirm_dialog.dart';
import '../../../../common/widgets/default_sliver_app_bar.dart';
import '../../../../common/widgets/default_text_form_filed.dart';
import '../../../l10n/s.dart';

@RoutePage()
class AddMealScreen extends ConsumerWidget {
  const AddMealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MealType? selectedMealType;

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
                  Text(
                    S.of(context).addMealScreenDescription,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40.0),
                  DefaultTextFormFiled(
                    labelText: S.of(context).addMealScreenFieldName,
                  ),
                  const SizedBox(height: 40.0),
                  MealTypeDropdown(
                    initialType: selectedMealType,
                    onTypeChanged: (MealType? value) {
                      selectedMealType = value;
                    },
                  ),
                  const SizedBox(height: 40.0),
                  DefaultTextFormFiled(
                    labelText: S.of(context).addMealScreenFieldKilocalories,
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

enum MealType {
  breakfast,
  lunch,
  dinner,
}

extension MealTypeExtension on MealType {
  String displayName(BuildContext context) {
    switch (this) {
      case MealType.breakfast:
        return S.of(context).titleBreakfast;
      case MealType.lunch:
        return S.of(context).titleLunch;
      case MealType.dinner:
        return S.of(context).titleDinner;
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
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: S.of(context).addMealScreenFieldType,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
      value: selectedMealType,
      items: MealType.values
          .map((MealType type) => DropdownMenuItem<MealType>(
                value: type,
                child: Text(type.displayName(context)),
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


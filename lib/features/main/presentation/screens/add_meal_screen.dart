import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/dialogs/show_confirm_dialog.dart';
import '../../../../common/widgets/default_text_form_filed.dart';
import '../../../l10n/s.dart';
import '../state_notifiers/add_meal_notifier.dart';

@RoutePage()
class AddMealScreen extends ConsumerWidget {
  const AddMealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AddMealNotifier addMealNotifier = ref.read(addMealStateNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.maybePop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Add Meal'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16.0),
            const Text(
              'Please fill in the details of your meal below.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            DefaultTextFormField(
              labelText: 'Meal Name',
              onChanged: addMealNotifier.setName,
            ),
            const SizedBox(height: 20.0),
            MealTypeDropdown(
              onTypeChanged: addMealNotifier.setType,
            ),
            const SizedBox(height: 20.0),
            DefaultTextFormField(
              labelText: 'Calories (kcal)',
              inputType: TextInputType.number,
              onChanged: addMealNotifier.setCalories,
            ),
            const SizedBox(height: 20.0),
            MacrosInputFields(
              onCarbsChanged: addMealNotifier.setCarbs,
              onProteinChanged: addMealNotifier.setProtein,
              onFatChanged: addMealNotifier.setFat,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton.icon(
              onPressed: () async {
                if (await showConfirmDialog(context)) {
                  await addMealNotifier.addMeal();
                  if (context.mounted) {
                    context.maybePop();
                  }
                }
              },
              icon: const Icon(Icons.check),
              label: const Text('Add Meal'),
            ),
          ],
        ),
      ),
    );
  }
}

class MacrosInputFields extends StatelessWidget {
  const MacrosInputFields({
    super.key,
    this.carbs,
    this.protein,
    this.fat,
    required this.onCarbsChanged,
    required this.onProteinChanged,
    required this.onFatChanged,
  });

  final String? carbs;
  final String? protein;
  final String? fat;
  final ValueChanged<String> onCarbsChanged;
  final ValueChanged<String> onProteinChanged;
  final ValueChanged<String> onFatChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: DefaultTextFormField(
            labelText: 'Carbs',
            inputType: TextInputType.number,
            onChanged: onCarbsChanged,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: DefaultTextFormField(
            labelText: 'Protein',
            inputType: TextInputType.number,
            onChanged: onProteinChanged,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: DefaultTextFormField(
            labelText: 'Fat',
            inputType: TextInputType.number,
            onChanged: onFatChanged,
          ),
        ),
      ],
    );
  }
}

enum MealType {
  breakfast,
  lunch,
  dinner;

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
  const MealTypeDropdown({
    super.key,
    this.initialType,
    required this.onTypeChanged,
  });

  final MealType? initialType;
  final ValueChanged<MealType?> onTypeChanged;

  @override
  // ignore: library_private_types_in_public_api
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

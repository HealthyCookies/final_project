import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/default_text_form_filed.dart';
import '../../domain/models/meal.dart';
import '../screens/add_meal_screen.dart';
import '../state_notifiers/search_meal_notifier.dart';

Future<Meal?> showAddDailyMealDialog(BuildContext context) async {
  Meal? meal;
  MealType type = MealType.breakfast;

  void onTypeChanged(MealType newType) {
    type = newType;
  }

  void onMealTapped(Meal newMeal) {
    meal = newMeal;
    context.maybePop();
  }

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(8.0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 16.0,
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.maxFinite,
          child: _DialogBody(
            onTypeChanged,
            onMealTapped,
          ),
        ),
      );
    },
  );

  return meal?.copyWith(type: type);
}

class _DialogBody extends ConsumerWidget {
  const _DialogBody(this.onTypeChanged, this.onMealTapped);

  final void Function(MealType type) onTypeChanged;
  final void Function(Meal meal) onMealTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meal>? meals = ref.watch(searchMealStateNotifierProvider);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DefaultTextFormField(
            labelText: 'Search for a meal:',
            onChanged: (String query) {
              ref
                  .read(searchMealStateNotifierProvider.notifier)
                  .searchMeals(query);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _MealTypeSelector(onTypeChanged),
        ),
        if (meals == null)
          const Center(
            child: Text('Start searching for a Meal'),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (BuildContext context, int index) => _MealListItem(
                meal: meals[index],
                onMealTapped: onMealTapped,
              ),
            ),
          ),
      ],
    );
  }
}

class _MealListItem extends StatelessWidget {
  const _MealListItem({
    required this.meal,
    required this.onMealTapped,
  });

  final Meal meal;
  final void Function(Meal) onMealTapped;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: _getMealColor(meal.type),
          child: Icon(
            _getMealIcon(meal.type),
            color: Colors.white,
            size: 30.0,
          ),
        ),
        title: Text(
          meal.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            '${meal.calories.toStringAsFixed(0)} kcal\n'
            'Carbs: ${meal.carbs.toStringAsFixed(0)}g\n'
            'Protein: ${meal.protein.toStringAsFixed(0)}g\n'
            'Fat: ${meal.fat.toStringAsFixed(0)}g',
            style: const TextStyle(fontSize: 12.0),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey.shade400,
        ),
        onTap: () => onMealTapped(meal),
      ),
    );
  }

  IconData _getMealIcon(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return Icons.free_breakfast;
      case MealType.lunch:
        return Icons.lunch_dining;
      case MealType.dinner:
        return Icons.restaurant;
    }
  }

  Color _getMealColor(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return Colors.orangeAccent;
      case MealType.lunch:
        return Colors.blueAccent;
      case MealType.dinner:
        return Colors.deepPurpleAccent;
    }
  }
}

class _MealTypeSelector extends StatefulWidget {
  const _MealTypeSelector(this.onChanged);

  final void Function(MealType type) onChanged;

  @override
  State<_MealTypeSelector> createState() => _MealTypeSelectorState();
}

class _MealTypeSelectorState extends State<_MealTypeSelector> {
  MealType _selectedMealType = MealType.breakfast;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: MealType.values.map((MealType type) {
        return Expanded(
          child: RadioListTile<MealType>(
            title: Text(
              _mealTypeToString(type),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            value: type,
            groupValue: _selectedMealType,
            onChanged: _onMealTypeChanged,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
        );
      }).toList(),
    );
  }

  void _onMealTypeChanged(MealType? value) {
    if (value != null) {
      widget.onChanged(value);
      setState(() {
        _selectedMealType = value;
      });
    }
  }

  String _mealTypeToString(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
    }
  }
}

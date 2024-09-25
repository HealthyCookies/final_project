// ignore_for_file: use_setters_to_change_properties

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/use_cases/add_meal.dart';
import '../../../../domain/use_cases/use_case.dart';
import '../../../all_meals/presentation/state_notifiers/meals_list_notifier.dart';
import '../screens/add_meal_screen.dart';

part 'add_meal_notifier.freezed.dart';

@freezed
class AddMealState with _$AddMealState {
  const factory AddMealState({
    required bool nameFieldHasError,
    required bool caloriesFieldHasError,
    required bool typeNotChoosen,
    required bool fatFieldHasError,
    required bool carbsFieldHasError,
    required bool proteinFieldHasError,
  }) = _AddMealState;

  factory AddMealState.initial() => const AddMealState(
        nameFieldHasError: false,
        caloriesFieldHasError: false,
        typeNotChoosen: false,
        fatFieldHasError: false,
        carbsFieldHasError: false,
        proteinFieldHasError: false,
      );
}

extension AddMealStateX on AddMealState {
  bool get isValid =>
      !nameFieldHasError &&
      !caloriesFieldHasError &&
      !typeNotChoosen &&
      !fatFieldHasError &&
      !carbsFieldHasError &&
      !proteinFieldHasError;
}

class AddMealNotifier extends StateNotifier<AddMealState> {
  AddMealNotifier(
    this._addMealUseCase,
    this._mealsStateNotifier,
  ) : super(AddMealState.initial());

  final UseCase<Future<void>, AddMealParams> _addMealUseCase;
  final MealsStateNotifier _mealsStateNotifier;

  String _name = '';
  String _calories = '';
  MealType? _type;
  String _fat = '';
  String _carbs = '';
  String _protein = '';

  void setName(String val) {
    _name = val;
  }

  void setCalories(String val) {
    _calories = val;
  }

  void setType(MealType? type) {
    _type = type;
  }

  void setFat(String val) {
    _fat = val;
  }

  void setCarbs(String val) {
    _carbs = val;
  }

  void setProtein(String val) {
    _protein = val;
  }

  Future<void> addMeal() async {
    if (_validate()) {
      final AddMealParams params = AddMealParams(
        name: _name,
        type: _type!,
        calories: double.parse(_calories),
        fat: double.tryParse(_fat) ?? 0.0,
        carbs: double.tryParse(_carbs) ?? 0.0,
        protein: double.tryParse(_protein) ?? 0.0,
      );
      await _addMealUseCase.execute(params);
      _mealsStateNotifier.refresh();
    }
  }

  bool _validate() {
    final AddMealState newState = AddMealState(
      nameFieldHasError: _name.isEmpty,
      caloriesFieldHasError:
          _calories.isEmpty && double.tryParse(_calories) == null,
      typeNotChoosen: _type == null,
      fatFieldHasError: _fat.isNotEmpty && double.tryParse(_fat) == null,
      carbsFieldHasError: _carbs.isNotEmpty && double.tryParse(_carbs) == null,
      proteinFieldHasError:
          _protein.isNotEmpty && double.tryParse(_protein) == null,
    );

    if (!newState.isValid) {
      state = newState;
      return false;
    }

    return true;
  }
}

final StateNotifierProvider<AddMealNotifier, AddMealState>
    addMealStateNotifierProvider =
    StateNotifierProvider<AddMealNotifier, AddMealState>(
        (StateNotifierProviderRef<AddMealNotifier, AddMealState> ref) {
  return AddMealNotifier(
    ref.watch(addMealUseCaseProvider),
    ref.read(mealsListStateNotifierProvider.notifier),
  );
});

import '../../features/main/data/mealDbService.dart';
import '../../features/main/domain/models/meal.dart';
import 'use_case.dart';

class LoadMealsParams {
  const LoadMealsParams({
    this.limit = 10,
    this.offset = 0,
    this.name,
  });

  final int limit;
  final int offset;
  final String? name;
}

class LoadMeals implements UseCase<Future<List<Meal>>, LoadMealsParams> {
  const LoadMeals(this.mealDbService);

  final MealDbService mealDbService;

  @override
  Future<List<Meal>> execute(LoadMealsParams params) async {
    final List<Meal> result = await mealDbService.getData(
      params.limit,
      params.offset,
      name: params.name,
    );

    return result;
  }
}

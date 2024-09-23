import 'package:uuid/uuid.dart';

class Food {
  final String id;

  final String name;

  final double calories;

  double carbs;

  double protein;

  double fat;

  Food({
    String? id,
    required this.name,
    required this.calories,
    this.carbs = 0.0,
    this.protein = 0.0,
    this.fat = 0.0,
  }) : id = id ?? _generateId();

  static String _generateId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'] as String,
      name: map['name'] as String,
      calories: map['calories'] as double,
      carbs: map['carbs'] as double? ?? 0.0,
      protein: map['protein'] as double? ?? 0.0,
      fat: map['fat'] as double? ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
    };
  }
}

import 'package:uuid/uuid.dart';

class Meal {
  Meal({
    String? id,
    required this.name,
    required this.calories,
    this.carbs = 0.0,
    this.protein = 0.0,
    this.fat = 0.0,
    this.foods = const <String, double>{},
  }) : id = id ?? _generateId();

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'] as String,
      name: map['name'] as String,
      calories: map['calories'] as double,
      carbs: map['carbs'] as double? ?? 0.0,
      protein: map['protein'] as double? ?? 0.0,
      fat: map['fat'] as double? ?? 0.0,
      foods: parseMealData(map['foods']),
    );
  }

  final String id;
  final String name;
  final double calories;
  double carbs;
  double protein;
  double fat;
  final Map<String, double> foods;

  static String _generateId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'foods': foods,
    };
  }

  static Map<String, double> parseMealData(String data) {
    if (data.startsWith('{') && data.endsWith('}')) {
      final String innerData = data.substring(1, data.length - 1);

      if (innerData.trim().isEmpty) {
        return <String, double>{};
      }

      final List<String> pairs = innerData.split(',');
      final Map<String, double> result = <String, double>{};

      for (final String pair in pairs) {
        final List<String> keyValue = pair.split('=');

        if (keyValue.length != 2) {
          throw FormatException('Invalid key-value pair: "$pair"');
        }

        final String key = keyValue[0].trim();
        final String valueStr = keyValue[1].trim();

        final double? value = double.tryParse(valueStr);
        if (value == null) {
          throw FormatException('Invalid number format for value: "$valueStr"');
        }

        result[key] = value;
      }

      return result;
    } else {
      throw const FormatException(
          'String must start with "{" and end with "}"');
    }
  }
}

import 'package:uuid/uuid.dart';

class Ingredient {
  final String id;
  final String name;

  Ingredient({
    String? id,
    required this.name,
  }) : id = id ?? _generateId();

  static String _generateId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

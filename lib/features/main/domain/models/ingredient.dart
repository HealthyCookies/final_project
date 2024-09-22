import 'package:uuid/uuid.dart';

/// Represents an ingredient with its name.
/// The [id] is automatically generated using UUID.
class Ingredient {
  /// The generated UUID for the ingredient item.
  final String id;

  /// The name of the ingredient.
  final String name;

  /// Creates an [Ingredient] with a given [name].
  /// If [id] is provided, it uses the provided [id], otherwise generates a new one.
  Ingredient({
    String? id,
    required this.name,
  }) : id = id ?? _generateId();

  /// Static function to generate UUIDs.
  static String _generateId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }

  /// Creates an [Ingredient] from a map.
  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  /// Converts an [Ingredient] to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

import 'package:uuid/uuid.dart';

/// Represents an ingredient with its name.
/// The [id] is automatically generated using UUID.
class Ingredient {
  /// Creates an [Ingredient] with a given [name].
  Ingredient({
    required this.name,
  }) : id = _generateId();

  /// The generated UUID for the ingredient item.
  final String id;

  /// The name of the ingredient.
  final String name;

  /// Static function to generate UUIDs.
  static String _generateId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }
}

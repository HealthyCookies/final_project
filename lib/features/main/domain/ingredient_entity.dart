import 'package:uuid/uuid.dart';

class IngredientEntity {
  IngredientEntity({
    required this.name,
  }) id = _generateId();

  final String name;

  static String _generateId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }
}

import 'package:uuid/uuid.dart';

/// Represents an activity, such as running or swimming, that burns calories.
/// The [id] is automatically generated using UUID.
class Activity {
  /// Creates an [Activity] with a given [name] and the amount of [caloriesBurned].
  Activity({
    required this.name,
    required this.caloriesBurned,
  }) : id = _generateId();

  /// The generated UUID for the activity.
  final String id;

  /// The name of the activity (e.g. 'Running').
  final String name;

  /// The amount of calories burned during the activity.
  final double caloriesBurned;

  /// Static function to generate UUIDs.
  static String _generateId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }
}

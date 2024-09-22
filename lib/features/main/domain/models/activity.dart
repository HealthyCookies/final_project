import 'package:uuid/uuid.dart';

/// Represents an activity, such as running or swimming, that burns calories.
/// The [id] is automatically generated using UUID.
class Activity {
  /// The generated UUID for the activity.
  final String id;

  /// The name of the activity (e.g. 'Running').
  final String name;

  /// The amount of calories burned during the activity.
  final double caloriesBurned;

  /// Creates an [Activity] with a given [name] and the amount of [caloriesBurned].
  /// If [id] is provided, it uses the provided [id], otherwise generates a new one.
  Activity({
    String? id,
    required this.name,
    required this.caloriesBurned,
  }) : id = id ?? _generateId();

  /// Static function to generate UUIDs.
  static String _generateId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }

  /// Creates an [Activity] from a map.
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] as String,
      name: map['name'] as String,
      caloriesBurned: (map['caloriesBurned'] as num).toDouble(),
    );
  }

  /// Converts an [Activity] to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'caloriesBurned': caloriesBurned,
    };
  }
}

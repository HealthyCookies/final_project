/// Represents an activity, such as running or swimming, that burns calories.
class Activity {
  /// Creates an [Activity] with a given [name] and the amount of [caloriesBurned].
  Activity({
    required this.name,
    required this.caloriesBurned,
  });

  /// The name of the activity (e.g. 'Running').
  final String name;

  /// The amount of calories burned during the activity.
  final double caloriesBurned;
}

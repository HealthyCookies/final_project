import 'package:uuid/uuid.dart';

class Activity {
  final String id;

  final String name;

  final double caloriesBurned;

  Activity({
    String? id,
    required this.name,
    required this.caloriesBurned,
  }) : id = id ?? _generateId();

  static String _generateId() {
    const Uuid uuid = Uuid();
    return uuid.v4();
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] as String,
      name: map['name'] as String,
      caloriesBurned: (map['caloriesBurned'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'caloriesBurned': caloriesBurned,
    };
  }
}

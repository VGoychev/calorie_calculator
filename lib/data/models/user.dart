import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final double height;
  @HiveField(5)
  final double weight;
  @HiveField(6)
  final double activityLevel;
  @HiveField(7)
  final int age;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.age,
  });

// Firestore -> User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      email: map['email'],
      name: map['name'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      height: (map['height'] ?? 0).toDouble(),
      weight: (map['weight'] ?? 0).toDouble(),
      activityLevel: (map['activity_level'] ?? 0).toDouble(),
      age: (map['age'] ?? 0).toInt(),
    );
  }

// User -> Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
      'height': height,
      'weight': weight,
      'activity_level': activityLevel,
      'age': age,
    };
  }

// Check if the user hasn’t filled profile yet
  bool get isNewUser {
    return height == 0 && weight == 0 && activityLevel == 0 && age == 0;
  }
}

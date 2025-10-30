import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String? email;
  final String? name;
  final DateTime createdAt;
  final double height;
  final double weight;
  final double activityLevel;
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

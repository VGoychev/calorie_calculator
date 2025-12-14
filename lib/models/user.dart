import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String? email;
  final String? name;
  final DateTime createdAt;
  final String gender;
  final double height;
  final double weight;
  final double activityLevel;
  final int age;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.gender,
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
      gender: map['gender'] ?? '',
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
      'gender': gender,
      'height': height,
      'weight': weight,
      'activity_level': activityLevel,
      'age': age,
    };
  }

// Check if the user hasn’t filled profile yet
  bool get isNewUser {
    return height == 0 &&
        weight == 0 &&
        activityLevel == 0 &&
        age == 0 &&
        gender.isEmpty;
  }

  // Local JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'gender': gender,
      'height': height,
      'weight': weight,
      'activity_level': activityLevel,
      'age': age,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] ?? '',
      email: json['email'],
      name: json['name'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      gender: json['gender'] ?? '',
      height: (json['height'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      activityLevel: (json['activity_level'] ?? 0).toDouble(),
      age: (json['age'] ?? 0).toInt(),
    );
  }
}

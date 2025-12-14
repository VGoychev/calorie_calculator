import 'dart:developer';

import 'package:calorie_calculator/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser({
    required String uid,
    required String? name,
    required String? email,
    required Timestamp createdAt,
  }) async {
    final userDoc = _firestore.collection('users').doc(uid);

    final user = User(
        uid: uid,
        name: name?.trim(),
        email: email?.trim(),
        createdAt: createdAt.toDate(),
        gender: '',
        height: 0,
        weight: 0,
        activityLevel: 0,
        age: 0);

    await userDoc.set(user.toMap());
  }

  Future<User?> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return User.fromMap(doc.data()!);
      }
      return null;
    } catch (e, stackTrace) {
      log(
        'Error getting user by ID',
        name: 'UserService',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> updateUser(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    await userDoc.update(user.toMap());
  }
}

import 'dart:developer' as developer;

import 'package:calorie_calculator/models/food_item.dart';
import 'package:calorie_calculator/models/user.dart';
import 'package:calorie_calculator/utils/helpers/text_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirestoreService firestoreService = FirestoreService();

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //
  // USER firestore methods
  //

  Future<void> addUser({
    required String uid,
    required String? name,
    required String? email,
    required Timestamp createdAt,
  }) async {
    try {
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
          age: 0,
          foodList: []);

      await userDoc.set(user.toMap());
    } catch (e) {
      developer.log("Error adding user: $e");
    }
  }

  Future<User?> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return User.fromMap(doc.data()!);
      }
      return null;
    } catch (e, stackTrace) {
      developer.log(
        'Error getting user by ID',
        name: 'UserService',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    final userDoc = _firestore.collection('users').doc(uid);
    await userDoc.update(data);
  }

  //
  // FOOD firestore methods
  //

  Future<void> addFoodItem(FoodItem foodItem) async {
    try {
      final foodDoc =
          _firestore.collection('food_items').doc(foodItem.name.toLowerCase());
      final itemDoc = await foodDoc.get();
      if (!itemDoc.exists && itemDoc.data() == null) {
        await foodDoc.set(foodItem.toMap());
      }
    } catch (e) {
      developer.log("Error adding FoddItem: $e");
    }
  }

  Future<FoodItem?> getFoodItemByName(String name) async {
    try {
      final doc = await _firestore
          .collection('food_items')
          .doc(name.toLowerCase())
          .get();
      if (doc.exists && doc.data() != null) {
        return FoodItem.fromMap(doc.data()!);
      }
      return null;
    } catch (e, stackTrace) {
      developer.log(
        'Error getting foodItem by name',
        name: 'FirestoreService',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<FoodItem?> getFoodItemByPartialName(String name) async {
    try {
      final normalizedInput = TextHelper.normalizeFoodName(name);
      final inputWords =
          normalizedInput.split(' ').map(TextHelper.singularize).toSet();

      final snapshot = await _firestore.collection('food_items').get();

      FoodItem? bestMatch;
      int bestWordCount = 0;

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final foodName = TextHelper.normalizeFoodName(data['name'] as String);

        final foodWords =
            foodName.split(' ').map(TextHelper.singularize).toSet();

        if (!inputWords.containsAll(foodWords)) continue;

        if (foodWords.length > bestWordCount) {
          bestWordCount = foodWords.length;
          bestMatch = FoodItem.fromMap(data);
        }
      }

      return bestMatch;
    } catch (e, stackTrace) {
      developer.log(
        'Error in getFoodItemByPartialName',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }
}

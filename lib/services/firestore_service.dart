import 'dart:developer' as developer;

import 'package:calorie_calculator/models/food_item.dart';
import 'package:calorie_calculator/models/user.dart';
import 'package:calorie_calculator/models/user_meal_entry.dart';
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
      );

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

  //
  // MEALS firestore methods
  //

  String _getDateString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Add meals to a specific meal type for a specific date
  Future<void> addMeals({
    required String uid,
    required DateTime date,
    required String mealType,
    required List<UserMealEntry> meals,
  }) async {
    try {
      final dateString = _getDateString(date);
      final path = 'users/$uid/meals/$dateString/$mealType';
      developer.log('Adding ${meals.length} meals to path: $path');
      developer.log('Date string: $dateString, Meal type: $mealType');

      final mealsRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('meals')
          .doc(dateString)
          .collection(mealType);

      for (final meal in meals) {
        final mealMap = meal.toMap();
        developer.log('Adding meal: ${meal.name}, quantity: ${meal.quantity}');
        developer.log('Meal map keys: ${mealMap.keys}');
        await mealsRef.add(mealMap);
      }

      developer.log('Successfully added ${meals.length} meals to $mealType');
    } catch (e, stackTrace) {
      developer.log(
        'Error adding meals',
        name: 'FirestoreService',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Get meals for a specific meal type and date
  Future<List<UserMealEntry>> getMeals({
    required String uid,
    required DateTime date,
    required String mealType,
  }) async {
    try {
      final dateString = _getDateString(date);
      final path = 'users/$uid/meals/$dateString/$mealType';
      developer.log('Getting meals from path: $path');

      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('meals')
          .doc(dateString)
          .collection(mealType)
          .get();

      developer.log(
          'Found ${snapshot.docs.length} documents in $mealType for date $dateString');

      final meals = snapshot.docs
          .map((doc) {
            try {
              final data = doc.data();
              developer.log('Document data: ${data.keys}');
              return UserMealEntry.fromMap(data);
            } catch (e) {
              developer.log('Error parsing document ${doc.id}: $e');
              return null;
            }
          })
          .whereType<UserMealEntry>()
          .toList();

      developer.log('Successfully parsed ${meals.length} meals');
      return meals;
    } catch (e, stackTrace) {
      developer.log(
        'Error getting meals',
        name: 'FirestoreService',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  /// Get all meals for a specific date (all meal types)
  Future<Map<String, List<UserMealEntry>>> getAllMealsForDate({
    required String uid,
    required DateTime date,
  }) async {
    try {
      final dateString = _getDateString(date);
      developer.log('Getting all meals for date: $dateString, uid: $uid');

      final allMealsDocs = await _firestore
          .collection('users')
          .doc(uid)
          .collection('meals')
          .get();
      developer
          .log('Total meals documents for user: ${allMealsDocs.docs.length}');
      if (allMealsDocs.docs.isNotEmpty) {
        developer.log(
            'Available date documents: ${allMealsDocs.docs.map((d) => d.id).toList()}');
      }

      final breakfast =
          await getMeals(uid: uid, date: date, mealType: 'breakfast');
      final lunch = await getMeals(uid: uid, date: date, mealType: 'lunch');
      final dinner = await getMeals(uid: uid, date: date, mealType: 'dinner');

      developer.log(
          'Total meals retrieved - Breakfast: ${breakfast.length}, Lunch: ${lunch.length}, Dinner: ${dinner.length}');

      return {
        'breakfast': breakfast,
        'lunch': lunch,
        'dinner': dinner,
      };
    } catch (e, stackTrace) {
      developer.log(
        'Error getting all meals for date',
        name: 'FirestoreService',
        error: e,
        stackTrace: stackTrace,
      );
      return {
        'breakfast': [],
        'lunch': [],
        'dinner': [],
      };
    }
  }
}

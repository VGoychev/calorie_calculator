import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:calorie_calculator/models/food_item.dart';

class UserMealEntry {
  final String name;
  final String unit;
  final String category;
  final double caloriesPer100;
  final double proteinPer100;
  final double carbsPer100;
  final double fatsPer100;
  final Map<String, dynamic> carbohydrates;
  final Map<String, dynamic> vitamins;
  final Map<String, dynamic> aminoAcids;
  final Map<String, dynamic> fatsDetail;
  final Map<String, dynamic> minerals;
  final Map<String, dynamic> sterols;
  final Map<String, dynamic> other;
  final DateTime createdAt;

  final int quantity;

  UserMealEntry({
    required this.name,
    required this.unit,
    required this.category,
    required this.caloriesPer100,
    required this.proteinPer100,
    required this.carbsPer100,
    required this.fatsPer100,
    required this.carbohydrates,
    required this.vitamins,
    required this.aminoAcids,
    required this.fatsDetail,
    required this.minerals,
    required this.sterols,
    required this.other,
    required this.createdAt,
    required this.quantity,
  });

  factory UserMealEntry.fromFoodItem({
    required FoodItem foodItem,
    required int quantity,
  }) {
    return UserMealEntry(
      name: foodItem.name,
      unit: foodItem.unit,
      category: foodItem.category,
      caloriesPer100: foodItem.caloriesPer100,
      proteinPer100: foodItem.proteinPer100,
      carbsPer100: foodItem.carbsPer100,
      fatsPer100: foodItem.fatsPer100,
      carbohydrates: foodItem.carbohydrates,
      vitamins: foodItem.vitamins,
      aminoAcids: foodItem.aminoAcids,
      fatsDetail: foodItem.fatsDetail,
      minerals: foodItem.minerals,
      sterols: foodItem.sterols,
      other: foodItem.other,
      createdAt: foodItem.createdAt,
      quantity: quantity,
    );
  }

  // Firestore -> UserMealEntry
  factory UserMealEntry.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> toMap(dynamic value) =>
        value != null ? Map<String, dynamic>.from(value) : {};

    return UserMealEntry(
      name: map['name'] ?? '',
      unit: map['unit'] ?? '',
      category: map['category'] ?? '',
      caloriesPer100: (map['caloriesPer100'] ?? 0).toDouble(),
      proteinPer100: (map['proteinPer100'] ?? 0).toDouble(),
      carbsPer100: (map['carbsPer100'] ?? 0).toDouble(),
      fatsPer100: (map['fatsPer100'] ?? 0).toDouble(),
      carbohydrates: toMap(map['carbohydrates']),
      vitamins: toMap(map['vitamins']),
      aminoAcids: toMap(map['aminoAcids']),
      fatsDetail: toMap(map['fatsDetail']),
      minerals: toMap(map['minerals']),
      sterols: toMap(map['sterols']),
      other: toMap(map['other']),
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      quantity: map['quantity'] ?? 0,
    );
  }

  // UserMealEntry -> Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name.toLowerCase(),
      'unit': unit,
      'category': category,
      'caloriesPer100': caloriesPer100,
      'proteinPer100': proteinPer100,
      'carbsPer100': carbsPer100,
      'fatsPer100': fatsPer100,
      'carbohydrates': carbohydrates,
      'vitamins': vitamins,
      'aminoAcids': aminoAcids,
      'fatsDetail': fatsDetail,
      'minerals': minerals,
      'sterols': sterols,
      'other': other,
      'createdAt': Timestamp.fromDate(createdAt),
      'quantity': quantity,
    };
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItem {
  final String name;
  final String unit;
  final String category;
  final int exampleQuantity;
  final double caloriesPer100;
  final double proteinPer100;
  final double carbsPer100;
  final double fatsPer100;

  final DateTime createdAt;

  FoodItem({
    required this.name,
    required this.unit,
    required this.category,
    required this.exampleQuantity,
    required this.caloriesPer100,
    required this.proteinPer100,
    required this.carbsPer100,
    required this.fatsPer100,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'unit': unit,
        'category': category,
        'exampleQuantity': exampleQuantity,
        'caloriesPer100': caloriesPer100,
        'proteinPer100': proteinPer100,
        'carbsPer100': carbsPer100,
        'fatsPer100': fatsPer100,
        'createdAt': createdAt
      };

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
        name: json['name'],
        unit: json['unit'],
        category: json['category'],
        exampleQuantity: json['exampleQuantity'],
        caloriesPer100: json['caloriesPer100'],
        proteinPer100: json['proteinPer100'],
        carbsPer100: json['carbsPer100'],
        fatsPer100: json['fatsPer100'],
        createdAt: DateTime.now());
  }

  // Firestore -> FoodItem
  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      name: map['name'] ?? '',
      unit: map['unit'],
      category: map['category'],
      caloriesPer100: map['caloriesPer100'],
      proteinPer100: map['proteinPer100'],
      carbsPer100: map['carbsPer100'],
      fatsPer100: map['fatsPer100'],
      exampleQuantity: map['exampleQuantity'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // FoodItem -> Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name.toLowerCase(),
      'unit': unit,
      'category': category,
      'exampleQuantity': exampleQuantity,
      'caloriesPer100': caloriesPer100,
      'proteinPer100': proteinPer100,
      'carbsPer100': carbsPer100,
      'fatsPer100': fatsPer100,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

List<FoodItem> createFoodItemFromAI({
  required String userInput,
  required Map<String, dynamic> aiResponse,
}) {
  final foods =
      (aiResponse['foods'] as List).map((f) => FoodItem.fromJson(f)).toList();

  return foods;
}

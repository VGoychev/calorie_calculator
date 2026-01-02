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

  final Map<String, dynamic> carbohydrates; 
  final Map<String, dynamic> vitamins;
  final Map<String, dynamic> aminoAcids;
  final Map<String, dynamic> fatsDetail;
  final Map<String, dynamic> minerals;
  final Map<String, dynamic> sterols;
  final Map<String, dynamic> other; 

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
    required this.carbohydrates,
    required this.vitamins,
    required this.aminoAcids,
    required this.fatsDetail,
    required this.minerals,
    required this.sterols,
    required this.other,
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
        'carbohydrates': carbohydrates,
        'vitamins': vitamins,
        'aminoAcids': aminoAcids,
        'fatsDetail': fatsDetail,
        'minerals': minerals,
        'sterols': sterols,
        'other': other,
        'createdAt': createdAt
      };

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> toMap(dynamic value) =>
        value != null ? Map<String, dynamic>.from(value) : {};

    return FoodItem(
        name: json['name'],
        unit: json['unit'],
        category: json['category'],
        exampleQuantity: json['exampleQuantity'],
        caloriesPer100: json['caloriesPer100'],
        proteinPer100: json['proteinPer100'],
        carbsPer100: json['carbsPer100'],
        fatsPer100: json['fatsPer100'],
        carbohydrates: toMap(json['carbohydrates']),
        vitamins: toMap(json['vitamins']),
        aminoAcids: toMap(json['aminoAcids']),
        fatsDetail: toMap(json['fatsDetail']),
        minerals: toMap(json['minerals']),
        sterols: toMap(json['sterols']),
        other: toMap(json['other']),
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
      carbohydrates: map['carbohydrates'],
      vitamins: map['vitamins'],
      aminoAcids: map['aminoAcids'],
      fatsDetail: map['fatsDetail'],
      minerals: map['minerals'],
      sterols: map['sterols'],
      other: map['other'],
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
      'carbohydrates': carbohydrates,
      'vitamins': vitamins,
      'aminoAcids': aminoAcids,
      'fatsDetail': fatsDetail,
      'minerals': minerals,
      'sterols': sterols,
      'other': other,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory FoodItem.withDefaultMicros({
    required String name,
    required String unit,
    required String category,
    required int exampleQuantity,
    required double caloriesPer100,
    required double proteinPer100,
    required double carbsPer100,
    required double fatsPer100,
  }) {
    Map<String, dynamic> emptyMap(String fieldName, List<String> keys) {
      return {for (var key in keys) key: "No data"};
    }

    return FoodItem(
      name: name,
      unit: unit,
      category: category,
      exampleQuantity: exampleQuantity,
      caloriesPer100: caloriesPer100,
      proteinPer100: proteinPer100,
      carbsPer100: carbsPer100,
      fatsPer100: fatsPer100,
      carbohydrates: emptyMap("carbohydrates", [
        "Fibers",
        "Starch",
        "Sugars",
        "Galactose",
        "Glucose",
        "Sucrose",
        "Lactose",
        "Maltose",
        "Fructose"
      ]),
      vitamins: emptyMap("vitamins", [
        "Betaine",
        "Vitamin A",
        "Vitamin B1 (Thiamine)",
        "Vitamin B2 (Riboflavin)",
        "Vitamin B3 (Niacin)",
        "Vitamin B4 (Choline)",
        "Vitamin B5 (Pantothenic Acid)",
        "Vitamin B6 (Pyridoxine)",
        "Vitamin B9 (Folic Acid)",
        "Vitamin B12 (Cobalamin)",
        "Vitamin C",
        "Vitamin D",
        "Vitamin E",
        "Vitamin K1",
        "Vitamin K2 (MK-4)"
      ]),
      aminoAcids: emptyMap("aminoAcids", [
        "Alanine",
        "Arginine",
        "Aspartic Acid",
        "Valine",
        "Glycine",
        "Glutamine",
        "Isoleucine",
        "Leucine",
        "Lysine",
        "Methionine",
        "Proline",
        "Serine",
        "Tyrosine",
        "Threonine",
        "Tryptophan",
        "Phenylalanine",
        "Hydroxyproline",
        "Histidine",
        "Cystine"
      ]),
      fatsDetail: emptyMap("fatsDetail", [
        "Total Fat",
        "Monounsaturated Fat",
        "Polyunsaturated Fat",
        "Saturated Fat",
        "Trans Fat"
      ]),
      minerals: emptyMap("minerals", [
        "Iron",
        "Potassium",
        "Calcium",
        "Magnesium",
        "Manganese",
        "Copper",
        "Sodium",
        "Selenium",
        "Fluoride",
        "Phosphorus",
        "Zinc"
      ]),
      sterols: emptyMap("sterols", [
        "Cholesterol",
        "Phytosterols",
        "Stigmasterol",
        "Campesterol",
        "Beta-sitosterol"
      ]),
      other: emptyMap(
          "other", ["Alcohol", "Water", "Caffeine", "Theobromine", "Ash"]),
      createdAt: DateTime.now(),
    );
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

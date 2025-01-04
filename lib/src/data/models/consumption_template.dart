import '../all.dart' show ConsumptionCompanion;
import '../enums/meal_type.dart';

class ConsumptionTemplate {
  String productCode = '';
  MealType mealType = MealType.other;
  int servingSizeId = 0;
  double quantity = 0;

  ConsumptionCompanion getForInsert() {
    return ConsumptionCompanion.insert(
      mealType: mealType,
      productCode: productCode,
      quantity: quantity,
      servingSizeId: servingSizeId,
      loggedOn: DateTime.now(),
    );
  }

  static ConsumptionTemplate fromValues({
    String? productCode,
    MealType? mealType,
    int? servingSizeId,
    double? quantity,
  }) {
    var result = ConsumptionTemplate();

    result.productCode = productCode ?? '';
    result.mealType = mealType ?? MealType.other;
    result.servingSizeId = servingSizeId ?? 0;
    result.quantity = quantity ?? 0;

    return result;
  }
}

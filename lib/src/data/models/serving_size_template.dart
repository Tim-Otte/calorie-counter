import 'package:drift/drift.dart';

import '../all.dart' show ServingSizeCompanion, ServingSizeData;

class ServingSizeTemplate {
  String name = '';
  String? short;
  double amount = 0;
  int baseServingSize = 0;

  ServingSizeCompanion getForInsert(
    String forProduct,
    ServingSizeData baseServingSizeData,
  ) {
    return ServingSizeCompanion.insert(
      name: name,
      short: Value.absentIfNull(short),
      measuringUnit: baseServingSizeData.measuringUnit,
      valueInBaseServingSize: amount,
      baseServingSizeId: Value(baseServingSizeData.id),
      forProduct: Value(forProduct),
      isLiquid: Value(baseServingSizeData.isLiquid),
    );
  }

  static ServingSizeTemplate fromValues({
    required String name,
    String? short,
    required double amount,
    required int baseServingSize,
  }) {
    var result = ServingSizeTemplate();

    result.name = name;
    result.short = short;
    result.amount = amount;
    result.baseServingSize = baseServingSize;

    return result;
  }
}

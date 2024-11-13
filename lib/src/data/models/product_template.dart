class ProductTemplate {
  String productCode = '';
  String name = '';
  String brand = '';
  bool isLiquid = false;
  double? caloriesPer100 = 0;
  double? carbsPer100 = 0;
  double? fatsPer100 = 0;
  double? proteinsPer100 = 0;

  bool get isNotEmpty =>
      productCode.isNotEmpty &&
      name.isNotEmpty &&
      brand.isNotEmpty &&
      !(caloriesPer100 ?? -1).isNegative &&
      !(carbsPer100 ?? -1).isNegative &&
      !(fatsPer100 ?? -1).isNegative &&
      !(proteinsPer100 ?? -1).isNegative;

  static ProductTemplate fromValues({
    String? productCode,
    String? name,
    String? brand,
    bool? isLiquid,
    double? caloriesPer100,
    double? carbsPer100,
    double? fatsPer100,
    double? proteinsPer100,
  }) {
    var result = ProductTemplate();

    result.productCode = productCode ?? '';
    result.name = name ?? '';
    result.brand = brand ?? '';
    result.isLiquid = isLiquid ?? false;
    result.caloriesPer100 = caloriesPer100 ?? 0;
    result.carbsPer100 = carbsPer100 ?? 0;
    result.fatsPer100 = fatsPer100 ?? 0;
    result.proteinsPer100 = proteinsPer100 ?? 0;

    return result;
  }
}
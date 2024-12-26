import '../database.dart' show ConsumptionData, ProductData, ServingSizeData;

class ConsumptionEntry {
  final ConsumptionData consumption;
  final ProductData product;
  final ServingSizeData servingSize;

  const ConsumptionEntry({
    required this.consumption,
    required this.product,
    required this.servingSize,
  });
}

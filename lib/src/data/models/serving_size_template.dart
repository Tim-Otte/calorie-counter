class ServingSizeTemplate {
  String name = '';
  double amount = 0;
  int baseServingSize = 0;

  static ServingSizeTemplate fromValues({
    required String name,
    required double amount,
    required int baseServingSize,
  }) {
    var result = ServingSizeTemplate();

    result.name = name;
    result.amount = amount;
    result.baseServingSize = baseServingSize;

    return result;
  }
}

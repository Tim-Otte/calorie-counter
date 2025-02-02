import '../all.dart'
    show RecipeIngredientCompanion, ProductData, ServingSizeData;

class RecipeIngredientTemplate {
  ProductData? product;
  ServingSizeData? servingSize;
  double quantity = 0;

  RecipeIngredientCompanion getForInsert(String recipeName) {
    return RecipeIngredientCompanion.insert(
      recipe: recipeName,
      product: product!.productCode,
      servingSize: servingSize!.id,
      quantity: quantity,
    );
  }

  static RecipeIngredientTemplate fromValues({
    ProductData? product,
    ServingSizeData? servingSize,
    double? quantity,
  }) {
    var result = RecipeIngredientTemplate();

    if (product != null) {
      result.product = product;
    }
    if (servingSize != null) {
      result.servingSize = servingSize;
    }
    result.quantity = quantity ?? 0;

    return result;
  }
}

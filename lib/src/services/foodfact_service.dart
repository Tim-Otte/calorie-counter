import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../data/all.dart' show ServingSizeData;
import '../data/models/all.dart';

class FoodFactService {
  static Color brandColor = Color(0xffff8714);
  static Uri brandUri = Uri.https('world.openfoodfacts.org', '/data');

  OpenFoodFactsLanguage language = OpenFoodFactsLanguage.ENGLISH;

  void setupApiConfig() {
    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'calorie_counter',
      url: 'https://github.com/Tim-Otte/calorie-counter',
    );
  }

  void setLanguage(Locale locale) {
    final lang = OpenFoodFactsLanguage.fromOffTag(locale.languageCode);

    if (lang != null) language = lang;

    OpenFoodAPIConfiguration.globalLanguages = [language];
    OpenFoodAPIConfiguration.globalCountry =
        OpenFoodFactsCountry.fromOffTag(locale.languageCode) ??
            OpenFoodFactsCountry.USA;
  }

  Future<ProductResultV3> getProduct(String productCode) {
    var config = ProductQueryConfiguration(
      productCode,
      version: ProductQueryVersion.v3,
    );

    return OpenFoodAPIClient.getProductV3(config);
  }

  Future<List<Product>> search(String productCodeOrName) async {
    if (productCodeOrName.isEmpty) return Future.value([]);

    var config = ProductSearchQueryConfiguration(
      parametersList: [
        SearchTerms(terms: [productCodeOrName])
      ],
      fields: [
        ProductField.BARCODE,
        ProductField.NAME_ALL_LANGUAGES,
        ProductField.BRANDS,
        ProductField.SERVING_QUANTITY,
        ProductField.SERVING_SIZE,
        ProductField.PACKAGING_QUANTITY,
        ProductField.NUTRIMENTS,
        ProductField.IMAGE_FRONT_SMALL_URL,
        ProductField.CATEGORIES_TAGS,
      ],
      version: ProductQueryVersion.v3,
    );

    if (int.tryParse(productCodeOrName) != null) {
      var result = await getProduct(productCodeOrName);
      if (result.product != null) {
        return Future.value([result.product!]);
      }
    }

    var result = await OpenFoodAPIClient.searchProducts(null, config);
    return Future.value(result.products
            ?.where((p) => p.getBestProductName(language).isNotEmpty)
            .toList() ??
        []);
  }

  ProductTemplate getProductDataFromProduct(
    Product product,
    List<ServingSizeData> baseServingSizes,
  ) {
    var calories = product.nutriments!.getValue(
      Nutrient.energyKCal,
      PerSize.oneHundredGrams,
    );
    var carbs = product.nutriments!.getValue(
      Nutrient.carbohydrates,
      PerSize.oneHundredGrams,
    );
    var fat = product.nutriments!.getValue(
      Nutrient.fat,
      PerSize.oneHundredGrams,
    );
    var proteins = product.nutriments!.getValue(
      Nutrient.proteins,
      PerSize.oneHundredGrams,
    );

    return ProductTemplate.fromValues(
      productCode: product.barcode!,
      name: product.getBestProductName(language),
      brand: product.getFirstBrand()!,
      isLiquid: product.categoriesTags?.contains('en:beverages') ?? false,
      caloriesPer100: calories ?? 0,
      carbsPer100: carbs ?? 0,
      fatsPer100: fat ?? 0,
      proteinsPer100: proteins ?? 0,
    );
  }

  List<ServingSizeTemplate> getServingSizesFromProduct(
    Product product,
    List<ServingSizeData> baseServingSizes,
    String servingTranslation,
    String containerTranslation,
  ) {
    var servingSize = _getServingSize(product, baseServingSizes);
    var result = <ServingSizeTemplate>[];

    if (product.servingQuantity != null) {
      result.add(ServingSizeTemplate.fromValues(
        name: servingTranslation,
        amount: product.servingQuantity ?? 1,
        baseServingSize: servingSize.id,
      ));
    }

    if (product.packagingQuantity != null) {
      result.add(ServingSizeTemplate.fromValues(
        name: containerTranslation,
        amount: product.packagingQuantity ?? 1,
        baseServingSize: servingSize.id,
      ));
    }

    return result;
  }

  ServingSizeData _getServingSize(
    Product product,
    List<ServingSizeData> servingSizes,
  ) {
    var isLiquid = product.categoriesTags?.contains('en:beverages') ?? false;
    var unit = isLiquid ? 'ml' : 'g';

    return servingSizes
        .where((element) => element.short?.toLowerCase() == unit.toLowerCase())
        .first;
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../data/all.dart' show ServingSizeData;
import '../data/models/all.dart';

class FoodFactService {
  /// Brand color for OpenFoodFacts.
  static Color brandColor = Color(0xffff8714);

  /// Brand URI for OpenFoodFacts.
  static Uri brandUri = Uri.https('world.openfoodfacts.org', '/data');

  OpenFoodFactsLanguage language = OpenFoodFactsLanguage.ENGLISH;

  /// Sets up the API configuration for the OpenFoodAPI.
  ///
  /// This method configures the user agent for the OpenFoodAPI with the
  /// specified name and URL. The user agent is used to identify the
  /// application making requests to the API.
  void setupApiConfig() {
    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'calorie_counter',
      url: 'https://github.com/Tim-Otte/calorie-counter',
    );
  }

  /// Sets the language and country configuration for the OpenFoodFacts API.
  ///
  /// This method takes a [Locale] object and sets the global language and
  /// country configuration for the OpenFoodFacts API based on the provided
  /// locale. If the language code from the locale is not recognized, it
  /// defaults to the USA.
  ///
  /// Parameters:
  /// - [locale]: The locale to set the language and country configuration.
  void setLanguage(Locale locale) {
    final lang = OpenFoodFactsLanguage.fromOffTag(locale.languageCode);

    if (lang != null) language = lang;

    OpenFoodAPIConfiguration.globalLanguages = [language];
    OpenFoodAPIConfiguration.globalCountry =
        OpenFoodFactsCountry.fromOffTag(locale.languageCode) ??
            OpenFoodFactsCountry.USA;
  }

  /// Fetches the product details for the given product code using the OpenFoodAPIClient.
  ///
  /// This method constructs a [ProductQueryConfiguration] with the provided
  /// [productCode] and queries the OpenFoodAPIClient to retrieve the product
  /// information.
  ///
  /// Parameters:
  /// - [productCode]: The code of the product to be fetched.
  ///
  /// Returns a [Future] that completes with a [ProductResultV3] containing the
  /// product details.
  Future<ProductResultV3> getProduct(String productCode) {
    var config = ProductQueryConfiguration(
      productCode,
      version: ProductQueryVersion.v3,
    );

    return OpenFoodAPIClient.getProductV3(config);
  }

  /// Searches for products based on the provided product code or name.
  ///
  /// Parameters:
  /// - [productCodeOrName] - The product code or name to search for.
  ///  If empty, an empty list is returned. If a valid product code, it
  ///  attempts to fetch the product directly. Otherwise, it performs a
  ///  search using the OpenFoodAPIClient.
  ///
  /// Returns a list of [Product] objects that match the search criteria.
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

  /// Extracts and returns a [ProductTemplate] from a given [Product] object.
  ///
  /// This method retrieves nutritional information (calories, carbohydrates, fat, and proteins)
  /// per 100 grams from the provided [Product] and constructs a [ProductTemplate] using these values.
  ///
  /// Parameters:
  /// - [product]: The product from which data is extracted.
  ///
  /// Returns a [ProductTemplate] containing the product's information.
  ProductTemplate getProductDataFromProduct(Product product) {
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

  /// Generates a list of serving size templates from a given product.
  ///
  /// This method takes a [Product] object, a list of [ServingSizeData] as base serving sizes,
  /// and translations for serving and container names. It returns a list of [ServingSizeTemplate]
  /// objects based on the product's serving and packaging quantities.
  ///
  /// Parameters:
  /// - [product]: The product from which to extract serving sizes.
  /// - [baseServingSizes]: A list of base serving sizes to be used.
  /// - [servingTranslation]: The translation for the serving size name.
  /// - [containerTranslation]: The translation for the container size name.
  ///
  /// Returns a list of [ServingSizeTemplate] objects.
  List<ServingSizeTemplate> getServingSizesFromProduct(
    Product product,
    List<ServingSizeData> baseServingSizes,
    String servingTranslation,
    String containerTranslation,
  ) {
    var servingSize = _getServingSize(product, baseServingSizes);
    var result = <ServingSizeTemplate>[];

    if ((product.servingQuantity ?? 0) > 0) {
      result.add(ServingSizeTemplate.fromValues(
        name: servingTranslation,
        amount: product.servingQuantity!,
        baseServingSize: servingSize.id,
      ));
    }

    if ((product.packagingQuantity ?? 0) > 0) {
      result.add(ServingSizeTemplate.fromValues(
        name: containerTranslation,
        amount: product.packagingQuantity!,
        baseServingSize: servingSize.id,
      ));
    }

    return result;
  }

  /// Retrieves the appropriate serving size data for a given product.
  ///
  /// This method determines if the product is a liquid based on its category tags.
  /// It then selects the serving size data that matches the unit ('ml' for liquids, 'g' for solids).
  ///
  /// Parameters:
  /// - [product]: The product for which to get the serving size.
  /// - [servingSizes]: A list of available serving size data.
  ///
  /// Returns the serving size data that matches the product's unit (either 'ml' or 'g').
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

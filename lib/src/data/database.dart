import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:drift/drift.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'all.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Product, ServingSize, Consumption])
class AppDatabase extends _$AppDatabase {
  AppDatabase({bool? forTesting}) : super(_openConnection(forTesting ?? false));

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection(bool forTesting) {
    if (forTesting) {
      return DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      );
    } else {
      return driftDatabase(name: 'calorie_counter_db');
    }
  }

  /// Creates default serving sizes in the database.
  ///
  /// This method inserts a list of default serving sizes into the database.
  /// The serving sizes include grams, milliliters, ounces, and fluid ounces.
  ///
  /// Parameters:
  /// - [localizations]: An instance of `AppLocalizations` used to get localized names for the serving sizes.
  ///
  /// Returns a [Future] that completes when the serving sizes have been inserted.
  Future<void> createDefaultServingSizes(AppLocalizations localizations) async {
    await servingSize.insertAll([
      ServingSizeCompanion.insert(
        id: const Value(1),
        name: localizations.serving_size_gram,
        short: const Value('g'),
        measuringUnit: MeasurementUnit.metric,
        isLiquid: const Value(false),
        valueInBaseServingSize: 1,
      ),
      ServingSizeCompanion.insert(
        id: const Value(2),
        name: localizations.serving_size_milliliter,
        short: const Value('ml'),
        measuringUnit: MeasurementUnit.metric,
        isLiquid: const Value(true),
        valueInBaseServingSize: 1,
      ),
      ServingSizeCompanion.insert(
        id: const Value(3),
        name: localizations.serving_size_ounces,
        short: const Value('oz'),
        measuringUnit: MeasurementUnit.imperial,
        isLiquid: const Value(false),
        valueInBaseServingSize: 28.3495,
        baseServingSizeId: const Value(1),
      ),
      ServingSizeCompanion.insert(
        id: const Value(4),
        name: localizations.serving_size_liquid_ounces,
        short: const Value('fl oz'),
        measuringUnit: MeasurementUnit.imperial,
        isLiquid: const Value(true),
        valueInBaseServingSize: 29.5735,
        baseServingSizeId: const Value(2),
      ),
    ], mode: InsertMode.insertOrIgnore);
  }

  /// Retrieves a list of serving sizes filtered by the specified measurement unit,
  /// optional filter, and optional search text.
  ///
  /// Parameters:
  /// - [measurementUnit]: Specifies the unit of measurement for the serving sizes to be retrieved.
  /// - [filter]: (Optional) Can be used to filter the serving sizes by their type (liquid or solid).
  /// - [searchText]: (Optional) Can be used to search for serving sizes by name.
  ///
  /// Returns a [Future] that completes with a list of [ServingSizeData] objects that match
  /// the specified criteria.
  Future<List<ServingSizeData>> filteredBaseServingSizes({
    required MeasurementUnit measurementUnit,
    ServingSizeFilter? filter,
    String? searchText,
  }) {
    var query = (select(servingSize)
      ..where((tbl) =>
          tbl.measuringUnit.equalsValue(measurementUnit) &
          tbl.forProduct.isNull()));

    if (searchText?.isNotEmpty ?? false) {
      query.where((tbl) => tbl.name.like("%$searchText%"));
    }

    switch (filter) {
      case ServingSizeFilter.liquid:
        query.where((tbl) => tbl.isLiquid);
        break;
      case ServingSizeFilter.solid:
        query.where((tbl) => tbl.isLiquid.not());
        break;
      default:
        // Do nothing...
        break;
    }

    return (query..orderBy([(tbl) => OrderingTerm.asc(tbl.name)])).get();
  }

  /// Retrieves custom serving sizes for a given product.
  ///
  /// Queries the `servingSize` table for serving sizes associated with the
  /// specified [productCode], ordered by name.
  ///
  /// Parameters:
  /// - [productCode]: The code of the product.
  ///
  /// Returns a [Future] with a list of [ServingSizeData] objects.
  Future<List<ServingSizeData>> customServingSizesForProduct(
    String productCode,
  ) {
    return (select(servingSize)
          ..where((tbl) => tbl.forProduct.equals(productCode))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
        .get();
  }

  /// Inserts a product and its serving sizes into the database.
  ///
  /// Parameters:
  /// - [productData]: The product data to insert.
  /// - [servingSizeData]: A list of serving size data to insert.
  ///
  /// Returns a [Future] that completes when the product and serving sizes
  /// have been inserted.
  Future<void> insertProductWithServingSizes(
    ProductCompanion productData,
    List<ServingSizeCompanion> servingSizeData,
  ) async {
    await into(product).insert(productData);
    await batch((batch) => batch.insertAll(servingSize, servingSizeData));
  }

  /// Retrieves a list of products filtered by the specified search text.
  ///
  /// Parameters:
  /// - [text]: The text to search for in the product name, brand, or code.
  ///  If `null`, all products are returned.
  /// - [onlyLiquids]: If `true`, only liquid products are returned.
  ///  If `false`, both liquid and solid products are returned.
  ///
  /// Returns a [Future] that completes with a list of [ProductData] objects that match
  Future<List<ProductData>> filteredProducts({
    String? text,
    bool? onlyLiquids,
  }) {
    var query = select(product);

    if (text != null) {
      query.where((tbl) =>
          tbl.name.like("%$text%") |
          tbl.brand.like("%$text%") |
          tbl.productCode.like("%$text%"));
    }

    if (onlyLiquids == true) {
      query.where((tbl) => tbl.isLiquid.equals(true));
    }

    return query.get();
  }

  /// Retrieves a product by its code.
  ///
  /// Parameters:
  /// - [productCode]: The code of the product to retrieve.
  ///
  /// Returns a [Future] that completes with a [ProductData] object.
  Future<ProductData?> getProduct(String productCode) {
    return (select(product)
          ..where((tbl) => tbl.productCode.equals(productCode)))
        .getSingleOrNull();
  }

  /// Retrieves a list of serving sizes for a given product.
  ///
  /// Parameters:
  /// - [productCode] - The code of the product for which to retrieve serving sizes.
  ///  If the [productCode] is `null`, an empty list is returned.
  ///
  /// Returns a [Future] that completes with a list of [ServingSizeData] objects.
  Future<List<ServingSizeData>> getServingSizesForProduct(String? productCode) {
    if (productCode == null) {
      return Future.value([]);
    }

    return (select(servingSize)
          ..where((tbl) => tbl.forProduct.equals(productCode)))
        .get();
  }

  /// Adds a new consumption record to the database.
  ///
  /// Parameters:
  /// - [consumptionData]: The consumption data to insert.
  ///
  /// Returns a [Future] that completes when the consumption record has been inserted.
  Future<void> insertConsumption(ConsumptionCompanion consumptionData) {
    return into(consumption).insert(consumptionData);
  }

  /// Updates an existing consumption record in the database.
  ///
  /// Parameters:
  /// - [consumptionId]: The ID of the consumption record to update.
  /// - [consumptionData]: The new consumption data to update.
  ///
  /// Returns a [Future] that completes when the consumption record has been updated.
  Future<void> updateConsumption(
    int consumptionId,
    ConsumptionCompanion consumptionData,
  ) {
    consumptionData = consumptionData.copyWith(id: Value(consumptionId));
    return (update(consumption)..where((tbl) => tbl.id.equals(consumptionId)))
        .write(consumptionData);
  }

  /// Deletes a consumption record from the database.
  /// Parameters:
  /// - [consumptionId]: The ID of the consumption record to delete.
  ///
  /// Returns a [Future] that completes when the consumption record has been deleted.
  Future<void> deleteConsumption(int consumptionId) {
    return (delete(consumption)..where((tbl) => tbl.id.equals(consumptionId)))
        .go();
  }

  /// Retrieves a list of consumption entries for the current day.
  ///
  /// This method fetches the consumption entries for today, optionally filtered by meal type.
  /// It joins the `consumption`, `product`, and `servingSize` tables to provide detailed
  /// information about each consumption entry.
  ///
  /// Parameters:
  /// - [mealType]: (Optional) The type of meal to filter the consumption entries by.
  ///
  /// Returns a [Stream] that emits a list of [ConsumptionEntry] objects representing
  /// the consumption entries for today.
  Stream<List<ConsumptionEntry>> getConsumptionEntriesForToday({
    MealType? mealType,
  }) {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(Duration(days: 1));

    var query = (select(consumption).join([
      innerJoin(
          product, product.productCode.equalsExp(consumption.productCode)),
      innerJoin(
          servingSize, servingSize.id.equalsExp(consumption.servingSizeId)),
    ])
      ..where(consumption.loggedOn.isBetweenValues(startOfDay, endOfDay)));

    if (mealType != null) {
      query.where(consumption.mealType.equalsValue(mealType));
    }

    return query
        .map((row) => ConsumptionEntry(
              consumption: row.readTable(consumption),
              product: row.readTable(product),
              servingSize: row.readTable(servingSize),
            ))
        .watch();
  }

  /// Calculates the total calories, carbs, fats, and proteins consumed for today.
  ///
  /// This method retrieves the consumption data for the current day and computes
  /// the total amount of calories, carbs, fats, and proteins consumed.
  ///
  /// Returns a [Stream] that emits a [Nutriments] object containing
  /// the total calories, carbs, fats, and proteins consumed for today.
  Stream<Nutriments> calculateTotalNutrimentsForToday({
    int? withoutConsumptionId,
  }) {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(Duration(days: 1));

    final caloriesInConsumption = managers.consumption.computedField((c) =>
        c.quantity *
        c.productCode.caloriesPer100Units /
        Constant(100.0) *
        c.servingSizeId.valueInBaseServingSize);

    final carbsInConsumption = managers.consumption.computedField((c) =>
        c.quantity *
        c.productCode.carbsPer100Units /
        Constant(100.0) *
        c.servingSizeId.valueInBaseServingSize);

    final fatsInConsumption = managers.consumption.computedField((c) =>
        c.quantity *
        c.productCode.fatPer100Units /
        Constant(100.0) *
        c.servingSizeId.valueInBaseServingSize);

    final proteinsInConsumption = managers.consumption.computedField((c) =>
        c.quantity *
        c.productCode.proteinsPer100Units /
        Constant(100.0) *
        c.servingSizeId.valueInBaseServingSize);

    final manager = managers.consumption.withFields([
      caloriesInConsumption,
      carbsInConsumption,
      fatsInConsumption,
      proteinsInConsumption,
    ]);

    var query =
        manager.filter((f) => f.loggedOn.isBetween(startOfDay, endOfDay));

    if (withoutConsumptionId != null) {
      query = query.filter((f) => f.id.equals(withoutConsumptionId).not());
    }

    return query.watch().map(
          (data) => data.fold<Nutriments>(
            Nutriments.empty,
            (a, b) => Nutriments(
              calories: a.calories +
                  (caloriesInConsumption.read(b.$2)?.toDouble() ?? 0),
              carbs: a.carbs + (carbsInConsumption.read(b.$2)?.toDouble() ?? 0),
              fats: a.fats + (fatsInConsumption.read(b.$2)?.toDouble() ?? 0),
              proteins: a.proteins +
                  (proteinsInConsumption.read(b.$2)?.toDouble() ?? 0),
            ),
          ),
        );
  }
}

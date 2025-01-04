import 'package:drift_flutter/drift_flutter.dart';
import 'package:drift/drift.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'all.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Product, ServingSize])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'calorie_counter_db');
  }

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

  Future<List<ServingSizeData>> customServingSizesForProduct(
      String productCode) {
    return (select(servingSize)
          ..where((tbl) => tbl.forProduct.equals(productCode))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
        .get();
  }

  Future<void> insertProductWithServingSizes(
    ProductCompanion productData,
    List<ServingSizeCompanion> servingSizeData,
  ) async {
    await into(product).insert(productData);
    await batch((batch) => batch.insertAll(servingSize, servingSizeData));
  }

  Future<List<ProductData>> filteredProducts({String? text}) {
    var query = select(product);

    if (text != null) {
      query.where((tbl) =>
          tbl.name.like("%$text%") |
          tbl.brand.like("%$text%") |
          tbl.productCode.like("%$text%"));
    }

    return query.get();
  }

  Future<ProductData> getProduct(String productCode) {
    return (select(product)
          ..where((tbl) => tbl.productCode.equals(productCode)))
        .getSingle();
  }

  Future<List<ServingSizeData>> getServingSizesForProduct(String? productCode) {
    if (productCode == null) {
      return Future.value([]);
    }

    return (select(servingSize)
          ..where((tbl) => tbl.forProduct.equals(productCode)))
        .get();
  }

  Future deleteProduct(String productCode) {
    return (delete(product)
          ..where((tbl) => tbl.productCode.equals(productCode)))
        .go();
  }
}

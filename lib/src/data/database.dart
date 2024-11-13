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
        name: localizations.serving_size_gram,
        short: 'g',
        measuringUnit: MeasurementUnit.metric,
        valueInBaseUnit: 1,
        isLiquid: const Value(false),
      ),
      ServingSizeCompanion.insert(
        name: localizations.serving_size_milliliter,
        short: 'ml',
        measuringUnit: MeasurementUnit.metric,
        valueInBaseUnit: 1,
        isLiquid: const Value(true),
      ),
      ServingSizeCompanion.insert(
        name: localizations.serving_size_ounces,
        short: 'oz',
        measuringUnit: MeasurementUnit.imperial,
        valueInBaseUnit: 28.3495,
        isLiquid: const Value(false),
      ),
      ServingSizeCompanion.insert(
        name: localizations.serving_size_liquid_ounces,
        short: 'fl oz',
        measuringUnit: MeasurementUnit.imperial,
        valueInBaseUnit: 29.5735,
        isLiquid: const Value(true),
      ),
    ], mode: InsertMode.insertOrIgnore);
  }

  Future<List<ServingSizeData>> filteredServingSizes({
    required MeasurementUnit measurementUnit,
    ServingSizeFilter? filter,
    String? searchText,
  }) {
    var query = (select(servingSize)
      ..where((tbl) => tbl.measuringUnit.equalsValue(measurementUnit)));

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

  Stream<ProductWithServingSize> productWithServingSize(String productCode) {
    final query = select(product).join([
      innerJoin(servingSize, servingSize.id.equalsExp(product.servingSize)),
    ])
      ..where(product.productCode.equals(productCode))
      ..limit(1);

    return query
        .watchSingle()
        .map((row) => ProductWithServingSize(product, servingSize));
  }
}

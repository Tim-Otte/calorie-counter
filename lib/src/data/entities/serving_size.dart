// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import '../all.dart' show MeasurementUnit;
import 'all.dart' show Product;

class ServingSize extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get isLiquid => boolean().withDefault(const Constant(false))();
  IntColumn get measuringUnit => intEnum<MeasurementUnit>()();
  RealColumn get valueInBaseServingSize =>
      real().check(valueInBaseServingSize.isBiggerThanValue(0))();
  IntColumn get baseServingSizeId =>
      integer().references(ServingSize, #id).nullable()();
  TextColumn get forProduct =>
      text().references(Product, #productCode).nullable()();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {name, forProduct}
      ];
}

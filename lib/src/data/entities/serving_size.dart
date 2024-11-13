import 'package:drift/drift.dart';

import '../all.dart' show MeasurementUnit;

class ServingSize extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get short => text().unique()();
  IntColumn get measuringUnit => intEnum<MeasurementUnit>()();
  RealColumn get valueInBaseUnit => real()();
  BoolColumn get isLiquid => boolean().withDefault(const Constant(false))();
}

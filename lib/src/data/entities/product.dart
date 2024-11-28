import 'package:drift/drift.dart';

class Product extends Table {
  TextColumn get productCode => text()();
  TextColumn get name => text()();
  TextColumn get brand => text()();
  RealColumn get caloriesPer100Units => real()();
  RealColumn get carbsPer100Units => real()();
  RealColumn get fatPer100Units => real()();
  RealColumn get proteinsPer100Units => real()();

  @override
  Set<Column> get primaryKey => {productCode};
}

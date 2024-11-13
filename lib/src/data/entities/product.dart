import 'package:drift/drift.dart';

import 'all.dart' show ServingSize;

class Product extends Table {
  TextColumn get productCode => text()();
  TextColumn get name => text()();
  TextColumn get brand => text()();
  IntColumn get servingSize => integer().references(ServingSize, #id)();
  RealColumn get caloriesPer100Units => real()();
  RealColumn get carbsPer100Units => real()();
  RealColumn get fatPer100Units => real()();
  RealColumn get proteinsPer100Units => real()();

  @override
  Set<Column> get primaryKey => {productCode};
}

class ProductWithServingSize {
  ProductWithServingSize(this.product, this.servingSize);

  final Product product;
  final ServingSize servingSize;
}

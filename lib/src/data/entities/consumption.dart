import 'package:drift/drift.dart';

import '../enums/all.dart' show MealType;
import 'all.dart' show Product, ServingSize;

class Consumption extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get loggedOn => dateTime()();
  TextColumn get productCode => text().references(Product, #productCode)();
  IntColumn get servingSizeId => integer().references(ServingSize, #id)();
  RealColumn get quantity => real()();
  IntColumn get mealType => intEnum<MealType>()();
}

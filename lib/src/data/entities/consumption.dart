// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import '../enums/all.dart' show MealType;
import 'all.dart' show Product, ServingSize;

class Consumption extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get loggedOn => dateTime()();
  TextColumn get product => text().references(Product, #productCode)();
  IntColumn get servingSize => integer().references(ServingSize, #id)();
  RealColumn get quantity => real().check(quantity.isBiggerThanValue(0))();
  IntColumn get mealType => intEnum<MealType>()();
}

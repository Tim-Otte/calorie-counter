// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import 'all.dart' show Product, Recipe, ServingSize;

class RecipeIngredient extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recipe => text().references(Recipe, #name)();
  TextColumn get product => text().references(Product, #productCode)();
  IntColumn get servingSize => integer().references(ServingSize, #id)();
  RealColumn get quantity => real().check(quantity.isBiggerThanValue(0))();
}

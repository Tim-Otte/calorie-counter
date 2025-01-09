// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

class Recipe extends Table {
  TextColumn get name => text().unique()();
  IntColumn get totalServingQty =>
      integer().check(totalServingQty.isBiggerThanValue(0))();
}

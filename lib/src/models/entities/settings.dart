import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;

import '../enums/enums.dart';

class Settings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get themeMode => intEnum<ThemeMode>()();
  IntColumn get measurementUnit => intEnum<MeasurementUnit>()();
  IntColumn get gender => intEnum<Gender>()();
  DateTimeColumn get dateOfBirth => dateTime()();
  RealColumn get height => real()();
  RealColumn get weight => real()();
}

import 'package:calorie_counter/src/extensions/enumerable.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:drift/drift.dart';

import 'entities/entities.dart';
import 'enums/enums.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'calorie_counter_db');
  }

  Future initAppSetting() async {
    var countExpr = settings.id.count();
    final query = selectOnly(settings)..addColumns([countExpr]);
    int? result = await query.map((row) => row.read(countExpr)).getSingle();

    if (result != 1) {
      await into(settings).insert(SettingsCompanion.insert(
        themeMode: ThemeMode.system,
        measurementUnit: MeasurementUnit.metric,
        gender: Gender.values.pickRandom(),
        dateOfBirth: DateTime.now(),
        height: 100,
        weight: 50,
      ));
    }
  }

  Future<Setting> get appSettings => select(settings).watchSingle().first;

  Future updateAppSetting({
    ThemeMode? themeMode,
    MeasurementUnit? measurementUnit,
    Gender? gender,
    DateTime? dateOfBirth,
    double? height,
    double? weight,
  }) {
    return update(settings).write(
      SettingsCompanion(
        themeMode: Value.absentIfNull(themeMode),
        measurementUnit: Value.absentIfNull(measurementUnit),
        gender: Value.absentIfNull(gender),
        dateOfBirth: Value.absentIfNull(dateOfBirth),
        height: Value.absentIfNull(height),
        weight: Value.absentIfNull(weight),
      ),
    );
  }
}

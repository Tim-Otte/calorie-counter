// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumnWithTypeConverter<ThemeMode, int> themeMode =
      GeneratedColumn<int>('theme_mode', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ThemeMode>($SettingsTable.$converterthemeMode);
  static const VerificationMeta _measurementUnitMeta =
      const VerificationMeta('measurementUnit');
  @override
  late final GeneratedColumnWithTypeConverter<MeasurementUnit, int>
      measurementUnit = GeneratedColumn<int>(
              'measurement_unit', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MeasurementUnit>(
              $SettingsTable.$convertermeasurementUnit);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumnWithTypeConverter<Gender, int> gender =
      GeneratedColumn<int>('gender', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Gender>($SettingsTable.$convertergender);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, themeMode, measurementUnit, gender, dateOfBirth, height, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_themeModeMeta, const VerificationResult.success());
    context.handle(_measurementUnitMeta, const VerificationResult.success());
    context.handle(_genderMeta, const VerificationResult.success());
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      themeMode: $SettingsTable.$converterthemeMode.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}theme_mode'])!),
      measurementUnit: $SettingsTable.$convertermeasurementUnit.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}measurement_unit'])!),
      gender: $SettingsTable.$convertergender.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gender'])!),
      dateOfBirth: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ThemeMode, int, int> $converterthemeMode =
      const EnumIndexConverter<ThemeMode>(ThemeMode.values);
  static JsonTypeConverter2<MeasurementUnit, int, int>
      $convertermeasurementUnit =
      const EnumIndexConverter<MeasurementUnit>(MeasurementUnit.values);
  static JsonTypeConverter2<Gender, int, int> $convertergender =
      const EnumIndexConverter<Gender>(Gender.values);
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final ThemeMode themeMode;
  final MeasurementUnit measurementUnit;
  final Gender gender;
  final DateTime dateOfBirth;
  final double height;
  final double weight;
  const Setting(
      {required this.id,
      required this.themeMode,
      required this.measurementUnit,
      required this.gender,
      required this.dateOfBirth,
      required this.height,
      required this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['theme_mode'] =
          Variable<int>($SettingsTable.$converterthemeMode.toSql(themeMode));
    }
    {
      map['measurement_unit'] = Variable<int>(
          $SettingsTable.$convertermeasurementUnit.toSql(measurementUnit));
    }
    {
      map['gender'] =
          Variable<int>($SettingsTable.$convertergender.toSql(gender));
    }
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    map['height'] = Variable<double>(height);
    map['weight'] = Variable<double>(weight);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      measurementUnit: Value(measurementUnit),
      gender: Value(gender),
      dateOfBirth: Value(dateOfBirth),
      height: Value(height),
      weight: Value(weight),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      themeMode: $SettingsTable.$converterthemeMode
          .fromJson(serializer.fromJson<int>(json['themeMode'])),
      measurementUnit: $SettingsTable.$convertermeasurementUnit
          .fromJson(serializer.fromJson<int>(json['measurementUnit'])),
      gender: $SettingsTable.$convertergender
          .fromJson(serializer.fromJson<int>(json['gender'])),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      height: serializer.fromJson<double>(json['height']),
      weight: serializer.fromJson<double>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer
          .toJson<int>($SettingsTable.$converterthemeMode.toJson(themeMode)),
      'measurementUnit': serializer.toJson<int>(
          $SettingsTable.$convertermeasurementUnit.toJson(measurementUnit)),
      'gender': serializer
          .toJson<int>($SettingsTable.$convertergender.toJson(gender)),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'height': serializer.toJson<double>(height),
      'weight': serializer.toJson<double>(weight),
    };
  }

  Setting copyWith(
          {int? id,
          ThemeMode? themeMode,
          MeasurementUnit? measurementUnit,
          Gender? gender,
          DateTime? dateOfBirth,
          double? height,
          double? weight}) =>
      Setting(
        id: id ?? this.id,
        themeMode: themeMode ?? this.themeMode,
        measurementUnit: measurementUnit ?? this.measurementUnit,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        height: height ?? this.height,
        weight: weight ?? this.weight,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      measurementUnit: data.measurementUnit.present
          ? data.measurementUnit.value
          : this.measurementUnit,
      gender: data.gender.present ? data.gender.value : this.gender,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('measurementUnit: $measurementUnit, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('height: $height, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, themeMode, measurementUnit, gender, dateOfBirth, height, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.measurementUnit == this.measurementUnit &&
          other.gender == this.gender &&
          other.dateOfBirth == this.dateOfBirth &&
          other.height == this.height &&
          other.weight == this.weight);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<ThemeMode> themeMode;
  final Value<MeasurementUnit> measurementUnit;
  final Value<Gender> gender;
  final Value<DateTime> dateOfBirth;
  final Value<double> height;
  final Value<double> weight;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.measurementUnit = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    required ThemeMode themeMode,
    required MeasurementUnit measurementUnit,
    required Gender gender,
    required DateTime dateOfBirth,
    required double height,
    required double weight,
  })  : themeMode = Value(themeMode),
        measurementUnit = Value(measurementUnit),
        gender = Value(gender),
        dateOfBirth = Value(dateOfBirth),
        height = Value(height),
        weight = Value(weight);
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<int>? themeMode,
    Expression<int>? measurementUnit,
    Expression<int>? gender,
    Expression<DateTime>? dateOfBirth,
    Expression<double>? height,
    Expression<double>? weight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (measurementUnit != null) 'measurement_unit': measurementUnit,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
    });
  }

  SettingsCompanion copyWith(
      {Value<int>? id,
      Value<ThemeMode>? themeMode,
      Value<MeasurementUnit>? measurementUnit,
      Value<Gender>? gender,
      Value<DateTime>? dateOfBirth,
      Value<double>? height,
      Value<double>? weight}) {
    return SettingsCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      measurementUnit: measurementUnit ?? this.measurementUnit,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<int>(
          $SettingsTable.$converterthemeMode.toSql(themeMode.value));
    }
    if (measurementUnit.present) {
      map['measurement_unit'] = Variable<int>($SettingsTable
          .$convertermeasurementUnit
          .toSql(measurementUnit.value));
    }
    if (gender.present) {
      map['gender'] =
          Variable<int>($SettingsTable.$convertergender.toSql(gender.value));
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('measurementUnit: $measurementUnit, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('height: $height, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [settings];
}

typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  required ThemeMode themeMode,
  required MeasurementUnit measurementUnit,
  required Gender gender,
  required DateTime dateOfBirth,
  required double height,
  required double weight,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  Value<ThemeMode> themeMode,
  Value<MeasurementUnit> measurementUnit,
  Value<Gender> gender,
  Value<DateTime> dateOfBirth,
  Value<double> height,
  Value<double> weight,
});

class $$SettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<ThemeMode, ThemeMode, int> get themeMode =>
      $state.composableBuilder(
          column: $state.table.themeMode,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<MeasurementUnit, MeasurementUnit, int>
      get measurementUnit => $state.composableBuilder(
          column: $state.table.measurementUnit,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Gender, Gender, int> get gender =>
      $state.composableBuilder(
          column: $state.table.gender,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dateOfBirth => $state.composableBuilder(
      column: $state.table.dateOfBirth,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get height => $state.composableBuilder(
      column: $state.table.height,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get weight => $state.composableBuilder(
      column: $state.table.weight,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get themeMode => $state.composableBuilder(
      column: $state.table.themeMode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get measurementUnit => $state.composableBuilder(
      column: $state.table.measurementUnit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get gender => $state.composableBuilder(
      column: $state.table.gender,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dateOfBirth => $state.composableBuilder(
      column: $state.table.dateOfBirth,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get height => $state.composableBuilder(
      column: $state.table.height,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get weight => $state.composableBuilder(
      column: $state.table.weight,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SettingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<ThemeMode> themeMode = const Value.absent(),
            Value<MeasurementUnit> measurementUnit = const Value.absent(),
            Value<Gender> gender = const Value.absent(),
            Value<DateTime> dateOfBirth = const Value.absent(),
            Value<double> height = const Value.absent(),
            Value<double> weight = const Value.absent(),
          }) =>
              SettingsCompanion(
            id: id,
            themeMode: themeMode,
            measurementUnit: measurementUnit,
            gender: gender,
            dateOfBirth: dateOfBirth,
            height: height,
            weight: weight,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required ThemeMode themeMode,
            required MeasurementUnit measurementUnit,
            required Gender gender,
            required DateTime dateOfBirth,
            required double height,
            required double weight,
          }) =>
              SettingsCompanion.insert(
            id: id,
            themeMode: themeMode,
            measurementUnit: measurementUnit,
            gender: gender,
            dateOfBirth: dateOfBirth,
            height: height,
            weight: weight,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}

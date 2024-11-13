// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ServingSizeTable extends ServingSize
    with TableInfo<$ServingSizeTable, ServingSizeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServingSizeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _shortMeta = const VerificationMeta('short');
  @override
  late final GeneratedColumn<String> short = GeneratedColumn<String>(
      'short', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _measuringUnitMeta =
      const VerificationMeta('measuringUnit');
  @override
  late final GeneratedColumnWithTypeConverter<MeasurementUnit, int>
      measuringUnit = GeneratedColumn<int>('measuring_unit', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MeasurementUnit>(
              $ServingSizeTable.$convertermeasuringUnit);
  static const VerificationMeta _valueInBaseUnitMeta =
      const VerificationMeta('valueInBaseUnit');
  @override
  late final GeneratedColumn<double> valueInBaseUnit = GeneratedColumn<double>(
      'value_in_base_unit', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isLiquidMeta =
      const VerificationMeta('isLiquid');
  @override
  late final GeneratedColumn<bool> isLiquid = GeneratedColumn<bool>(
      'is_liquid', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_liquid" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, short, measuringUnit, valueInBaseUnit, isLiquid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'serving_size';
  @override
  VerificationContext validateIntegrity(Insertable<ServingSizeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('short')) {
      context.handle(
          _shortMeta, short.isAcceptableOrUnknown(data['short']!, _shortMeta));
    } else if (isInserting) {
      context.missing(_shortMeta);
    }
    context.handle(_measuringUnitMeta, const VerificationResult.success());
    if (data.containsKey('value_in_base_unit')) {
      context.handle(
          _valueInBaseUnitMeta,
          valueInBaseUnit.isAcceptableOrUnknown(
              data['value_in_base_unit']!, _valueInBaseUnitMeta));
    } else if (isInserting) {
      context.missing(_valueInBaseUnitMeta);
    }
    if (data.containsKey('is_liquid')) {
      context.handle(_isLiquidMeta,
          isLiquid.isAcceptableOrUnknown(data['is_liquid']!, _isLiquidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServingSizeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServingSizeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      short: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}short'])!,
      measuringUnit: $ServingSizeTable.$convertermeasuringUnit.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}measuring_unit'])!),
      valueInBaseUnit: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}value_in_base_unit'])!,
      isLiquid: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_liquid'])!,
    );
  }

  @override
  $ServingSizeTable createAlias(String alias) {
    return $ServingSizeTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MeasurementUnit, int, int> $convertermeasuringUnit =
      const EnumIndexConverter<MeasurementUnit>(MeasurementUnit.values);
}

class ServingSizeData extends DataClass implements Insertable<ServingSizeData> {
  final int id;
  final String name;
  final String short;
  final MeasurementUnit measuringUnit;
  final double valueInBaseUnit;
  final bool isLiquid;
  const ServingSizeData(
      {required this.id,
      required this.name,
      required this.short,
      required this.measuringUnit,
      required this.valueInBaseUnit,
      required this.isLiquid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['short'] = Variable<String>(short);
    {
      map['measuring_unit'] = Variable<int>(
          $ServingSizeTable.$convertermeasuringUnit.toSql(measuringUnit));
    }
    map['value_in_base_unit'] = Variable<double>(valueInBaseUnit);
    map['is_liquid'] = Variable<bool>(isLiquid);
    return map;
  }

  ServingSizeCompanion toCompanion(bool nullToAbsent) {
    return ServingSizeCompanion(
      id: Value(id),
      name: Value(name),
      short: Value(short),
      measuringUnit: Value(measuringUnit),
      valueInBaseUnit: Value(valueInBaseUnit),
      isLiquid: Value(isLiquid),
    );
  }

  factory ServingSizeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServingSizeData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      short: serializer.fromJson<String>(json['short']),
      measuringUnit: $ServingSizeTable.$convertermeasuringUnit
          .fromJson(serializer.fromJson<int>(json['measuringUnit'])),
      valueInBaseUnit: serializer.fromJson<double>(json['valueInBaseUnit']),
      isLiquid: serializer.fromJson<bool>(json['isLiquid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'short': serializer.toJson<String>(short),
      'measuringUnit': serializer.toJson<int>(
          $ServingSizeTable.$convertermeasuringUnit.toJson(measuringUnit)),
      'valueInBaseUnit': serializer.toJson<double>(valueInBaseUnit),
      'isLiquid': serializer.toJson<bool>(isLiquid),
    };
  }

  ServingSizeData copyWith(
          {int? id,
          String? name,
          String? short,
          MeasurementUnit? measuringUnit,
          double? valueInBaseUnit,
          bool? isLiquid}) =>
      ServingSizeData(
        id: id ?? this.id,
        name: name ?? this.name,
        short: short ?? this.short,
        measuringUnit: measuringUnit ?? this.measuringUnit,
        valueInBaseUnit: valueInBaseUnit ?? this.valueInBaseUnit,
        isLiquid: isLiquid ?? this.isLiquid,
      );
  ServingSizeData copyWithCompanion(ServingSizeCompanion data) {
    return ServingSizeData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      short: data.short.present ? data.short.value : this.short,
      measuringUnit: data.measuringUnit.present
          ? data.measuringUnit.value
          : this.measuringUnit,
      valueInBaseUnit: data.valueInBaseUnit.present
          ? data.valueInBaseUnit.value
          : this.valueInBaseUnit,
      isLiquid: data.isLiquid.present ? data.isLiquid.value : this.isLiquid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServingSizeData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('short: $short, ')
          ..write('measuringUnit: $measuringUnit, ')
          ..write('valueInBaseUnit: $valueInBaseUnit, ')
          ..write('isLiquid: $isLiquid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, short, measuringUnit, valueInBaseUnit, isLiquid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServingSizeData &&
          other.id == this.id &&
          other.name == this.name &&
          other.short == this.short &&
          other.measuringUnit == this.measuringUnit &&
          other.valueInBaseUnit == this.valueInBaseUnit &&
          other.isLiquid == this.isLiquid);
}

class ServingSizeCompanion extends UpdateCompanion<ServingSizeData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> short;
  final Value<MeasurementUnit> measuringUnit;
  final Value<double> valueInBaseUnit;
  final Value<bool> isLiquid;
  const ServingSizeCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.short = const Value.absent(),
    this.measuringUnit = const Value.absent(),
    this.valueInBaseUnit = const Value.absent(),
    this.isLiquid = const Value.absent(),
  });
  ServingSizeCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String short,
    required MeasurementUnit measuringUnit,
    required double valueInBaseUnit,
    this.isLiquid = const Value.absent(),
  })  : name = Value(name),
        short = Value(short),
        measuringUnit = Value(measuringUnit),
        valueInBaseUnit = Value(valueInBaseUnit);
  static Insertable<ServingSizeData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? short,
    Expression<int>? measuringUnit,
    Expression<double>? valueInBaseUnit,
    Expression<bool>? isLiquid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (short != null) 'short': short,
      if (measuringUnit != null) 'measuring_unit': measuringUnit,
      if (valueInBaseUnit != null) 'value_in_base_unit': valueInBaseUnit,
      if (isLiquid != null) 'is_liquid': isLiquid,
    });
  }

  ServingSizeCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? short,
      Value<MeasurementUnit>? measuringUnit,
      Value<double>? valueInBaseUnit,
      Value<bool>? isLiquid}) {
    return ServingSizeCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      short: short ?? this.short,
      measuringUnit: measuringUnit ?? this.measuringUnit,
      valueInBaseUnit: valueInBaseUnit ?? this.valueInBaseUnit,
      isLiquid: isLiquid ?? this.isLiquid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (short.present) {
      map['short'] = Variable<String>(short.value);
    }
    if (measuringUnit.present) {
      map['measuring_unit'] = Variable<int>(
          $ServingSizeTable.$convertermeasuringUnit.toSql(measuringUnit.value));
    }
    if (valueInBaseUnit.present) {
      map['value_in_base_unit'] = Variable<double>(valueInBaseUnit.value);
    }
    if (isLiquid.present) {
      map['is_liquid'] = Variable<bool>(isLiquid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServingSizeCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('short: $short, ')
          ..write('measuringUnit: $measuringUnit, ')
          ..write('valueInBaseUnit: $valueInBaseUnit, ')
          ..write('isLiquid: $isLiquid')
          ..write(')'))
        .toString();
  }
}

class $ProductTable extends Product with TableInfo<$ProductTable, ProductData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productCodeMeta =
      const VerificationMeta('productCode');
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
      'product_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _servingSizeMeta =
      const VerificationMeta('servingSize');
  @override
  late final GeneratedColumn<int> servingSize = GeneratedColumn<int>(
      'serving_size', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES serving_size (id)'));
  static const VerificationMeta _caloriesPer100UnitsMeta =
      const VerificationMeta('caloriesPer100Units');
  @override
  late final GeneratedColumn<double> caloriesPer100Units =
      GeneratedColumn<double>('calories_per100_units', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _carbsPer100UnitsMeta =
      const VerificationMeta('carbsPer100Units');
  @override
  late final GeneratedColumn<double> carbsPer100Units = GeneratedColumn<double>(
      'carbs_per100_units', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fatPer100UnitsMeta =
      const VerificationMeta('fatPer100Units');
  @override
  late final GeneratedColumn<double> fatPer100Units = GeneratedColumn<double>(
      'fat_per100_units', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _proteinsPer100UnitsMeta =
      const VerificationMeta('proteinsPer100Units');
  @override
  late final GeneratedColumn<double> proteinsPer100Units =
      GeneratedColumn<double>('proteins_per100_units', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        productCode,
        name,
        brand,
        servingSize,
        caloriesPer100Units,
        carbsPer100Units,
        fatPer100Units,
        proteinsPer100Units
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product';
  @override
  VerificationContext validateIntegrity(Insertable<ProductData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_code')) {
      context.handle(
          _productCodeMeta,
          productCode.isAcceptableOrUnknown(
              data['product_code']!, _productCodeMeta));
    } else if (isInserting) {
      context.missing(_productCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('serving_size')) {
      context.handle(
          _servingSizeMeta,
          servingSize.isAcceptableOrUnknown(
              data['serving_size']!, _servingSizeMeta));
    } else if (isInserting) {
      context.missing(_servingSizeMeta);
    }
    if (data.containsKey('calories_per100_units')) {
      context.handle(
          _caloriesPer100UnitsMeta,
          caloriesPer100Units.isAcceptableOrUnknown(
              data['calories_per100_units']!, _caloriesPer100UnitsMeta));
    } else if (isInserting) {
      context.missing(_caloriesPer100UnitsMeta);
    }
    if (data.containsKey('carbs_per100_units')) {
      context.handle(
          _carbsPer100UnitsMeta,
          carbsPer100Units.isAcceptableOrUnknown(
              data['carbs_per100_units']!, _carbsPer100UnitsMeta));
    } else if (isInserting) {
      context.missing(_carbsPer100UnitsMeta);
    }
    if (data.containsKey('fat_per100_units')) {
      context.handle(
          _fatPer100UnitsMeta,
          fatPer100Units.isAcceptableOrUnknown(
              data['fat_per100_units']!, _fatPer100UnitsMeta));
    } else if (isInserting) {
      context.missing(_fatPer100UnitsMeta);
    }
    if (data.containsKey('proteins_per100_units')) {
      context.handle(
          _proteinsPer100UnitsMeta,
          proteinsPer100Units.isAcceptableOrUnknown(
              data['proteins_per100_units']!, _proteinsPer100UnitsMeta));
    } else if (isInserting) {
      context.missing(_proteinsPer100UnitsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productCode};
  @override
  ProductData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductData(
      productCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand'])!,
      servingSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}serving_size'])!,
      caloriesPer100Units: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}calories_per100_units'])!,
      carbsPer100Units: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}carbs_per100_units'])!,
      fatPer100Units: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}fat_per100_units'])!,
      proteinsPer100Units: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}proteins_per100_units'])!,
    );
  }

  @override
  $ProductTable createAlias(String alias) {
    return $ProductTable(attachedDatabase, alias);
  }
}

class ProductData extends DataClass implements Insertable<ProductData> {
  final String productCode;
  final String name;
  final String brand;
  final int servingSize;
  final double caloriesPer100Units;
  final double carbsPer100Units;
  final double fatPer100Units;
  final double proteinsPer100Units;
  const ProductData(
      {required this.productCode,
      required this.name,
      required this.brand,
      required this.servingSize,
      required this.caloriesPer100Units,
      required this.carbsPer100Units,
      required this.fatPer100Units,
      required this.proteinsPer100Units});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_code'] = Variable<String>(productCode);
    map['name'] = Variable<String>(name);
    map['brand'] = Variable<String>(brand);
    map['serving_size'] = Variable<int>(servingSize);
    map['calories_per100_units'] = Variable<double>(caloriesPer100Units);
    map['carbs_per100_units'] = Variable<double>(carbsPer100Units);
    map['fat_per100_units'] = Variable<double>(fatPer100Units);
    map['proteins_per100_units'] = Variable<double>(proteinsPer100Units);
    return map;
  }

  ProductCompanion toCompanion(bool nullToAbsent) {
    return ProductCompanion(
      productCode: Value(productCode),
      name: Value(name),
      brand: Value(brand),
      servingSize: Value(servingSize),
      caloriesPer100Units: Value(caloriesPer100Units),
      carbsPer100Units: Value(carbsPer100Units),
      fatPer100Units: Value(fatPer100Units),
      proteinsPer100Units: Value(proteinsPer100Units),
    );
  }

  factory ProductData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductData(
      productCode: serializer.fromJson<String>(json['productCode']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String>(json['brand']),
      servingSize: serializer.fromJson<int>(json['servingSize']),
      caloriesPer100Units:
          serializer.fromJson<double>(json['caloriesPer100Units']),
      carbsPer100Units: serializer.fromJson<double>(json['carbsPer100Units']),
      fatPer100Units: serializer.fromJson<double>(json['fatPer100Units']),
      proteinsPer100Units:
          serializer.fromJson<double>(json['proteinsPer100Units']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productCode': serializer.toJson<String>(productCode),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String>(brand),
      'servingSize': serializer.toJson<int>(servingSize),
      'caloriesPer100Units': serializer.toJson<double>(caloriesPer100Units),
      'carbsPer100Units': serializer.toJson<double>(carbsPer100Units),
      'fatPer100Units': serializer.toJson<double>(fatPer100Units),
      'proteinsPer100Units': serializer.toJson<double>(proteinsPer100Units),
    };
  }

  ProductData copyWith(
          {String? productCode,
          String? name,
          String? brand,
          int? servingSize,
          double? caloriesPer100Units,
          double? carbsPer100Units,
          double? fatPer100Units,
          double? proteinsPer100Units}) =>
      ProductData(
        productCode: productCode ?? this.productCode,
        name: name ?? this.name,
        brand: brand ?? this.brand,
        servingSize: servingSize ?? this.servingSize,
        caloriesPer100Units: caloriesPer100Units ?? this.caloriesPer100Units,
        carbsPer100Units: carbsPer100Units ?? this.carbsPer100Units,
        fatPer100Units: fatPer100Units ?? this.fatPer100Units,
        proteinsPer100Units: proteinsPer100Units ?? this.proteinsPer100Units,
      );
  ProductData copyWithCompanion(ProductCompanion data) {
    return ProductData(
      productCode:
          data.productCode.present ? data.productCode.value : this.productCode,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      servingSize:
          data.servingSize.present ? data.servingSize.value : this.servingSize,
      caloriesPer100Units: data.caloriesPer100Units.present
          ? data.caloriesPer100Units.value
          : this.caloriesPer100Units,
      carbsPer100Units: data.carbsPer100Units.present
          ? data.carbsPer100Units.value
          : this.carbsPer100Units,
      fatPer100Units: data.fatPer100Units.present
          ? data.fatPer100Units.value
          : this.fatPer100Units,
      proteinsPer100Units: data.proteinsPer100Units.present
          ? data.proteinsPer100Units.value
          : this.proteinsPer100Units,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductData(')
          ..write('productCode: $productCode, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('servingSize: $servingSize, ')
          ..write('caloriesPer100Units: $caloriesPer100Units, ')
          ..write('carbsPer100Units: $carbsPer100Units, ')
          ..write('fatPer100Units: $fatPer100Units, ')
          ..write('proteinsPer100Units: $proteinsPer100Units')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      productCode,
      name,
      brand,
      servingSize,
      caloriesPer100Units,
      carbsPer100Units,
      fatPer100Units,
      proteinsPer100Units);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductData &&
          other.productCode == this.productCode &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.servingSize == this.servingSize &&
          other.caloriesPer100Units == this.caloriesPer100Units &&
          other.carbsPer100Units == this.carbsPer100Units &&
          other.fatPer100Units == this.fatPer100Units &&
          other.proteinsPer100Units == this.proteinsPer100Units);
}

class ProductCompanion extends UpdateCompanion<ProductData> {
  final Value<String> productCode;
  final Value<String> name;
  final Value<String> brand;
  final Value<int> servingSize;
  final Value<double> caloriesPer100Units;
  final Value<double> carbsPer100Units;
  final Value<double> fatPer100Units;
  final Value<double> proteinsPer100Units;
  final Value<int> rowid;
  const ProductCompanion({
    this.productCode = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.servingSize = const Value.absent(),
    this.caloriesPer100Units = const Value.absent(),
    this.carbsPer100Units = const Value.absent(),
    this.fatPer100Units = const Value.absent(),
    this.proteinsPer100Units = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductCompanion.insert({
    required String productCode,
    required String name,
    required String brand,
    required int servingSize,
    required double caloriesPer100Units,
    required double carbsPer100Units,
    required double fatPer100Units,
    required double proteinsPer100Units,
    this.rowid = const Value.absent(),
  })  : productCode = Value(productCode),
        name = Value(name),
        brand = Value(brand),
        servingSize = Value(servingSize),
        caloriesPer100Units = Value(caloriesPer100Units),
        carbsPer100Units = Value(carbsPer100Units),
        fatPer100Units = Value(fatPer100Units),
        proteinsPer100Units = Value(proteinsPer100Units);
  static Insertable<ProductData> custom({
    Expression<String>? productCode,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<int>? servingSize,
    Expression<double>? caloriesPer100Units,
    Expression<double>? carbsPer100Units,
    Expression<double>? fatPer100Units,
    Expression<double>? proteinsPer100Units,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productCode != null) 'product_code': productCode,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (servingSize != null) 'serving_size': servingSize,
      if (caloriesPer100Units != null)
        'calories_per100_units': caloriesPer100Units,
      if (carbsPer100Units != null) 'carbs_per100_units': carbsPer100Units,
      if (fatPer100Units != null) 'fat_per100_units': fatPer100Units,
      if (proteinsPer100Units != null)
        'proteins_per100_units': proteinsPer100Units,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductCompanion copyWith(
      {Value<String>? productCode,
      Value<String>? name,
      Value<String>? brand,
      Value<int>? servingSize,
      Value<double>? caloriesPer100Units,
      Value<double>? carbsPer100Units,
      Value<double>? fatPer100Units,
      Value<double>? proteinsPer100Units,
      Value<int>? rowid}) {
    return ProductCompanion(
      productCode: productCode ?? this.productCode,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      servingSize: servingSize ?? this.servingSize,
      caloriesPer100Units: caloriesPer100Units ?? this.caloriesPer100Units,
      carbsPer100Units: carbsPer100Units ?? this.carbsPer100Units,
      fatPer100Units: fatPer100Units ?? this.fatPer100Units,
      proteinsPer100Units: proteinsPer100Units ?? this.proteinsPer100Units,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productCode.present) {
      map['product_code'] = Variable<String>(productCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (servingSize.present) {
      map['serving_size'] = Variable<int>(servingSize.value);
    }
    if (caloriesPer100Units.present) {
      map['calories_per100_units'] =
          Variable<double>(caloriesPer100Units.value);
    }
    if (carbsPer100Units.present) {
      map['carbs_per100_units'] = Variable<double>(carbsPer100Units.value);
    }
    if (fatPer100Units.present) {
      map['fat_per100_units'] = Variable<double>(fatPer100Units.value);
    }
    if (proteinsPer100Units.present) {
      map['proteins_per100_units'] =
          Variable<double>(proteinsPer100Units.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCompanion(')
          ..write('productCode: $productCode, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('servingSize: $servingSize, ')
          ..write('caloriesPer100Units: $caloriesPer100Units, ')
          ..write('carbsPer100Units: $carbsPer100Units, ')
          ..write('fatPer100Units: $fatPer100Units, ')
          ..write('proteinsPer100Units: $proteinsPer100Units, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ServingSizeTable servingSize = $ServingSizeTable(this);
  late final $ProductTable product = $ProductTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [servingSize, product];
}

typedef $$ServingSizeTableCreateCompanionBuilder = ServingSizeCompanion
    Function({
  Value<int> id,
  required String name,
  required String short,
  required MeasurementUnit measuringUnit,
  required double valueInBaseUnit,
  Value<bool> isLiquid,
});
typedef $$ServingSizeTableUpdateCompanionBuilder = ServingSizeCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> short,
  Value<MeasurementUnit> measuringUnit,
  Value<double> valueInBaseUnit,
  Value<bool> isLiquid,
});

final class $$ServingSizeTableReferences
    extends BaseReferences<_$AppDatabase, $ServingSizeTable, ServingSizeData> {
  $$ServingSizeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductTable, List<ProductData>>
      _productRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.product,
          aliasName:
              $_aliasNameGenerator(db.servingSize.id, db.product.servingSize));

  $$ProductTableProcessedTableManager get productRefs {
    final manager = $$ProductTableTableManager($_db, $_db.product)
        .filter((f) => f.servingSize.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_productRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ServingSizeTableFilterComposer
    extends Composer<_$AppDatabase, $ServingSizeTable> {
  $$ServingSizeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get short => $composableBuilder(
      column: $table.short, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MeasurementUnit, MeasurementUnit, int>
      get measuringUnit => $composableBuilder(
          column: $table.measuringUnit,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get valueInBaseUnit => $composableBuilder(
      column: $table.valueInBaseUnit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLiquid => $composableBuilder(
      column: $table.isLiquid, builder: (column) => ColumnFilters(column));

  Expression<bool> productRefs(
      Expression<bool> Function($$ProductTableFilterComposer f) f) {
    final $$ProductTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.servingSize,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableFilterComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ServingSizeTableOrderingComposer
    extends Composer<_$AppDatabase, $ServingSizeTable> {
  $$ServingSizeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get short => $composableBuilder(
      column: $table.short, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get measuringUnit => $composableBuilder(
      column: $table.measuringUnit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valueInBaseUnit => $composableBuilder(
      column: $table.valueInBaseUnit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLiquid => $composableBuilder(
      column: $table.isLiquid, builder: (column) => ColumnOrderings(column));
}

class $$ServingSizeTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServingSizeTable> {
  $$ServingSizeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get short =>
      $composableBuilder(column: $table.short, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MeasurementUnit, int> get measuringUnit =>
      $composableBuilder(
          column: $table.measuringUnit, builder: (column) => column);

  GeneratedColumn<double> get valueInBaseUnit => $composableBuilder(
      column: $table.valueInBaseUnit, builder: (column) => column);

  GeneratedColumn<bool> get isLiquid =>
      $composableBuilder(column: $table.isLiquid, builder: (column) => column);

  Expression<T> productRefs<T extends Object>(
      Expression<T> Function($$ProductTableAnnotationComposer a) f) {
    final $$ProductTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.servingSize,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableAnnotationComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ServingSizeTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ServingSizeTable,
    ServingSizeData,
    $$ServingSizeTableFilterComposer,
    $$ServingSizeTableOrderingComposer,
    $$ServingSizeTableAnnotationComposer,
    $$ServingSizeTableCreateCompanionBuilder,
    $$ServingSizeTableUpdateCompanionBuilder,
    (ServingSizeData, $$ServingSizeTableReferences),
    ServingSizeData,
    PrefetchHooks Function({bool productRefs})> {
  $$ServingSizeTableTableManager(_$AppDatabase db, $ServingSizeTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServingSizeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServingSizeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServingSizeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> short = const Value.absent(),
            Value<MeasurementUnit> measuringUnit = const Value.absent(),
            Value<double> valueInBaseUnit = const Value.absent(),
            Value<bool> isLiquid = const Value.absent(),
          }) =>
              ServingSizeCompanion(
            id: id,
            name: name,
            short: short,
            measuringUnit: measuringUnit,
            valueInBaseUnit: valueInBaseUnit,
            isLiquid: isLiquid,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String short,
            required MeasurementUnit measuringUnit,
            required double valueInBaseUnit,
            Value<bool> isLiquid = const Value.absent(),
          }) =>
              ServingSizeCompanion.insert(
            id: id,
            name: name,
            short: short,
            measuringUnit: measuringUnit,
            valueInBaseUnit: valueInBaseUnit,
            isLiquid: isLiquid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ServingSizeTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({productRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productRefs) db.product],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ServingSizeTableReferences._productRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ServingSizeTableReferences(db, table, p0)
                                .productRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.servingSize == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ServingSizeTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ServingSizeTable,
    ServingSizeData,
    $$ServingSizeTableFilterComposer,
    $$ServingSizeTableOrderingComposer,
    $$ServingSizeTableAnnotationComposer,
    $$ServingSizeTableCreateCompanionBuilder,
    $$ServingSizeTableUpdateCompanionBuilder,
    (ServingSizeData, $$ServingSizeTableReferences),
    ServingSizeData,
    PrefetchHooks Function({bool productRefs})>;
typedef $$ProductTableCreateCompanionBuilder = ProductCompanion Function({
  required String productCode,
  required String name,
  required String brand,
  required int servingSize,
  required double caloriesPer100Units,
  required double carbsPer100Units,
  required double fatPer100Units,
  required double proteinsPer100Units,
  Value<int> rowid,
});
typedef $$ProductTableUpdateCompanionBuilder = ProductCompanion Function({
  Value<String> productCode,
  Value<String> name,
  Value<String> brand,
  Value<int> servingSize,
  Value<double> caloriesPer100Units,
  Value<double> carbsPer100Units,
  Value<double> fatPer100Units,
  Value<double> proteinsPer100Units,
  Value<int> rowid,
});

final class $$ProductTableReferences
    extends BaseReferences<_$AppDatabase, $ProductTable, ProductData> {
  $$ProductTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ServingSizeTable _servingSizeTable(_$AppDatabase db) =>
      db.servingSize.createAlias(
          $_aliasNameGenerator(db.product.servingSize, db.servingSize.id));

  $$ServingSizeTableProcessedTableManager? get servingSize {
    if ($_item.servingSize == null) return null;
    final manager = $$ServingSizeTableTableManager($_db, $_db.servingSize)
        .filter((f) => f.id($_item.servingSize!));
    final item = $_typedResult.readTableOrNull(_servingSizeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProductTableFilterComposer
    extends Composer<_$AppDatabase, $ProductTable> {
  $$ProductTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productCode => $composableBuilder(
      column: $table.productCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get caloriesPer100Units => $composableBuilder(
      column: $table.caloriesPer100Units,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsPer100Units => $composableBuilder(
      column: $table.carbsPer100Units,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatPer100Units => $composableBuilder(
      column: $table.fatPer100Units,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinsPer100Units => $composableBuilder(
      column: $table.proteinsPer100Units,
      builder: (column) => ColumnFilters(column));

  $$ServingSizeTableFilterComposer get servingSize {
    final $$ServingSizeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.servingSize,
        referencedTable: $db.servingSize,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServingSizeTableFilterComposer(
              $db: $db,
              $table: $db.servingSize,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductTable> {
  $$ProductTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productCode => $composableBuilder(
      column: $table.productCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get caloriesPer100Units => $composableBuilder(
      column: $table.caloriesPer100Units,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsPer100Units => $composableBuilder(
      column: $table.carbsPer100Units,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatPer100Units => $composableBuilder(
      column: $table.fatPer100Units,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinsPer100Units => $composableBuilder(
      column: $table.proteinsPer100Units,
      builder: (column) => ColumnOrderings(column));

  $$ServingSizeTableOrderingComposer get servingSize {
    final $$ServingSizeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.servingSize,
        referencedTable: $db.servingSize,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServingSizeTableOrderingComposer(
              $db: $db,
              $table: $db.servingSize,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductTable> {
  $$ProductTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productCode => $composableBuilder(
      column: $table.productCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<double> get caloriesPer100Units => $composableBuilder(
      column: $table.caloriesPer100Units, builder: (column) => column);

  GeneratedColumn<double> get carbsPer100Units => $composableBuilder(
      column: $table.carbsPer100Units, builder: (column) => column);

  GeneratedColumn<double> get fatPer100Units => $composableBuilder(
      column: $table.fatPer100Units, builder: (column) => column);

  GeneratedColumn<double> get proteinsPer100Units => $composableBuilder(
      column: $table.proteinsPer100Units, builder: (column) => column);

  $$ServingSizeTableAnnotationComposer get servingSize {
    final $$ServingSizeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.servingSize,
        referencedTable: $db.servingSize,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServingSizeTableAnnotationComposer(
              $db: $db,
              $table: $db.servingSize,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductTable,
    ProductData,
    $$ProductTableFilterComposer,
    $$ProductTableOrderingComposer,
    $$ProductTableAnnotationComposer,
    $$ProductTableCreateCompanionBuilder,
    $$ProductTableUpdateCompanionBuilder,
    (ProductData, $$ProductTableReferences),
    ProductData,
    PrefetchHooks Function({bool servingSize})> {
  $$ProductTableTableManager(_$AppDatabase db, $ProductTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> productCode = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> brand = const Value.absent(),
            Value<int> servingSize = const Value.absent(),
            Value<double> caloriesPer100Units = const Value.absent(),
            Value<double> carbsPer100Units = const Value.absent(),
            Value<double> fatPer100Units = const Value.absent(),
            Value<double> proteinsPer100Units = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductCompanion(
            productCode: productCode,
            name: name,
            brand: brand,
            servingSize: servingSize,
            caloriesPer100Units: caloriesPer100Units,
            carbsPer100Units: carbsPer100Units,
            fatPer100Units: fatPer100Units,
            proteinsPer100Units: proteinsPer100Units,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String productCode,
            required String name,
            required String brand,
            required int servingSize,
            required double caloriesPer100Units,
            required double carbsPer100Units,
            required double fatPer100Units,
            required double proteinsPer100Units,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductCompanion.insert(
            productCode: productCode,
            name: name,
            brand: brand,
            servingSize: servingSize,
            caloriesPer100Units: caloriesPer100Units,
            carbsPer100Units: carbsPer100Units,
            fatPer100Units: fatPer100Units,
            proteinsPer100Units: proteinsPer100Units,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProductTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({servingSize = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (servingSize) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.servingSize,
                    referencedTable:
                        $$ProductTableReferences._servingSizeTable(db),
                    referencedColumn:
                        $$ProductTableReferences._servingSizeTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProductTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductTable,
    ProductData,
    $$ProductTableFilterComposer,
    $$ProductTableOrderingComposer,
    $$ProductTableAnnotationComposer,
    $$ProductTableCreateCompanionBuilder,
    $$ProductTableUpdateCompanionBuilder,
    (ProductData, $$ProductTableReferences),
    ProductData,
    PrefetchHooks Function({bool servingSize})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ServingSizeTableTableManager get servingSize =>
      $$ServingSizeTableTableManager(_db, _db.servingSize);
  $$ProductTableTableManager get product =>
      $$ProductTableTableManager(_db, _db.product);
}

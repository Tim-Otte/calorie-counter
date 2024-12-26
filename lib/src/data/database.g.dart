// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _isLiquidMeta =
      const VerificationMeta('isLiquid');
  @override
  late final GeneratedColumn<bool> isLiquid = GeneratedColumn<bool>(
      'is_liquid', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_liquid" IN (0, 1))'));
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
        isLiquid,
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
    if (data.containsKey('is_liquid')) {
      context.handle(_isLiquidMeta,
          isLiquid.isAcceptableOrUnknown(data['is_liquid']!, _isLiquidMeta));
    } else if (isInserting) {
      context.missing(_isLiquidMeta);
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
      isLiquid: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_liquid'])!,
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
  final bool isLiquid;
  final double caloriesPer100Units;
  final double carbsPer100Units;
  final double fatPer100Units;
  final double proteinsPer100Units;
  const ProductData(
      {required this.productCode,
      required this.name,
      required this.brand,
      required this.isLiquid,
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
    map['is_liquid'] = Variable<bool>(isLiquid);
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
      isLiquid: Value(isLiquid),
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
      isLiquid: serializer.fromJson<bool>(json['isLiquid']),
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
      'isLiquid': serializer.toJson<bool>(isLiquid),
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
          bool? isLiquid,
          double? caloriesPer100Units,
          double? carbsPer100Units,
          double? fatPer100Units,
          double? proteinsPer100Units}) =>
      ProductData(
        productCode: productCode ?? this.productCode,
        name: name ?? this.name,
        brand: brand ?? this.brand,
        isLiquid: isLiquid ?? this.isLiquid,
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
      isLiquid: data.isLiquid.present ? data.isLiquid.value : this.isLiquid,
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
          ..write('isLiquid: $isLiquid, ')
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
      isLiquid,
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
          other.isLiquid == this.isLiquid &&
          other.caloriesPer100Units == this.caloriesPer100Units &&
          other.carbsPer100Units == this.carbsPer100Units &&
          other.fatPer100Units == this.fatPer100Units &&
          other.proteinsPer100Units == this.proteinsPer100Units);
}

class ProductCompanion extends UpdateCompanion<ProductData> {
  final Value<String> productCode;
  final Value<String> name;
  final Value<String> brand;
  final Value<bool> isLiquid;
  final Value<double> caloriesPer100Units;
  final Value<double> carbsPer100Units;
  final Value<double> fatPer100Units;
  final Value<double> proteinsPer100Units;
  final Value<int> rowid;
  const ProductCompanion({
    this.productCode = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.isLiquid = const Value.absent(),
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
    required bool isLiquid,
    required double caloriesPer100Units,
    required double carbsPer100Units,
    required double fatPer100Units,
    required double proteinsPer100Units,
    this.rowid = const Value.absent(),
  })  : productCode = Value(productCode),
        name = Value(name),
        brand = Value(brand),
        isLiquid = Value(isLiquid),
        caloriesPer100Units = Value(caloriesPer100Units),
        carbsPer100Units = Value(carbsPer100Units),
        fatPer100Units = Value(fatPer100Units),
        proteinsPer100Units = Value(proteinsPer100Units);
  static Insertable<ProductData> custom({
    Expression<String>? productCode,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<bool>? isLiquid,
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
      if (isLiquid != null) 'is_liquid': isLiquid,
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
      Value<bool>? isLiquid,
      Value<double>? caloriesPer100Units,
      Value<double>? carbsPer100Units,
      Value<double>? fatPer100Units,
      Value<double>? proteinsPer100Units,
      Value<int>? rowid}) {
    return ProductCompanion(
      productCode: productCode ?? this.productCode,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      isLiquid: isLiquid ?? this.isLiquid,
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
    if (isLiquid.present) {
      map['is_liquid'] = Variable<bool>(isLiquid.value);
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
          ..write('isLiquid: $isLiquid, ')
          ..write('caloriesPer100Units: $caloriesPer100Units, ')
          ..write('carbsPer100Units: $carbsPer100Units, ')
          ..write('fatPer100Units: $fatPer100Units, ')
          ..write('proteinsPer100Units: $proteinsPer100Units, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shortMeta = const VerificationMeta('short');
  @override
  late final GeneratedColumn<String> short = GeneratedColumn<String>(
      'short', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _measuringUnitMeta =
      const VerificationMeta('measuringUnit');
  @override
  late final GeneratedColumnWithTypeConverter<MeasurementUnit, int>
      measuringUnit = GeneratedColumn<int>('measuring_unit', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MeasurementUnit>(
              $ServingSizeTable.$convertermeasuringUnit);
  static const VerificationMeta _valueInBaseServingSizeMeta =
      const VerificationMeta('valueInBaseServingSize');
  @override
  late final GeneratedColumn<double> valueInBaseServingSize =
      GeneratedColumn<double>('value_in_base_serving_size', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _baseServingSizeIdMeta =
      const VerificationMeta('baseServingSizeId');
  @override
  late final GeneratedColumn<int> baseServingSizeId = GeneratedColumn<int>(
      'base_serving_size_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES serving_size (id)'));
  static const VerificationMeta _forProductMeta =
      const VerificationMeta('forProduct');
  @override
  late final GeneratedColumn<String> forProduct = GeneratedColumn<String>(
      'for_product', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product (product_code)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        short,
        isLiquid,
        measuringUnit,
        valueInBaseServingSize,
        baseServingSizeId,
        forProduct
      ];
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
    }
    if (data.containsKey('is_liquid')) {
      context.handle(_isLiquidMeta,
          isLiquid.isAcceptableOrUnknown(data['is_liquid']!, _isLiquidMeta));
    }
    context.handle(_measuringUnitMeta, const VerificationResult.success());
    if (data.containsKey('value_in_base_serving_size')) {
      context.handle(
          _valueInBaseServingSizeMeta,
          valueInBaseServingSize.isAcceptableOrUnknown(
              data['value_in_base_serving_size']!,
              _valueInBaseServingSizeMeta));
    } else if (isInserting) {
      context.missing(_valueInBaseServingSizeMeta);
    }
    if (data.containsKey('base_serving_size_id')) {
      context.handle(
          _baseServingSizeIdMeta,
          baseServingSizeId.isAcceptableOrUnknown(
              data['base_serving_size_id']!, _baseServingSizeIdMeta));
    }
    if (data.containsKey('for_product')) {
      context.handle(
          _forProductMeta,
          forProduct.isAcceptableOrUnknown(
              data['for_product']!, _forProductMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {name, short, forProduct},
      ];
  @override
  ServingSizeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServingSizeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      short: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}short']),
      isLiquid: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_liquid'])!,
      measuringUnit: $ServingSizeTable.$convertermeasuringUnit.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}measuring_unit'])!),
      valueInBaseServingSize: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}value_in_base_serving_size'])!,
      baseServingSizeId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}base_serving_size_id']),
      forProduct: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}for_product']),
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
  final String? short;
  final bool isLiquid;
  final MeasurementUnit measuringUnit;
  final double valueInBaseServingSize;
  final int? baseServingSizeId;
  final String? forProduct;
  const ServingSizeData(
      {required this.id,
      required this.name,
      this.short,
      required this.isLiquid,
      required this.measuringUnit,
      required this.valueInBaseServingSize,
      this.baseServingSizeId,
      this.forProduct});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || short != null) {
      map['short'] = Variable<String>(short);
    }
    map['is_liquid'] = Variable<bool>(isLiquid);
    {
      map['measuring_unit'] = Variable<int>(
          $ServingSizeTable.$convertermeasuringUnit.toSql(measuringUnit));
    }
    map['value_in_base_serving_size'] =
        Variable<double>(valueInBaseServingSize);
    if (!nullToAbsent || baseServingSizeId != null) {
      map['base_serving_size_id'] = Variable<int>(baseServingSizeId);
    }
    if (!nullToAbsent || forProduct != null) {
      map['for_product'] = Variable<String>(forProduct);
    }
    return map;
  }

  ServingSizeCompanion toCompanion(bool nullToAbsent) {
    return ServingSizeCompanion(
      id: Value(id),
      name: Value(name),
      short:
          short == null && nullToAbsent ? const Value.absent() : Value(short),
      isLiquid: Value(isLiquid),
      measuringUnit: Value(measuringUnit),
      valueInBaseServingSize: Value(valueInBaseServingSize),
      baseServingSizeId: baseServingSizeId == null && nullToAbsent
          ? const Value.absent()
          : Value(baseServingSizeId),
      forProduct: forProduct == null && nullToAbsent
          ? const Value.absent()
          : Value(forProduct),
    );
  }

  factory ServingSizeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServingSizeData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      short: serializer.fromJson<String?>(json['short']),
      isLiquid: serializer.fromJson<bool>(json['isLiquid']),
      measuringUnit: $ServingSizeTable.$convertermeasuringUnit
          .fromJson(serializer.fromJson<int>(json['measuringUnit'])),
      valueInBaseServingSize:
          serializer.fromJson<double>(json['valueInBaseServingSize']),
      baseServingSizeId: serializer.fromJson<int?>(json['baseServingSizeId']),
      forProduct: serializer.fromJson<String?>(json['forProduct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'short': serializer.toJson<String?>(short),
      'isLiquid': serializer.toJson<bool>(isLiquid),
      'measuringUnit': serializer.toJson<int>(
          $ServingSizeTable.$convertermeasuringUnit.toJson(measuringUnit)),
      'valueInBaseServingSize':
          serializer.toJson<double>(valueInBaseServingSize),
      'baseServingSizeId': serializer.toJson<int?>(baseServingSizeId),
      'forProduct': serializer.toJson<String?>(forProduct),
    };
  }

  ServingSizeData copyWith(
          {int? id,
          String? name,
          Value<String?> short = const Value.absent(),
          bool? isLiquid,
          MeasurementUnit? measuringUnit,
          double? valueInBaseServingSize,
          Value<int?> baseServingSizeId = const Value.absent(),
          Value<String?> forProduct = const Value.absent()}) =>
      ServingSizeData(
        id: id ?? this.id,
        name: name ?? this.name,
        short: short.present ? short.value : this.short,
        isLiquid: isLiquid ?? this.isLiquid,
        measuringUnit: measuringUnit ?? this.measuringUnit,
        valueInBaseServingSize:
            valueInBaseServingSize ?? this.valueInBaseServingSize,
        baseServingSizeId: baseServingSizeId.present
            ? baseServingSizeId.value
            : this.baseServingSizeId,
        forProduct: forProduct.present ? forProduct.value : this.forProduct,
      );
  ServingSizeData copyWithCompanion(ServingSizeCompanion data) {
    return ServingSizeData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      short: data.short.present ? data.short.value : this.short,
      isLiquid: data.isLiquid.present ? data.isLiquid.value : this.isLiquid,
      measuringUnit: data.measuringUnit.present
          ? data.measuringUnit.value
          : this.measuringUnit,
      valueInBaseServingSize: data.valueInBaseServingSize.present
          ? data.valueInBaseServingSize.value
          : this.valueInBaseServingSize,
      baseServingSizeId: data.baseServingSizeId.present
          ? data.baseServingSizeId.value
          : this.baseServingSizeId,
      forProduct:
          data.forProduct.present ? data.forProduct.value : this.forProduct,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServingSizeData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('short: $short, ')
          ..write('isLiquid: $isLiquid, ')
          ..write('measuringUnit: $measuringUnit, ')
          ..write('valueInBaseServingSize: $valueInBaseServingSize, ')
          ..write('baseServingSizeId: $baseServingSizeId, ')
          ..write('forProduct: $forProduct')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, short, isLiquid, measuringUnit,
      valueInBaseServingSize, baseServingSizeId, forProduct);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServingSizeData &&
          other.id == this.id &&
          other.name == this.name &&
          other.short == this.short &&
          other.isLiquid == this.isLiquid &&
          other.measuringUnit == this.measuringUnit &&
          other.valueInBaseServingSize == this.valueInBaseServingSize &&
          other.baseServingSizeId == this.baseServingSizeId &&
          other.forProduct == this.forProduct);
}

class ServingSizeCompanion extends UpdateCompanion<ServingSizeData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> short;
  final Value<bool> isLiquid;
  final Value<MeasurementUnit> measuringUnit;
  final Value<double> valueInBaseServingSize;
  final Value<int?> baseServingSizeId;
  final Value<String?> forProduct;
  const ServingSizeCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.short = const Value.absent(),
    this.isLiquid = const Value.absent(),
    this.measuringUnit = const Value.absent(),
    this.valueInBaseServingSize = const Value.absent(),
    this.baseServingSizeId = const Value.absent(),
    this.forProduct = const Value.absent(),
  });
  ServingSizeCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.short = const Value.absent(),
    this.isLiquid = const Value.absent(),
    required MeasurementUnit measuringUnit,
    required double valueInBaseServingSize,
    this.baseServingSizeId = const Value.absent(),
    this.forProduct = const Value.absent(),
  })  : name = Value(name),
        measuringUnit = Value(measuringUnit),
        valueInBaseServingSize = Value(valueInBaseServingSize);
  static Insertable<ServingSizeData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? short,
    Expression<bool>? isLiquid,
    Expression<int>? measuringUnit,
    Expression<double>? valueInBaseServingSize,
    Expression<int>? baseServingSizeId,
    Expression<String>? forProduct,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (short != null) 'short': short,
      if (isLiquid != null) 'is_liquid': isLiquid,
      if (measuringUnit != null) 'measuring_unit': measuringUnit,
      if (valueInBaseServingSize != null)
        'value_in_base_serving_size': valueInBaseServingSize,
      if (baseServingSizeId != null) 'base_serving_size_id': baseServingSizeId,
      if (forProduct != null) 'for_product': forProduct,
    });
  }

  ServingSizeCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? short,
      Value<bool>? isLiquid,
      Value<MeasurementUnit>? measuringUnit,
      Value<double>? valueInBaseServingSize,
      Value<int?>? baseServingSizeId,
      Value<String?>? forProduct}) {
    return ServingSizeCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      short: short ?? this.short,
      isLiquid: isLiquid ?? this.isLiquid,
      measuringUnit: measuringUnit ?? this.measuringUnit,
      valueInBaseServingSize:
          valueInBaseServingSize ?? this.valueInBaseServingSize,
      baseServingSizeId: baseServingSizeId ?? this.baseServingSizeId,
      forProduct: forProduct ?? this.forProduct,
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
    if (isLiquid.present) {
      map['is_liquid'] = Variable<bool>(isLiquid.value);
    }
    if (measuringUnit.present) {
      map['measuring_unit'] = Variable<int>(
          $ServingSizeTable.$convertermeasuringUnit.toSql(measuringUnit.value));
    }
    if (valueInBaseServingSize.present) {
      map['value_in_base_serving_size'] =
          Variable<double>(valueInBaseServingSize.value);
    }
    if (baseServingSizeId.present) {
      map['base_serving_size_id'] = Variable<int>(baseServingSizeId.value);
    }
    if (forProduct.present) {
      map['for_product'] = Variable<String>(forProduct.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServingSizeCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('short: $short, ')
          ..write('isLiquid: $isLiquid, ')
          ..write('measuringUnit: $measuringUnit, ')
          ..write('valueInBaseServingSize: $valueInBaseServingSize, ')
          ..write('baseServingSizeId: $baseServingSizeId, ')
          ..write('forProduct: $forProduct')
          ..write(')'))
        .toString();
  }
}

class $ConsumptionTable extends Consumption
    with TableInfo<$ConsumptionTable, ConsumptionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsumptionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _loggedOnMeta =
      const VerificationMeta('loggedOn');
  @override
  late final GeneratedColumn<DateTime> loggedOn = GeneratedColumn<DateTime>(
      'logged_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _productCodeMeta =
      const VerificationMeta('productCode');
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
      'product_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product (product_code)'));
  static const VerificationMeta _servingSizeIdMeta =
      const VerificationMeta('servingSizeId');
  @override
  late final GeneratedColumn<int> servingSizeId = GeneratedColumn<int>(
      'serving_size_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES serving_size (id)'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _mealTypeMeta =
      const VerificationMeta('mealType');
  @override
  late final GeneratedColumnWithTypeConverter<MealType, int> mealType =
      GeneratedColumn<int>('meal_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MealType>($ConsumptionTable.$convertermealType);
  @override
  List<GeneratedColumn> get $columns =>
      [id, loggedOn, productCode, servingSizeId, quantity, mealType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consumption';
  @override
  VerificationContext validateIntegrity(Insertable<ConsumptionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('logged_on')) {
      context.handle(_loggedOnMeta,
          loggedOn.isAcceptableOrUnknown(data['logged_on']!, _loggedOnMeta));
    } else if (isInserting) {
      context.missing(_loggedOnMeta);
    }
    if (data.containsKey('product_code')) {
      context.handle(
          _productCodeMeta,
          productCode.isAcceptableOrUnknown(
              data['product_code']!, _productCodeMeta));
    } else if (isInserting) {
      context.missing(_productCodeMeta);
    }
    if (data.containsKey('serving_size_id')) {
      context.handle(
          _servingSizeIdMeta,
          servingSizeId.isAcceptableOrUnknown(
              data['serving_size_id']!, _servingSizeIdMeta));
    } else if (isInserting) {
      context.missing(_servingSizeIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    context.handle(_mealTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConsumptionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConsumptionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      loggedOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}logged_on'])!,
      productCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_code'])!,
      servingSizeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}serving_size_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      mealType: $ConsumptionTable.$convertermealType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meal_type'])!),
    );
  }

  @override
  $ConsumptionTable createAlias(String alias) {
    return $ConsumptionTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MealType, int, int> $convertermealType =
      const EnumIndexConverter<MealType>(MealType.values);
}

class ConsumptionData extends DataClass implements Insertable<ConsumptionData> {
  final int id;
  final DateTime loggedOn;
  final String productCode;
  final int servingSizeId;
  final double quantity;
  final MealType mealType;
  const ConsumptionData(
      {required this.id,
      required this.loggedOn,
      required this.productCode,
      required this.servingSizeId,
      required this.quantity,
      required this.mealType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['logged_on'] = Variable<DateTime>(loggedOn);
    map['product_code'] = Variable<String>(productCode);
    map['serving_size_id'] = Variable<int>(servingSizeId);
    map['quantity'] = Variable<double>(quantity);
    {
      map['meal_type'] =
          Variable<int>($ConsumptionTable.$convertermealType.toSql(mealType));
    }
    return map;
  }

  ConsumptionCompanion toCompanion(bool nullToAbsent) {
    return ConsumptionCompanion(
      id: Value(id),
      loggedOn: Value(loggedOn),
      productCode: Value(productCode),
      servingSizeId: Value(servingSizeId),
      quantity: Value(quantity),
      mealType: Value(mealType),
    );
  }

  factory ConsumptionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConsumptionData(
      id: serializer.fromJson<int>(json['id']),
      loggedOn: serializer.fromJson<DateTime>(json['loggedOn']),
      productCode: serializer.fromJson<String>(json['productCode']),
      servingSizeId: serializer.fromJson<int>(json['servingSizeId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      mealType: $ConsumptionTable.$convertermealType
          .fromJson(serializer.fromJson<int>(json['mealType'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'loggedOn': serializer.toJson<DateTime>(loggedOn),
      'productCode': serializer.toJson<String>(productCode),
      'servingSizeId': serializer.toJson<int>(servingSizeId),
      'quantity': serializer.toJson<double>(quantity),
      'mealType': serializer
          .toJson<int>($ConsumptionTable.$convertermealType.toJson(mealType)),
    };
  }

  ConsumptionData copyWith(
          {int? id,
          DateTime? loggedOn,
          String? productCode,
          int? servingSizeId,
          double? quantity,
          MealType? mealType}) =>
      ConsumptionData(
        id: id ?? this.id,
        loggedOn: loggedOn ?? this.loggedOn,
        productCode: productCode ?? this.productCode,
        servingSizeId: servingSizeId ?? this.servingSizeId,
        quantity: quantity ?? this.quantity,
        mealType: mealType ?? this.mealType,
      );
  ConsumptionData copyWithCompanion(ConsumptionCompanion data) {
    return ConsumptionData(
      id: data.id.present ? data.id.value : this.id,
      loggedOn: data.loggedOn.present ? data.loggedOn.value : this.loggedOn,
      productCode:
          data.productCode.present ? data.productCode.value : this.productCode,
      servingSizeId: data.servingSizeId.present
          ? data.servingSizeId.value
          : this.servingSizeId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConsumptionData(')
          ..write('id: $id, ')
          ..write('loggedOn: $loggedOn, ')
          ..write('productCode: $productCode, ')
          ..write('servingSizeId: $servingSizeId, ')
          ..write('quantity: $quantity, ')
          ..write('mealType: $mealType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, loggedOn, productCode, servingSizeId, quantity, mealType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConsumptionData &&
          other.id == this.id &&
          other.loggedOn == this.loggedOn &&
          other.productCode == this.productCode &&
          other.servingSizeId == this.servingSizeId &&
          other.quantity == this.quantity &&
          other.mealType == this.mealType);
}

class ConsumptionCompanion extends UpdateCompanion<ConsumptionData> {
  final Value<int> id;
  final Value<DateTime> loggedOn;
  final Value<String> productCode;
  final Value<int> servingSizeId;
  final Value<double> quantity;
  final Value<MealType> mealType;
  const ConsumptionCompanion({
    this.id = const Value.absent(),
    this.loggedOn = const Value.absent(),
    this.productCode = const Value.absent(),
    this.servingSizeId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.mealType = const Value.absent(),
  });
  ConsumptionCompanion.insert({
    this.id = const Value.absent(),
    required DateTime loggedOn,
    required String productCode,
    required int servingSizeId,
    required double quantity,
    required MealType mealType,
  })  : loggedOn = Value(loggedOn),
        productCode = Value(productCode),
        servingSizeId = Value(servingSizeId),
        quantity = Value(quantity),
        mealType = Value(mealType);
  static Insertable<ConsumptionData> custom({
    Expression<int>? id,
    Expression<DateTime>? loggedOn,
    Expression<String>? productCode,
    Expression<int>? servingSizeId,
    Expression<double>? quantity,
    Expression<int>? mealType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (loggedOn != null) 'logged_on': loggedOn,
      if (productCode != null) 'product_code': productCode,
      if (servingSizeId != null) 'serving_size_id': servingSizeId,
      if (quantity != null) 'quantity': quantity,
      if (mealType != null) 'meal_type': mealType,
    });
  }

  ConsumptionCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? loggedOn,
      Value<String>? productCode,
      Value<int>? servingSizeId,
      Value<double>? quantity,
      Value<MealType>? mealType}) {
    return ConsumptionCompanion(
      id: id ?? this.id,
      loggedOn: loggedOn ?? this.loggedOn,
      productCode: productCode ?? this.productCode,
      servingSizeId: servingSizeId ?? this.servingSizeId,
      quantity: quantity ?? this.quantity,
      mealType: mealType ?? this.mealType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (loggedOn.present) {
      map['logged_on'] = Variable<DateTime>(loggedOn.value);
    }
    if (productCode.present) {
      map['product_code'] = Variable<String>(productCode.value);
    }
    if (servingSizeId.present) {
      map['serving_size_id'] = Variable<int>(servingSizeId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<int>(
          $ConsumptionTable.$convertermealType.toSql(mealType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsumptionCompanion(')
          ..write('id: $id, ')
          ..write('loggedOn: $loggedOn, ')
          ..write('productCode: $productCode, ')
          ..write('servingSizeId: $servingSizeId, ')
          ..write('quantity: $quantity, ')
          ..write('mealType: $mealType')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductTable product = $ProductTable(this);
  late final $ServingSizeTable servingSize = $ServingSizeTable(this);
  late final $ConsumptionTable consumption = $ConsumptionTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [product, servingSize, consumption];
}

typedef $$ProductTableCreateCompanionBuilder = ProductCompanion Function({
  required String productCode,
  required String name,
  required String brand,
  required bool isLiquid,
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
  Value<bool> isLiquid,
  Value<double> caloriesPer100Units,
  Value<double> carbsPer100Units,
  Value<double> fatPer100Units,
  Value<double> proteinsPer100Units,
  Value<int> rowid,
});

final class $$ProductTableReferences
    extends BaseReferences<_$AppDatabase, $ProductTable, ProductData> {
  $$ProductTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ServingSizeTable, List<ServingSizeData>>
      _servingSizeRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.servingSize,
              aliasName: $_aliasNameGenerator(
                  db.product.productCode, db.servingSize.forProduct));

  $$ServingSizeTableProcessedTableManager get servingSizeRefs {
    final manager = $$ServingSizeTableTableManager($_db, $_db.servingSize)
        .filter((f) => f.forProduct.productCode($_item.productCode));

    final cache = $_typedResult.readTableOrNull(_servingSizeRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ConsumptionTable, List<ConsumptionData>>
      _consumptionRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.consumption,
              aliasName: $_aliasNameGenerator(
                  db.product.productCode, db.consumption.productCode));

  $$ConsumptionTableProcessedTableManager get consumptionRefs {
    final manager = $$ConsumptionTableTableManager($_db, $_db.consumption)
        .filter((f) => f.productCode.productCode($_item.productCode));

    final cache = $_typedResult.readTableOrNull(_consumptionRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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

  ColumnFilters<bool> get isLiquid => $composableBuilder(
      column: $table.isLiquid, builder: (column) => ColumnFilters(column));

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

  Expression<bool> servingSizeRefs(
      Expression<bool> Function($$ServingSizeTableFilterComposer f) f) {
    final $$ServingSizeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productCode,
        referencedTable: $db.servingSize,
        getReferencedColumn: (t) => t.forProduct,
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
    return f(composer);
  }

  Expression<bool> consumptionRefs(
      Expression<bool> Function($$ConsumptionTableFilterComposer f) f) {
    final $$ConsumptionTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productCode,
        referencedTable: $db.consumption,
        getReferencedColumn: (t) => t.productCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConsumptionTableFilterComposer(
              $db: $db,
              $table: $db.consumption,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
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

  ColumnOrderings<bool> get isLiquid => $composableBuilder(
      column: $table.isLiquid, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<bool> get isLiquid =>
      $composableBuilder(column: $table.isLiquid, builder: (column) => column);

  GeneratedColumn<double> get caloriesPer100Units => $composableBuilder(
      column: $table.caloriesPer100Units, builder: (column) => column);

  GeneratedColumn<double> get carbsPer100Units => $composableBuilder(
      column: $table.carbsPer100Units, builder: (column) => column);

  GeneratedColumn<double> get fatPer100Units => $composableBuilder(
      column: $table.fatPer100Units, builder: (column) => column);

  GeneratedColumn<double> get proteinsPer100Units => $composableBuilder(
      column: $table.proteinsPer100Units, builder: (column) => column);

  Expression<T> servingSizeRefs<T extends Object>(
      Expression<T> Function($$ServingSizeTableAnnotationComposer a) f) {
    final $$ServingSizeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productCode,
        referencedTable: $db.servingSize,
        getReferencedColumn: (t) => t.forProduct,
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
    return f(composer);
  }

  Expression<T> consumptionRefs<T extends Object>(
      Expression<T> Function($$ConsumptionTableAnnotationComposer a) f) {
    final $$ConsumptionTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productCode,
        referencedTable: $db.consumption,
        getReferencedColumn: (t) => t.productCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConsumptionTableAnnotationComposer(
              $db: $db,
              $table: $db.consumption,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
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
    PrefetchHooks Function({bool servingSizeRefs, bool consumptionRefs})> {
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
            Value<bool> isLiquid = const Value.absent(),
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
            isLiquid: isLiquid,
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
            required bool isLiquid,
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
            isLiquid: isLiquid,
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
          prefetchHooksCallback: (
              {servingSizeRefs = false, consumptionRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (servingSizeRefs) db.servingSize,
                if (consumptionRefs) db.consumption
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (servingSizeRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ProductTableReferences._servingSizeRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductTableReferences(db, table, p0)
                                .servingSizeRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.forProduct == item.productCode),
                        typedResults: items),
                  if (consumptionRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ProductTableReferences._consumptionRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductTableReferences(db, table, p0)
                                .consumptionRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.productCode == item.productCode),
                        typedResults: items)
                ];
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
    PrefetchHooks Function({bool servingSizeRefs, bool consumptionRefs})>;
typedef $$ServingSizeTableCreateCompanionBuilder = ServingSizeCompanion
    Function({
  Value<int> id,
  required String name,
  Value<String?> short,
  Value<bool> isLiquid,
  required MeasurementUnit measuringUnit,
  required double valueInBaseServingSize,
  Value<int?> baseServingSizeId,
  Value<String?> forProduct,
});
typedef $$ServingSizeTableUpdateCompanionBuilder = ServingSizeCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String?> short,
  Value<bool> isLiquid,
  Value<MeasurementUnit> measuringUnit,
  Value<double> valueInBaseServingSize,
  Value<int?> baseServingSizeId,
  Value<String?> forProduct,
});

final class $$ServingSizeTableReferences
    extends BaseReferences<_$AppDatabase, $ServingSizeTable, ServingSizeData> {
  $$ServingSizeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ServingSizeTable _baseServingSizeIdTable(_$AppDatabase db) =>
      db.servingSize.createAlias($_aliasNameGenerator(
          db.servingSize.baseServingSizeId, db.servingSize.id));

  $$ServingSizeTableProcessedTableManager? get baseServingSizeId {
    if ($_item.baseServingSizeId == null) return null;
    final manager = $$ServingSizeTableTableManager($_db, $_db.servingSize)
        .filter((f) => f.id($_item.baseServingSizeId!));
    final item = $_typedResult.readTableOrNull(_baseServingSizeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductTable _forProductTable(_$AppDatabase db) =>
      db.product.createAlias($_aliasNameGenerator(
          db.servingSize.forProduct, db.product.productCode));

  $$ProductTableProcessedTableManager? get forProduct {
    if ($_item.forProduct == null) return null;
    final manager = $$ProductTableTableManager($_db, $_db.product)
        .filter((f) => f.productCode($_item.forProduct!));
    final item = $_typedResult.readTableOrNull(_forProductTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ConsumptionTable, List<ConsumptionData>>
      _consumptionRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.consumption,
              aliasName: $_aliasNameGenerator(
                  db.servingSize.id, db.consumption.servingSizeId));

  $$ConsumptionTableProcessedTableManager get consumptionRefs {
    final manager = $$ConsumptionTableTableManager($_db, $_db.consumption)
        .filter((f) => f.servingSizeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_consumptionRefsTable($_db));
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

  ColumnFilters<bool> get isLiquid => $composableBuilder(
      column: $table.isLiquid, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MeasurementUnit, MeasurementUnit, int>
      get measuringUnit => $composableBuilder(
          column: $table.measuringUnit,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get valueInBaseServingSize => $composableBuilder(
      column: $table.valueInBaseServingSize,
      builder: (column) => ColumnFilters(column));

  $$ServingSizeTableFilterComposer get baseServingSizeId {
    final $$ServingSizeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.baseServingSizeId,
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

  $$ProductTableFilterComposer get forProduct {
    final $$ProductTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.forProduct,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.productCode,
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
    return composer;
  }

  Expression<bool> consumptionRefs(
      Expression<bool> Function($$ConsumptionTableFilterComposer f) f) {
    final $$ConsumptionTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.consumption,
        getReferencedColumn: (t) => t.servingSizeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConsumptionTableFilterComposer(
              $db: $db,
              $table: $db.consumption,
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

  ColumnOrderings<bool> get isLiquid => $composableBuilder(
      column: $table.isLiquid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get measuringUnit => $composableBuilder(
      column: $table.measuringUnit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valueInBaseServingSize => $composableBuilder(
      column: $table.valueInBaseServingSize,
      builder: (column) => ColumnOrderings(column));

  $$ServingSizeTableOrderingComposer get baseServingSizeId {
    final $$ServingSizeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.baseServingSizeId,
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

  $$ProductTableOrderingComposer get forProduct {
    final $$ProductTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.forProduct,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.productCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableOrderingComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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

  GeneratedColumn<bool> get isLiquid =>
      $composableBuilder(column: $table.isLiquid, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MeasurementUnit, int> get measuringUnit =>
      $composableBuilder(
          column: $table.measuringUnit, builder: (column) => column);

  GeneratedColumn<double> get valueInBaseServingSize => $composableBuilder(
      column: $table.valueInBaseServingSize, builder: (column) => column);

  $$ServingSizeTableAnnotationComposer get baseServingSizeId {
    final $$ServingSizeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.baseServingSizeId,
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

  $$ProductTableAnnotationComposer get forProduct {
    final $$ProductTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.forProduct,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.productCode,
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
    return composer;
  }

  Expression<T> consumptionRefs<T extends Object>(
      Expression<T> Function($$ConsumptionTableAnnotationComposer a) f) {
    final $$ConsumptionTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.consumption,
        getReferencedColumn: (t) => t.servingSizeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConsumptionTableAnnotationComposer(
              $db: $db,
              $table: $db.consumption,
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
    PrefetchHooks Function(
        {bool baseServingSizeId, bool forProduct, bool consumptionRefs})> {
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
            Value<String?> short = const Value.absent(),
            Value<bool> isLiquid = const Value.absent(),
            Value<MeasurementUnit> measuringUnit = const Value.absent(),
            Value<double> valueInBaseServingSize = const Value.absent(),
            Value<int?> baseServingSizeId = const Value.absent(),
            Value<String?> forProduct = const Value.absent(),
          }) =>
              ServingSizeCompanion(
            id: id,
            name: name,
            short: short,
            isLiquid: isLiquid,
            measuringUnit: measuringUnit,
            valueInBaseServingSize: valueInBaseServingSize,
            baseServingSizeId: baseServingSizeId,
            forProduct: forProduct,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> short = const Value.absent(),
            Value<bool> isLiquid = const Value.absent(),
            required MeasurementUnit measuringUnit,
            required double valueInBaseServingSize,
            Value<int?> baseServingSizeId = const Value.absent(),
            Value<String?> forProduct = const Value.absent(),
          }) =>
              ServingSizeCompanion.insert(
            id: id,
            name: name,
            short: short,
            isLiquid: isLiquid,
            measuringUnit: measuringUnit,
            valueInBaseServingSize: valueInBaseServingSize,
            baseServingSizeId: baseServingSizeId,
            forProduct: forProduct,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ServingSizeTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {baseServingSizeId = false,
              forProduct = false,
              consumptionRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (consumptionRefs) db.consumption],
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
                if (baseServingSizeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.baseServingSizeId,
                    referencedTable: $$ServingSizeTableReferences
                        ._baseServingSizeIdTable(db),
                    referencedColumn: $$ServingSizeTableReferences
                        ._baseServingSizeIdTable(db)
                        .id,
                  ) as T;
                }
                if (forProduct) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.forProduct,
                    referencedTable:
                        $$ServingSizeTableReferences._forProductTable(db),
                    referencedColumn: $$ServingSizeTableReferences
                        ._forProductTable(db)
                        .productCode,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (consumptionRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ServingSizeTableReferences
                            ._consumptionRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ServingSizeTableReferences(db, table, p0)
                                .consumptionRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.servingSizeId == item.id),
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
    PrefetchHooks Function(
        {bool baseServingSizeId, bool forProduct, bool consumptionRefs})>;
typedef $$ConsumptionTableCreateCompanionBuilder = ConsumptionCompanion
    Function({
  Value<int> id,
  required DateTime loggedOn,
  required String productCode,
  required int servingSizeId,
  required double quantity,
  required MealType mealType,
});
typedef $$ConsumptionTableUpdateCompanionBuilder = ConsumptionCompanion
    Function({
  Value<int> id,
  Value<DateTime> loggedOn,
  Value<String> productCode,
  Value<int> servingSizeId,
  Value<double> quantity,
  Value<MealType> mealType,
});

final class $$ConsumptionTableReferences
    extends BaseReferences<_$AppDatabase, $ConsumptionTable, ConsumptionData> {
  $$ConsumptionTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductTable _productCodeTable(_$AppDatabase db) =>
      db.product.createAlias($_aliasNameGenerator(
          db.consumption.productCode, db.product.productCode));

  $$ProductTableProcessedTableManager get productCode {
    final manager = $$ProductTableTableManager($_db, $_db.product)
        .filter((f) => f.productCode($_item.productCode!));
    final item = $_typedResult.readTableOrNull(_productCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ServingSizeTable _servingSizeIdTable(_$AppDatabase db) =>
      db.servingSize.createAlias($_aliasNameGenerator(
          db.consumption.servingSizeId, db.servingSize.id));

  $$ServingSizeTableProcessedTableManager get servingSizeId {
    final manager = $$ServingSizeTableTableManager($_db, $_db.servingSize)
        .filter((f) => f.id($_item.servingSizeId!));
    final item = $_typedResult.readTableOrNull(_servingSizeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ConsumptionTableFilterComposer
    extends Composer<_$AppDatabase, $ConsumptionTable> {
  $$ConsumptionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get loggedOn => $composableBuilder(
      column: $table.loggedOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MealType, MealType, int> get mealType =>
      $composableBuilder(
          column: $table.mealType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$ProductTableFilterComposer get productCode {
    final $$ProductTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productCode,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.productCode,
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
    return composer;
  }

  $$ServingSizeTableFilterComposer get servingSizeId {
    final $$ServingSizeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.servingSizeId,
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

class $$ConsumptionTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsumptionTable> {
  $$ConsumptionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get loggedOn => $composableBuilder(
      column: $table.loggedOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mealType => $composableBuilder(
      column: $table.mealType, builder: (column) => ColumnOrderings(column));

  $$ProductTableOrderingComposer get productCode {
    final $$ProductTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productCode,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.productCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableOrderingComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ServingSizeTableOrderingComposer get servingSizeId {
    final $$ServingSizeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.servingSizeId,
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

class $$ConsumptionTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsumptionTable> {
  $$ConsumptionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedOn =>
      $composableBuilder(column: $table.loggedOn, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MealType, int> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  $$ProductTableAnnotationComposer get productCode {
    final $$ProductTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productCode,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.productCode,
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
    return composer;
  }

  $$ServingSizeTableAnnotationComposer get servingSizeId {
    final $$ServingSizeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.servingSizeId,
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

class $$ConsumptionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConsumptionTable,
    ConsumptionData,
    $$ConsumptionTableFilterComposer,
    $$ConsumptionTableOrderingComposer,
    $$ConsumptionTableAnnotationComposer,
    $$ConsumptionTableCreateCompanionBuilder,
    $$ConsumptionTableUpdateCompanionBuilder,
    (ConsumptionData, $$ConsumptionTableReferences),
    ConsumptionData,
    PrefetchHooks Function({bool productCode, bool servingSizeId})> {
  $$ConsumptionTableTableManager(_$AppDatabase db, $ConsumptionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsumptionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConsumptionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConsumptionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> loggedOn = const Value.absent(),
            Value<String> productCode = const Value.absent(),
            Value<int> servingSizeId = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<MealType> mealType = const Value.absent(),
          }) =>
              ConsumptionCompanion(
            id: id,
            loggedOn: loggedOn,
            productCode: productCode,
            servingSizeId: servingSizeId,
            quantity: quantity,
            mealType: mealType,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime loggedOn,
            required String productCode,
            required int servingSizeId,
            required double quantity,
            required MealType mealType,
          }) =>
              ConsumptionCompanion.insert(
            id: id,
            loggedOn: loggedOn,
            productCode: productCode,
            servingSizeId: servingSizeId,
            quantity: quantity,
            mealType: mealType,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ConsumptionTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {productCode = false, servingSizeId = false}) {
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
                if (productCode) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productCode,
                    referencedTable:
                        $$ConsumptionTableReferences._productCodeTable(db),
                    referencedColumn: $$ConsumptionTableReferences
                        ._productCodeTable(db)
                        .productCode,
                  ) as T;
                }
                if (servingSizeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.servingSizeId,
                    referencedTable:
                        $$ConsumptionTableReferences._servingSizeIdTable(db),
                    referencedColumn:
                        $$ConsumptionTableReferences._servingSizeIdTable(db).id,
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

typedef $$ConsumptionTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConsumptionTable,
    ConsumptionData,
    $$ConsumptionTableFilterComposer,
    $$ConsumptionTableOrderingComposer,
    $$ConsumptionTableAnnotationComposer,
    $$ConsumptionTableCreateCompanionBuilder,
    $$ConsumptionTableUpdateCompanionBuilder,
    (ConsumptionData, $$ConsumptionTableReferences),
    ConsumptionData,
    PrefetchHooks Function({bool productCode, bool servingSizeId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductTableTableManager get product =>
      $$ProductTableTableManager(_db, _db.product);
  $$ServingSizeTableTableManager get servingSize =>
      $$ServingSizeTableTableManager(_db, _db.servingSize);
  $$ConsumptionTableTableManager get consumption =>
      $$ConsumptionTableTableManager(_db, _db.consumption);
}

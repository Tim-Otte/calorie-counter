import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart' as c;
import '../controllers/settings_controller.dart';
import '../extensions/all.dart';
import '../data/all.dart';
import '../tools/all.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({
    super.key,
    this.mealType,
    this.product,
    this.consumption,
  });

  final MealType? mealType;
  final ProductData? product;
  final ConsumptionEntry? consumption;

  @override
  State<StatefulWidget> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  var _servingSizes = <ServingSizeData>[];
  late MealType _mealType;
  ProductData? _product;
  double? _amount = 1;
  ServingSizeData? _selectedServingSize;

  @override
  void initState() {
    super.initState();

    final database = context.read<AppDatabase>();
    final settingsController = context.read<SettingsController>();

    if (widget.product != null) {
      _setProduct(
        database,
        settingsController,
        widget.product,
      ).whenComplete(() => setState(() {}));
      _mealType =
          widget.mealType ?? MealType.suggest(_product?.isLiquid ?? false);
    } else if (widget.consumption != null) {
      _setProduct(
        database,
        settingsController,
        widget.consumption!.product,
        selectedServingSize: widget.consumption!.servingSize,
      ).whenComplete(() => setState(() {}));
      _mealType = widget.consumption!.consumption.mealType;
      _amount = widget.consumption!.consumption.quantity;
    } else {
      throw ArgumentError('Provide at least one parameter');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final database = Provider.of<AppDatabase>(context);
    final settingsController = Provider.of<SettingsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.consumption == null
            ? localizations.addMealPageTitle
            : localizations.editMealPageTitle),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: _product == null ||
                    _selectedServingSize == null ||
                    (_amount ?? 0) <= 0
                ? null
                : () async {
                    await _saveConsumption(database, context, theme);
                  },
            icon: const Icon(Symbols.check),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Meal type selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: c.MealTypeSelector(
                initialValue: _mealType,
                onChanged: (value) => setState(() => _mealType =
                    value ?? MealType.suggest(_product?.isLiquid ?? false)),
              ),
            ),
            // Product selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: c.ProductSelector(
                initialValue: _product,
                onChanged: (value) => _setProduct(
                  database,
                  settingsController,
                  value,
                ).whenComplete(() => setState(() {})),
              ),
            ),
            // Serving size and amount
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 18,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.475,
                    child: c.FormField(
                      label: Text(localizations.servingSizeAmount),
                      icon: Symbols.numbers_rounded,
                      initialValue: _amount?.toString(),
                      onlyNumbers: true,
                      onChanged: (value) => setState(() {
                        _amount = double.tryParse(value);
                      }),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.475,
                    child: DropdownMenu(
                      label: Text(localizations.servingSizeShort),
                      dropdownMenuEntries: _servingSizes
                          .map((x) => DropdownMenuEntry(
                                value: x.id,
                                label: x.name,
                              ))
                          .toList(),
                      expandedInsets: EdgeInsets.zero,
                      initialSelection: _selectedServingSize?.id ??
                          _servingSizes.firstOrNull?.id,
                      onSelected: (id) => setState(() {
                        _selectedServingSize =
                            _servingSizes.where((x) => x.id == id).firstOrNull;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            // Nutriment information (stats)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Wrap(
                runSpacing: 20,
                children: [
                  const Divider(),
                  _getNutrimentBox(
                    theme,
                    NutrimentIcons.calories,
                    NutrimentColors.calories,
                    localizations.calories,
                    _product?.caloriesPer100Units ?? 0,
                    'kcal',
                  ),
                  _getNutrimentBox(
                    theme,
                    NutrimentIcons.carbs,
                    NutrimentColors.carbs,
                    localizations.carbs,
                    _product?.carbsPer100Units ?? 0,
                    'g',
                  ),
                  _getNutrimentBox(
                    theme,
                    NutrimentIcons.fats,
                    NutrimentColors.fats,
                    localizations.fats,
                    _product?.fatPer100Units ?? 0,
                    'g',
                  ),
                  _getNutrimentBox(
                    theme,
                    NutrimentIcons.proteins,
                    NutrimentColors.proteins,
                    localizations.proteins,
                    _product?.proteinsPer100Units ?? 0,
                    'g',
                  ),
                ],
              ),
            ),
            // Nutriment information (bars)
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              child: Card.filled(
                color: theme.colorScheme.primary.useOpacity(0.1),
                child: StreamBuilder(
                  stream: database.calculateTotalNutrimentsForToday(
                    withoutConsumptionId: widget.consumption?.consumption.id,
                  ),
                  builder: (context, nutrimentSnapshot) => Padding(
                    padding: EdgeInsets.all(15),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        Text(
                          localizations.dailyNutrimentDiagramTitle,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        _getNutrimentBar(
                          theme,
                          NutrimentIcons.calories,
                          false,
                          NutrimentColors.calories,
                          nutrimentSnapshot.data?.calories ?? 0,
                          _product?.caloriesPer100Units ?? 0,
                          settingsController.calculateTDEE(),
                        ),
                        _getNutrimentBar(
                          theme,
                          NutrimentIcons.carbs,
                          false,
                          NutrimentColors.carbs,
                          nutrimentSnapshot.data?.carbs ?? 0,
                          _product?.carbsPer100Units ?? 0,
                          settingsController.calculateMinMaxDailyCarbs().max,
                        ),
                        _getNutrimentBar(
                          theme,
                          NutrimentIcons.fats,
                          true,
                          NutrimentColors.fats,
                          nutrimentSnapshot.data?.fats ?? 0,
                          _product?.fatPer100Units ?? 0,
                          settingsController.calculateMinMaxDailyFats().max,
                        ),
                        _getNutrimentBar(
                          theme,
                          NutrimentIcons.proteins,
                          false,
                          NutrimentColors.proteins,
                          nutrimentSnapshot.data?.proteins ?? 0,
                          _product?.proteinsPer100Units ?? 0,
                          settingsController.calculateMinMaxDailyProteins().max,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setProduct(
    AppDatabase database,
    SettingsController settingsController,
    ProductData? product, {
    ServingSizeData? selectedServingSize,
  }) async {
    if (product == null) {
      _product = null;
      _servingSizes = [];
      _selectedServingSize = null;
    } else {
      _product = product;
      _servingSizes = await database.getServingSizesForProduct(
        product.productCode,
        product.isLiquid,
        settingsController.measurementUnit ?? MeasurementUnit.metric,
      );

      if (selectedServingSize != null) {
        _selectedServingSize = selectedServingSize;
      } else {
        if (_selectedServingSize != null &&
            !_servingSizes.any((x) => x.id == _selectedServingSize!.id)) {
          _selectedServingSize = _servingSizes
              .where((x) => x.baseServingSizeId != null)
              .firstOrNull;
        }
      }
    }
  }

  Future<void> _saveConsumption(
    AppDatabase database,
    BuildContext context,
    ThemeData theme,
  ) async {
    try {
      final consumption = ConsumptionTemplate.fromValues(
        mealType: _mealType,
        productCode: _product!.productCode,
        quantity: _amount!,
        servingSizeId: _selectedServingSize!.id,
      );

      if (widget.consumption != null) {
        await database.updateConsumption(
          widget.consumption!.consumption.id,
          consumption.getForInsert(),
        );
      } else {
        await database.insertConsumption(consumption.getForInsert());
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showError('Mahlzeit konnte nicht hinzugefügt werden');
      }
    }

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Widget _getNutrimentBar(
    ThemeData theme,
    IconData icon,
    bool fillIcon,
    Color color,
    double alreadyConsumed,
    double value,
    double max,
  ) {
    double consumption = value /
        100 *
        (_amount ?? 0) *
        (_selectedServingSize?.valueInBaseServingSize ?? 0);

    double total = math.max(max, consumption + alreadyConsumed);

    double alreadyConsumedPercent = alreadyConsumed / total;
    double currentConsumptionPercent = consumption / total;
    double availablePercent =
        math.max(0, 1 - (alreadyConsumedPercent + currentConsumptionPercent));

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            icon,
            color: color,
            fill: fillIcon ? 1 : 0,
          ),
        ),
        Expanded(
          child: c.SegmentedBarChart(
            gap: 2,
            gapColor: theme.colorScheme.surfaceContainer,
            tooltipBuilder: (value) => "${(value * 100).toInt()} %",
            data: [
              c.Segment(
                fractionalValue: alreadyConsumedPercent,
                color: color.useOpacity(0.5),
              ),
              c.Segment(
                fractionalValue: currentConsumptionPercent,
                color: color,
              ),
              c.Segment(
                fractionalValue: availablePercent,
                color: theme.colorScheme.surfaceDim,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _getNutrimentBox(
    ThemeData theme,
    IconData icon,
    Color color,
    String label,
    double value,
    String servingShort,
  ) {
    var valPerServing = value /
        100 *
        (_selectedServingSize?.valueInBaseServingSize ?? 0) *
        (_amount ?? 0);

    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "${valPerServing.toStringAsFixed(2)} $servingShort",
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.textTheme.bodyMedium!.color!.useOpacity(0.75),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

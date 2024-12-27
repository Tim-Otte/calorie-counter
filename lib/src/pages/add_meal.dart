import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart' as c;
import '../controllers/settings_controller.dart';
import '../extensions/all.dart';
import '../data/all.dart';

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

    if (widget.product != null) {
      _product = widget.product;
      _mealType =
          widget.mealType ?? MealType.suggest(_product?.isLiquid ?? false);
    } else if (widget.consumption != null) {
      _product = widget.consumption!.product;
      _mealType = widget.consumption!.consumption.mealType;
      _amount = widget.consumption!.consumption.quantity;
      _selectedServingSize = widget.consumption!.servingSize;
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

    if (_product != null &&
        !_servingSizes.any((x) => x.forProduct == _product!.productCode)) {
      database
          .getServingSizesForProduct(_product!.productCode)
          .then((items) => setState(() => _servingSizes = items));
    }

    if (!_servingSizes.any((x) => x.id == _selectedServingSize?.id)) {
      setState(() => _selectedServingSize = _servingSizes.firstOrNull);
    }

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
                onChanged: (value) => setState(() => _product = value),
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
                      suffixText: _selectedServingSize?.short,
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
                      initialSelection: _servingSizes.firstOrNull?.id,
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
                    Symbols.mode_heat_rounded,
                    localizations.calories,
                    _product?.caloriesPer100Units ?? 0,
                    'kcal',
                  ),
                  _getNutrimentBox(
                    theme,
                    Symbols.nutrition_rounded,
                    localizations.carbs,
                    _product?.carbsPer100Units ?? 0,
                    'g',
                  ),
                  _getNutrimentBox(
                    theme,
                    Symbols.water_drop_rounded,
                    localizations.fats,
                    _product?.fatPer100Units ?? 0,
                    'g',
                  ),
                  _getNutrimentBox(
                    theme,
                    Symbols.exercise_rounded,
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
                child: FutureBuilder(
                  future: database.calculateTotalNutrimentsForToday(
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
                          Symbols.mode_heat_rounded,
                          false,
                          const Color(0xFFFF8C00),
                          nutrimentSnapshot.data?.calories ?? 0,
                          _product?.caloriesPer100Units ?? 0,
                          settingsController.calculateMaxDailyCalories(),
                        ),
                        _getNutrimentBar(
                          theme,
                          Symbols.nutrition_rounded,
                          false,
                          const Color(0xFF32CD32),
                          nutrimentSnapshot.data?.carbs ?? 0,
                          _product?.carbsPer100Units ?? 0,
                          500,
                        ),
                        _getNutrimentBar(
                          theme,
                          Symbols.water_drop_rounded,
                          true,
                          const Color(0xFFF5D000),
                          nutrimentSnapshot.data?.fats ?? 0,
                          _product?.fatPer100Units ?? 0,
                          50,
                        ),
                        _getNutrimentBar(
                          theme,
                          Symbols.exercise_rounded,
                          false,
                          const Color(0xFF1E90FF),
                          nutrimentSnapshot.data?.proteins ?? 0,
                          _product?.proteinsPer100Units ?? 0,
                          50,
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
            color: theme.colorScheme.primary,
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

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart' as c;
import '../data/database.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({
    super.key,
    this.product,
  });

  final ProductData? product;

  @override
  State<StatefulWidget> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  var _servingSizes = <ServingSizeData>[];
  ServingSizeData? _selectedServingSize;
  ProductData? _product;
  double? _amount = 1;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final database = Provider.of<AppDatabase>(context);

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
        title: Text(localizations.addMealPageTitle),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Symbols.check),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: c.ProductSelector(
                initialValue: _product,
                onChanged: (value) => setState(() => _product = value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  Card.filled(
                    color: theme.colorScheme.surfaceContainer,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Wrap(
                            runSpacing: 10,
                            children: [
                              Text(
                                'Anteil Tagesbedarf',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              _getNutrimentBar(
                                theme: theme,
                                icon: Symbols.mode_heat_rounded,
                                color: const Color(0xFFFF8C00),
                                value: _product?.caloriesPer100Units ?? 0,
                                max: 2700,
                              ),
                              _getNutrimentBar(
                                theme: theme,
                                icon: Symbols.nutrition_rounded,
                                color: const Color(0xFF32CD32),
                                value: _product?.caloriesPer100Units ?? 0,
                                max: 500,
                              ),
                              _getNutrimentBar(
                                theme: theme,
                                icon: Symbols.water_drop_rounded,
                                fillIcon: true,
                                color: const Color.fromARGB(255, 255, 200, 0),
                                value: _product?.fatPer100Units ?? 0,
                                max: 50,
                              ),
                              _getNutrimentBar(
                                theme: theme,
                                icon: Symbols.exercise_rounded,
                                color: const Color(0xFF1E90FF),
                                value: _product?.proteinsPer100Units ?? 0,
                                max: 50,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 0,
                          child: IconButton(
                            constraints: BoxConstraints(
                              maxHeight: 30,
                              maxWidth: 30,
                            ),
                            iconSize: 15,
                            style: IconButton.styleFrom(
                              backgroundColor:
                                  theme.colorScheme.surfaceContainerHigh,
                              foregroundColor: theme.colorScheme.primary,
                            ),
                            onPressed: () async => showModalBottomSheet(
                              context: context,
                              builder: (context) => c.NutrimentBarLegend(),
                            ),
                            icon: Icon(Symbols.info_i_rounded),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getNutrimentBar({
    required ThemeData theme,
    required IconData icon,
    bool fillIcon = false,
    required Color color,
    required double value,
    required double max,
  }) {
    var willConsume = value /
        100 *
        (_selectedServingSize?.valueInBaseServingSize ?? 0) *
        (_amount ?? 0) /
        max;
    var available = math.max(0.0, 1 - willConsume);
    var alreadyConsumed = math.Random().nextDouble() * available;
    available -= alreadyConsumed;

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
                fractionalValue: alreadyConsumed,
                color: color.withOpacity(0.5),
              ),
              c.Segment(
                fractionalValue: willConsume,
                color: color,
              ),
              c.Segment(
                fractionalValue: available,
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
                  color: theme.textTheme.bodyMedium!.color!.withOpacity(0.75),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

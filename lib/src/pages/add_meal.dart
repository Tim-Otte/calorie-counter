import 'package:fl_chart/fl_chart.dart';
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
                    child: Padding(
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
                            theme,
                            Symbols.mode_heat_rounded,
                            const Color(0xFFFFD700),
                            _product?.caloriesPer100Units ?? 0,
                            2700,
                          ),
                          _getNutrimentBar(
                            theme,
                            Symbols.nutrition_rounded,
                            const Color(0xFF1E90FF),
                            _product?.caloriesPer100Units ?? 0,
                            500,
                          ),
                          _getNutrimentBar(
                            theme,
                            Symbols.water_drop_rounded,
                            const Color(0xFFFF8C00),
                            _product?.fatPer100Units ?? 0,
                            50,
                          ),
                          _getNutrimentBar(
                            theme,
                            Symbols.exercise_rounded,
                            const Color(0xFF32CD32),
                            _product?.proteinsPer100Units ?? 0,
                            50,
                          ),
                        ],
                      ),
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

  Widget _getNutrimentBar(
    ThemeData theme,
    IconData icon,
    Color color,
    double value,
    double max,
  ) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        Expanded(
          child: c.SegmentedBarChart(
            gap: 4,
            gapColor: theme.colorScheme.surfaceContainer,
            tooltipBuilder: (value) => "${(value * 100).toInt()} %",
            data: [
              c.Segment(
                fractionalValue: value /
                    100 *
                    (_selectedServingSize?.valueInBaseServingSize ?? 0) *
                    (_amount ?? 0) /
                    max,
                color: color,
              ),
              c.Segment(
                fractionalValue: 1 -
                    (value /
                        100 *
                        (_selectedServingSize?.valueInBaseServingSize ?? 0) *
                        (_amount ?? 0) /
                        max),
                color: theme.colorScheme.surfaceDim,
              )
            ],
          ),
        ),
        /* Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "${value.toInt()} / ${max.toInt()}",
            style: theme.textTheme.bodySmall,
          ),
        ), */
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

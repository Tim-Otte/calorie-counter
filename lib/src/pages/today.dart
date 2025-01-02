import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import 'all.dart' show AddMealPage, SearchProductPage;
import '../components/all.dart';
import '../controllers/settings_controller.dart';
import '../data/all.dart' show AppDatabase, ConsumptionEntry, MealType;
import '../extensions/all.dart';
import '../tools/all.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    final settingsController = Provider.of<SettingsController>(context);
    final localizations = AppLocalizations.of(context)!;
    final titleTheme = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(localizations.todayPageTitle),
            Text(
              localizations.todayPageSubtitle(DateTime.now()),
              style: titleTheme?.copyWith(
                color: titleTheme.color?.useOpacity(0.7),
              ),
            )
          ],
        ),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: StreamBuilder(
                  stream: database.calculateTotalNutrimentsForToday(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            _getNutrimentGauge(
                              context,
                              NutrimentColors.calories,
                              NutrimentIcons.calories,
                              localizations.calories,
                              snapshot.data?.calories ?? 0,
                              0,
                              settingsController.calculateTDEE(),
                              'kcal',
                            ),
                            _getNutrimentGauge(
                              context,
                              NutrimentColors.carbs,
                              NutrimentIcons.carbs,
                              localizations.carbs,
                              snapshot.data?.carbs ?? 0,
                              settingsController
                                  .calculateMinMaxDailyCarbs()
                                  .min,
                              settingsController
                                  .calculateMinMaxDailyCarbs()
                                  .max,
                              'g',
                            ),
                            _getNutrimentGauge(
                              context,
                              NutrimentColors.fats,
                              NutrimentIcons.fats,
                              localizations.fats,
                              snapshot.data?.fats ?? 0,
                              settingsController.calculateMinMaxDailyFats().min,
                              settingsController.calculateMinMaxDailyFats().max,
                              'g',
                            ),
                            _getNutrimentGauge(
                              context,
                              NutrimentColors.proteins,
                              NutrimentIcons.proteins,
                              localizations.proteins,
                              snapshot.data?.proteins ?? 0,
                              settingsController
                                  .calculateMinMaxDailyProteins()
                                  .min,
                              settingsController
                                  .calculateMinMaxDailyProteins()
                                  .max,
                              'g',
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 90,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
              ),
              ...MealType.values.map(
                (mealType) => _getConsumptionEntriesForMealType(
                  context,
                  database,
                  mealType,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getNutrimentGauge(
    BuildContext context,
    Color color,
    IconData icon,
    String label,
    double value,
    double min,
    double max,
    String unit,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FractionallySizedBox(
          widthFactor: 0.2,
          child: _getGauge(
            context,
            color,
            value,
            min,
            max,
            icon,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: textTheme.labelSmall,
        ),
        Text(
          '${value.toInt()} / ${max.toInt()} $unit',
          style: textTheme.labelSmall?.copyWith(
            color: textTheme.labelSmall?.color?.useOpacity(0.7),
          ),
          textScaler: TextScaler.linear(0.9),
        )
      ],
    );
  }

  Widget _getGauge(
    BuildContext context,
    Color color,
    double value,
    double min,
    double max,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return AnimatedRadialGauge(
      duration: const Duration(seconds: 1),
      curve: Curves.elasticOut,
      radius: 100,
      value: value,
      axis: GaugeAxis(
        min: 0,
        max: math.max(max == 0 ? 1 : max, value),
        degrees: 220,
        style: GaugeAxisStyle(
          thickness: 5,
          background: min == 0
              ? theme.colorScheme.surfaceContainerHighest
              : Colors.transparent,
          segmentSpacing: 5,
        ),
        segments: min == 0
            ? []
            : [
                GaugeSegment(
                  from: 0,
                  to: min,
                  color: theme.colorScheme.surfaceContainerHighest,
                  cornerRadius: Radius.circular(10),
                ),
                GaugeSegment(
                  from: min,
                  to: max,
                  color: theme.colorScheme.surfaceContainerHigh,
                  cornerRadius: Radius.circular(10),
                ),
              ],
        progressBar: GaugeProgressBar.rounded(
          color: color,
        ),
        pointer: null,
      ),
      builder: (context, child, value) => Icon(
        icon,
        color: color.useOpacity(0.8),
      ),
    );
  }

  IconData _getIconForMealType(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return Symbols.bakery_dining_rounded;
      case MealType.lunch:
        return Symbols.flatware_rounded;
      case MealType.dinner:
        return Symbols.grocery_rounded;
      case MealType.snack:
        return Symbols.cookie_rounded;
      case MealType.drink:
        return Symbols.local_cafe_rounded;
      case MealType.other:
        return Symbols.fork_spoon_rounded;
      default:
        throw UnsupportedError('There is no icon for the given meal type');
    }
  }

  Widget _getConsumptionEntriesForMealType(
    BuildContext context,
    AppDatabase database,
    MealType mealType,
  ) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: StreamBuilder(
        stream: database.getConsumptionEntriesForToday(mealType: mealType),
        builder: (context, consumptionSnapshot) => Card.outlined(
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: consumptionSnapshot.data?.isEmpty ?? false
                ? () => _addMealForMealType(context, mealType)
                : null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 7,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              _getIconForMealType(mealType),
                              size: 16,
                              color: theme.colorScheme.primary,
                            ),
                            Text(
                              Translator.getTranslation(context, mealType),
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Symbols.add_rounded,
                            color: theme.colorScheme.secondary,
                          ),
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.all(2.5),
                            iconSize: 20,
                            fixedSize: Size.square(25),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: () {
                            _addMealForMealType(context, mealType);
                          },
                        ),
                      ],
                    ),
                  ),
                  consumptionSnapshot.data?.isNotEmpty ?? false
                      ? ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: consumptionSnapshot.data?.length ?? 0,
                          itemBuilder: (context, index) => _getConsumptionEntry(
                            context,
                            localizations,
                            database,
                            consumptionSnapshot.data![index],
                          ),
                        )
                      : Text(
                          localizations.nothingConsumedYet,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color
                                ?.useOpacity(0.9),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addMealForMealType(BuildContext context, MealType mealType) {
    unawaited(HapticFeedback.selectionClick());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchProductPage(
          onlyLiquids: mealType == MealType.drink,
          onSelect: (product) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddMealPage(
                product: product,
                mealType: mealType,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getConsumptionEntry(
    BuildContext context,
    AppLocalizations localizations,
    AppDatabase database,
    ConsumptionEntry entry,
  ) {
    final theme = Theme.of(context);

    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          leadingIcon: Icon(
            Symbols.edit_rounded,
            color: theme.colorScheme.primary,
          ),
          child: Text(localizations.edit),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMealPage(
                consumption: entry,
              ),
            ),
          ),
        ),
        MenuItemButton(
          leadingIcon: Icon(
            Symbols.delete_rounded,
            color: theme.colorScheme.error,
          ),
          child: Text(localizations.delete),
          onPressed: () async {
            await _deleteConsumption(context, database, entry);
          },
        ),
      ],
      builder: (context, controller, child) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        visualDensity: VisualDensity.compact,
        title: Text(entry.product.name),
        subtitle: Text(entry.product.brand),
        trailing: Text(
          '${entry.consumption.quantity.toString().replaceAll(RegExp(r'[\.,]0'), '')} ${entry.servingSize.name}',
        ),
        onLongPress: () => controller.open(),
      ),
    );
  }

  Future<void> _deleteConsumption(BuildContext context, AppDatabase database,
      ConsumptionEntry entry) async {
    var result = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDeleteDialog(),
    );

    if (result == true) {
      await database.deleteConsumption(entry.consumption.id);
    }
  }
}

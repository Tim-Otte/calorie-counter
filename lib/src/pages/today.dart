import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import 'all.dart' show AddMealPage, SearchProductPage;
import '../components/all.dart';
import '../data/all.dart' show AppDatabase, ConsumptionEntry, MealType;
import '../extensions/all.dart';
import '../tools/all.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todayPageTitle),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: MealType.values
                .map(
                  (mealType) => _getConsumptionEntriesForMealType(
                    context,
                    database,
                    mealType,
                  ),
                )
                .toList(),
          ),
        ),
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
            onTap: consumptionSnapshot.data?.isEmpty ?? true
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

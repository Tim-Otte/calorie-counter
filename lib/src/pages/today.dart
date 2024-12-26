import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

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
            children: [
              MealType.breakfast,
              MealType.lunch,
              MealType.dinner,
              MealType.snack,
              MealType.drink,
              MealType.other,
            ]
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
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Icon(
                        _getIconForMealType(mealType),
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      Translator.getTranslation(context, mealType),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream:
                    database.getConsumptionEntriesForToday(mealType: mealType),
                builder: (context, consumptionSnapshot) =>
                    consumptionSnapshot.data?.isNotEmpty ?? false
                        ? ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: consumptionSnapshot.data?.length ?? 0,
                            itemBuilder: (context, index) =>
                                _getConsumptionEntry(
                              context,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getConsumptionEntry(BuildContext context, ConsumptionEntry entry) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      title: Text(entry.product.name),
      subtitle: Text(Translator.getTranslation(
        context,
        entry.consumption.mealType,
      )),
      trailing: Text(
        '${entry.consumption.quantity} ${entry.servingSize.name}',
      ),
    );
  }
}

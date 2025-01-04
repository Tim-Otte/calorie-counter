import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../all.dart';
import '../../../extensions/all.dart';

class NutrimentBarLegend extends StatelessWidget {
  const NutrimentBarLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(20).copyWith(bottom: 40),
      child: Wrap(
        runSpacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.legend,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 10),
            child: SegmentedBarChart(
              gap: 2,
              gapColor: theme.colorScheme.surface,
              data: [
                Segment(
                  fractionalValue: 1 / 3,
                  color: theme.colorScheme.primary.useOpacity(0.5),
                ),
                Segment(
                  fractionalValue: 1 / 3,
                  color: theme.colorScheme.primary,
                ),
                Segment(
                  fractionalValue: 1 / 3,
                  color: theme.colorScheme.surfaceDim,
                ),
              ],
            ),
          ),
          _getLegend(
            theme,
            theme.colorScheme.primary.useOpacity(0.5),
            localizations.alreadyConsumed,
          ),
          _getLegend(
            theme,
            theme.colorScheme.primary,
            localizations.consumptionByThisMeal,
          ),
          _getLegend(
            theme,
            theme.colorScheme.surfaceDim,
            localizations.availableForConsumption,
          ),
        ],
      ),
    );
  }

  Widget _getLegend(ThemeData theme, Color color, String label) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            color: color,
          ),
          margin: EdgeInsets.only(right: 10),
        ),
        Flexible(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
      ],
    );
  }
}

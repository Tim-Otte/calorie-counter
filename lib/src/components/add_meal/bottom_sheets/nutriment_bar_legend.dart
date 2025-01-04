import 'package:flutter/material.dart';

import '../../all.dart';

class NutrimentBarLegend extends StatelessWidget {
  const NutrimentBarLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(20),
      child: Wrap(
        runSpacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Legende',
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
                  color: theme.colorScheme.primary.withOpacity(0.5),
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
            theme.colorScheme.primary.withOpacity(0.5),
            'Bereits verbraucht',
          ),
          _getLegend(
            theme,
            theme.colorScheme.primary,
            'Verbrauch durch diese Mahlzeit',
          ),
          _getLegend(
            theme,
            theme.colorScheme.surfaceDim,
            'Kann noch verbraucht werden',
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

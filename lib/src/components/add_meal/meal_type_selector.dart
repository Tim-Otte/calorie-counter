import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../data/all.dart';
import '../../extensions/all.dart';
import '../../tools/all.dart';
import '../dialogs/all.dart';

class MealTypeSelector extends StatefulWidget {
  final MealType initialValue;
  final Function(MealType? value)? onChanged;

  const MealTypeSelector({
    super.key,
    required this.initialValue,
    this.onChanged,
  });

  @override
  State<MealTypeSelector> createState() => _MealTypeSelectorState();
}

class _MealTypeSelectorState extends State<MealTypeSelector> {
  late MealType _mealType;

  @override
  void initState() {
    super.initState();
    _mealType = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return InkWell(
      onTap: widget.onChanged == null
          ? null
          : () async {
              final result = await showDialog<MealType>(
                context: context,
                builder: (context) => EnumRadioDialog<MealType>(
                  title: localizations.mealType,
                  values: MealType.values,
                  initialValue: _mealType,
                ),
              );

              if (result != null) {
                setState(() => _mealType = result);
              }

              if (widget.onChanged != null) {
                widget.onChanged!(_mealType);
              }
            },
      highlightColor: theme.highlightColor,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Symbols.pending_actions_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${localizations.mealType}:",
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      Translator.getTranslation(context, _mealType),
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color:
                            theme.textTheme.bodyMedium!.color!.useOpacity(0.7),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const Icon(Symbols.chevron_forward_rounded),
          ],
        ),
      ),
    );
  }
}

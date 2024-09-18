import 'package:calorie_counter/src/tools/translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/measurement_unit.dart';

class MeasurementUnitDialog extends StatefulWidget {
  const MeasurementUnitDialog({super.key, required this.currentValue});

  final MeasurementUnit currentValue;

  @override
  State<StatefulWidget> createState() => _MeasurementUnitDialogState();
}

class _MeasurementUnitDialogState extends State<MeasurementUnitDialog> {
  late MeasurementUnit selectedUnit;

  void handleValueChanged(MeasurementUnit? value) {
    setState(() => selectedUnit = value ?? widget.currentValue);
  }

  @override
  void initState() {
    super.initState();
    selectedUnit = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settingMeasurementUnit),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: MeasurementUnit.values
            .map((mu) => RadioListTile<MeasurementUnit>(
                  value: mu,
                  groupValue: selectedUnit,
                  title: Text(Translator.getTranslation(context, mu)),
                  subtitle: Text(Translator.getSubtitle(context, mu)),
                  onChanged: handleValueChanged,
                ))
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text(localizations.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, selectedUnit),
          child: Text(localizations.apply),
        )
      ],
    );
  }
}

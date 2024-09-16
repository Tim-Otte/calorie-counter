import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/measurement_unit.dart';

class MeasurementUnitDialog extends StatefulWidget {
  const MeasurementUnitDialog({super.key, required this.currentValue});

  final MeasurementUnit currentValue;

  @override
  State<StatefulWidget> createState() => _MeasurementUnitDialogState();
}

class _MeasurementUnitDialogState extends State<MeasurementUnitDialog> {
  late MeasurementUnit selectedUnit;

  void handleValueChanged(MeasurementUnit? value) {
    setState(() => value ?? widget.currentValue);
  }

  @override
  void initState() {
    super.initState();
    selectedUnit = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Test'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        RadioListTile<MeasurementUnit>(
          value: MeasurementUnit.metric,
          groupValue: selectedUnit,
          title: Text(AppLocalizations.of(context)!.measurementUnitMetric),
          onChanged: handleValueChanged,
        ),
        RadioListTile<MeasurementUnit>(
          value: MeasurementUnit.imperial,
          groupValue: selectedUnit,
          title: Text(AppLocalizations.of(context)!.measurementUnitImperial),
          onChanged: handleValueChanged,
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, selectedUnit),
            child: Text('Ok'))
      ],
    );
  }
}

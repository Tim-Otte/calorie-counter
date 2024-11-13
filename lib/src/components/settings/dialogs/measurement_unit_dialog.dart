import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/enums/all.dart' show MeasurementUnit;
import '../../dialogs/all.dart' show EnumRadioDialog;

class MeasurementUnitDialog extends StatelessWidget {
  const MeasurementUnitDialog({super.key, required this.currentValue});

  final MeasurementUnit currentValue;

  @override
  Widget build(BuildContext context) {
    return EnumRadioDialog<MeasurementUnit>(
      title: AppLocalizations.of(context)!.settingMeasurementUnit,
      initialValue: currentValue,
      values: MeasurementUnit.values,
      showSubtitles: true,
    );
  }
}

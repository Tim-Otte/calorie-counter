import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/enums/measurement_unit.dart';
import '../../../tools/regular_expressions.dart';
import '../../../tools/unit_converter.dart';
import '../../dialogs/input_dialog.dart';

class WeightInputDialog extends StatelessWidget {
  const WeightInputDialog({
    super.key,
    required this.measurementUnit,
    required this.currentValue,
  });

  final MeasurementUnit measurementUnit;
  final double currentValue;

  double? getValueFromInput(bool isMetric, String? textInput) {
    if (textInput != null && textInput.isNotEmpty) {
      var value = double.tryParse(textInput);

      if (value == null) return null;

      if (isMetric) {
        return value;
      } else {
        return UnitConverter.weightToMetric(value);
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isMetric = measurementUnit == MeasurementUnit.metric;
    String initialValue;

    if (isMetric) {
      initialValue = currentValue.toStringAsFixed(1);
    } else {
      var imperial = UnitConverter.weightToImperial(currentValue);
      initialValue = imperial.toStringAsFixed(1);
    }

    return TextInputDialog<double>(
      title: localizations.settingWeight,
      allowedCharactersExp: RegularExpressions.weightAllowedCharacters,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      initialValue: initialValue,
      inputValidatorExpr: RegularExpressions.weightInputValidator,
      valueConverter: (text) => getValueFromInput(isMetric, text),
      suffixText: isMetric ? 'kg' : 'lbs',
    );
  }
}

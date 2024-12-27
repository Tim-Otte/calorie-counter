import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/enums/all.dart' show MeasurementUnit;
import '../../../tools/all.dart';
import '../../dialogs/all.dart' show TextInputDialog;

class HeightInputDialog extends StatelessWidget {
  const HeightInputDialog({
    super.key,
    required this.measurementUnit,
    required this.currentValue,
  });

  final MeasurementUnit measurementUnit;
  final double currentValue;

  double? getValueFromInput(bool isMetric, String? textInput) {
    if (textInput != null && textInput.isNotEmpty) {
      if (isMetric) {
        return double.tryParse(textInput);
      } else {
        var match = RegularExpressions.getHeightInputValidator(false)
            .firstMatch(textInput)!;

        double feet = double.parse(match.group(1)!);
        double inches = double.parse(match.group(2)!);

        return UnitConverter.heightToMetric(feet, inches);
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
      initialValue = currentValue.round().toString();
    } else {
      var imperial = UnitConverter.heightToImperial(currentValue);
      initialValue = "${imperial.feet.round()}' ${imperial.inches.round()}\"";
    }

    return TextInputDialog<double>(
      title: localizations.profileHeight,
      allowedCharactersExp:
          RegularExpressions.getHeightAllowedCharacters(isMetric),
      keyboardType: isMetric ? TextInputType.number : TextInputType.text,
      initialValue: initialValue,
      inputValidatorExpr: RegularExpressions.getHeightInputValidator(isMetric),
      valueConverter: (text) => getValueFromInput(isMetric, text),
      suffixText: isMetric ? 'cm' : 'ft/in',
    );
  }
}

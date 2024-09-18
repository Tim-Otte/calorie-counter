import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/measurement_unit.dart';
import '../../../tools/unit_converter.dart';

class HeightInputDialog extends StatefulWidget {
  const HeightInputDialog(
      {super.key, required this.measurementUnit, required this.currentValue});

  final MeasurementUnit measurementUnit;
  final double currentValue;

  @override
  State<StatefulWidget> createState() => _HeightInputDialogState();
}

class _HeightInputDialogState extends State<HeightInputDialog> {
  double? height;
  late bool isMetric = true;
  late bool isValidInput = false;
  late String initialValue;

  final _formKey = GlobalKey<FormState>();
  final metricInputValidatorExpr = RegExp("^[0-9]{2,3}\$");
  final imperialInputValidatorExpr =
      RegExp("^([1-9])'\\s?(?:((?:0?[0-9])|(?:1[0-1]))\")?\$");

  bool validateInput(String? textInput) {
    if (textInput == null || textInput.isEmpty) return false;

    if (isMetric) {
      return metricInputValidatorExpr.hasMatch(textInput);
    } else {
      return imperialInputValidatorExpr.hasMatch(textInput);
    }
  }

  double? getValueFromInput(String? textInput) {
    if (textInput != null && textInput.isNotEmpty) {
      if (isMetric) {
        return double.tryParse(textInput);
      } else {
        var match = imperialInputValidatorExpr.firstMatch(textInput)!;
        double feet = double.parse(match.group(1)!);
        double inches = double.parse(match.group(2)!);

        return UnitConverter.heightToMetric(feet, inches);
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    isMetric = widget.measurementUnit == MeasurementUnit.metric;

    if (isMetric) {
      initialValue = widget.currentValue.round().toString();
    } else {
      var imperial = UnitConverter.heightToImperial(widget.currentValue);
      initialValue = "${imperial.feet.round()}' ${imperial.inches.round()}\"";
    }
    isValidInput = validateInput(initialValue);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final metricInputExpr = RegExp("[0-9]");
    final imperialInputExpr = RegExp("[0-9'\"\\s]");

    return AlertDialog(
      title: Text(localizations.settingHeight),
      content: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: isMetric ? TextInputType.number : TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                isMetric ? metricInputExpr : imperialInputExpr)
          ],
          initialValue: initialValue,
          decoration: InputDecoration(
            suffixText: isMetric ? 'cm' : 'ft/in',
          ),
          onChanged: (value) => setState(() {
            isValidInput = validateInput(value);
            height = isValidInput ? getValueFromInput(value) : null;
          }),
          validator: (value) {
            if (!validateInput(value)) {
              return localizations.validationErrorInvalidInput;
            }

            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text(localizations.cancel),
        ),
        TextButton(
          onPressed: isValidInput ? () => Navigator.pop(context, height) : null,
          child: Text(localizations.apply),
        )
      ],
    );
  }
}

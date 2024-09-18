import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

import '../../../models/measurement_unit.dart';
import '../../../tools/unit_converter.dart';

class WeightInputDialog extends StatefulWidget {
  const WeightInputDialog(
      {super.key, required this.measurementUnit, required this.currentValue});

  final MeasurementUnit measurementUnit;
  final double currentValue;

  @override
  State<StatefulWidget> createState() => _WeightInputDialogState();
}

class _WeightInputDialogState extends State<WeightInputDialog> {
  double? weight;
  late bool isMetric = true;
  late bool isValidInput = false;
  late String initialValue;
  late RegExp weightInputValidatorExpr =
      RegExp("^((?:(?:[1-5][0-9])|(?:[1-9]))[0-9](?:[.][0-9])?)\$");

  final _formKey = GlobalKey<FormState>();

  bool validateInput(String? textInput) {
    return textInput != null &&
        textInput.isNotEmpty &&
        weightInputValidatorExpr.hasMatch(textInput);
  }

  double? getValueFromInput(String? textInput) {
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
  void initState() {
    super.initState();
    isMetric = widget.measurementUnit == MeasurementUnit.metric;

    if (isMetric) {
      initialValue = widget.currentValue.toStringAsFixed(1);
    } else {
      var imperial = UnitConverter.weightToImperial(widget.currentValue);
      initialValue = imperial.toStringAsFixed(1);
    }
    isValidInput = validateInput(initialValue);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final decimalSeparator =
        numberFormatSymbols[localizations.localeName]?.DECIMAL_SEP ?? ".";
    final inputExpr = RegExp("[0-9.$decimalSeparator]");
    weightInputValidatorExpr = RegExp(
        "^((?:(?:[1-5][0-9])|(?:[1-9]))[0-9](?:[.$decimalSeparator][0-9])?)\$");

    return AlertDialog(
      title: Text(localizations.settingWeight),
      content: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(inputExpr)],
          initialValue: initialValue,
          decoration: InputDecoration(
            suffixText: isMetric ? 'kg' : 'lbs',
          ),
          onChanged: (value) => setState(() {
            isValidInput = validateInput(value);
            weight = isValidInput ? getValueFromInput(value) : null;
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
          onPressed: isValidInput ? () => Navigator.pop(context, weight) : null,
          child: Text(localizations.apply),
        )
      ],
    );
  }
}

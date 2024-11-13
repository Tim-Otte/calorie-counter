import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tools/all.dart';

class FormField extends StatelessWidget {
  final Widget label;
  final IconData? icon;
  final String? initialValue;
  final String? suffixText;
  final bool? onlyNumbers;
  final bool? enableNextButton;
  final Function(String value)? onChanged;

  const FormField({
    super.key,
    required this.label,
    this.icon,
    this.initialValue,
    this.suffixText,
    this.onlyNumbers,
    this.enableNextButton,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool allowOnlyNumbers = onlyNumbers ?? false;

    return TextFormField(
      decoration: InputDecoration(
        label: label,
        border: const OutlineInputBorder(),
        icon: icon == null ? null : Icon(icon),
        iconColor: icon == null ? null : Theme.of(context).colorScheme.primary,
        suffixText: suffixText,
      ),
      keyboardType: allowOnlyNumbers
          ? const TextInputType.numberWithOptions(decimal: true)
          : null,
      inputFormatters: allowOnlyNumbers
          ? [
              FilteringTextInputFormatter.allow(
                  RegularExpressions.decimalAllowedCharacters),
            ]
          : null,
      textInputAction: (enableNextButton ?? false)
          ? TextInputAction.next
          : TextInputAction.done,
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: onChanged == null,
    );
  }
}

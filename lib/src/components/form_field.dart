import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/all.dart';
import '../tools/all.dart';

class FormField extends StatelessWidget {
  final Widget label;
  final IconData? icon;
  final String? initialValue;
  final String? suffixText;
  final String? hintText;
  final bool? onlyNumbers;
  final bool? enableNextButton;
  final Function(String value)? onChanged;

  const FormField({
    super.key,
    required this.label,
    this.icon,
    this.initialValue,
    this.suffixText,
    this.hintText,
    this.onlyNumbers,
    this.enableNextButton,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    bool allowOnlyNumbers = onlyNumbers ?? false;

    return hintText != null
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              _getTextField(context, allowOnlyNumbers),
              Positioned(
                right: 8,
                bottom: -6,
                child: Container(
                  color: theme.scaffoldBackgroundColor,
                  child: Text(
                    " $hintText ",
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.textTheme.bodySmall!.color!.useOpacity(0.75),
                    ),
                  ),
                ),
              ),
            ],
          )
        : _getTextField(context, allowOnlyNumbers);
  }

  TextFormField _getTextField(BuildContext context, bool allowOnlyNumbers) {
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

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputDialog<T> extends StatefulWidget {
  const TextInputDialog({
    super.key,
    required this.title,
    required this.allowedCharactersExp,
    required this.keyboardType,
    required this.initialValue,
    required this.inputValidatorExpr,
    required this.valueConverter,
    this.suffixText,
  });

  final String title;
  final RegExp allowedCharactersExp;
  final TextInputType keyboardType;
  final String initialValue;
  final RegExp inputValidatorExpr;
  final T? Function(String text) valueConverter;
  final String? suffixText;

  @override
  State<StatefulWidget> createState() => _TextInputDialogState<T>();
}

class _TextInputDialogState<T> extends State<TextInputDialog> {
  late T? currentValue;
  late bool isValidInput = false;
  final _formKey = GlobalKey<FormState>();

  bool validateInput(String? textInput) {
    return textInput != null &&
        textInput.isNotEmpty &&
        widget.inputValidatorExpr.hasMatch(textInput);
  }

  @override
  void initState() {
    super.initState();
    isValidInput = validateInput(widget.initialValue);
    if (isValidInput) {
      currentValue = widget.valueConverter.call(widget.initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(widget.allowedCharactersExp)
          ],
          initialValue: widget.initialValue,
          decoration: widget.suffixText != null && widget.suffixText!.isNotEmpty
              ? InputDecoration(suffixText: widget.suffixText)
              : null,
          onChanged: (value) => setState(() {
            isValidInput = validateInput(value);
            currentValue =
                isValidInput ? widget.valueConverter.call(value) : null;
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
          onPressed:
              isValidInput ? () => Navigator.pop(context, currentValue) : null,
          child: Text(localizations.apply),
        )
      ],
    );
  }
}

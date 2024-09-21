import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../tools/translator.dart';

class RadioDialog<TEnum> extends StatefulWidget {
  const RadioDialog({
    super.key,
    required this.title,
    required this.values,
    required this.initialValue,
    this.showSubtitles = false,
  });

  final String title;
  final List<TEnum> values;
  final TEnum initialValue;
  final bool showSubtitles;

  @override
  State<RadioDialog> createState() => _RadioDialogState<TEnum>();
}

class _RadioDialogState<TEnum> extends State<RadioDialog> {
  late TEnum? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.values
            .map((enumValue) => RadioListTile<TEnum>(
                  value: enumValue,
                  groupValue: selectedValue,
                  title: Text(Translator.getTranslation(context, enumValue)),
                  subtitle: widget.showSubtitles
                      ? Text(Translator.getSubtitle(context, enumValue))
                      : null,
                  onChanged: (v) => setState(() => selectedValue = v),
                ))
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text(localizations.cancel),
        ),
        TextButton(
          onPressed: selectedValue != null
              ? () => Navigator.pop(context, selectedValue)
              : null,
          child: Text(localizations.apply),
        )
      ],
    );
  }
}

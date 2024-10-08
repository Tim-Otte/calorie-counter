import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef StringResolver<T> = String Function(T value);

class RadioDialog<T> extends StatefulWidget {
  const RadioDialog({
    super.key,
    required this.title,
    required this.values,
    required this.initialValue,
    required this.getTitle,
    this.getSubtitle,
  });

  final String title;
  final List<T> values;
  final T initialValue;
  final String Function(T) getTitle;
  final String Function(T)? getSubtitle;

  @override
  State<RadioDialog> createState() => _RadioDialogState<T>();
}

class _RadioDialogState<T> extends State<RadioDialog<T>> {
  late T? selectedValue;

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
            .map((enumValue) => RadioListTile<T>(
                  value: enumValue,
                  groupValue: selectedValue,
                  title: Text(widget.getTitle(enumValue)),
                  subtitle: widget.getSubtitle != null
                      ? Text(widget.getSubtitle!(enumValue))
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

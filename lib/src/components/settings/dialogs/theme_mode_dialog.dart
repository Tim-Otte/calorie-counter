import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../tools/translator.dart';

class ThemeModeDialog extends StatefulWidget {
  const ThemeModeDialog({super.key, required this.currentValue});

  final ThemeMode currentValue;

  @override
  State<StatefulWidget> createState() => _ThemeModeDialogState();
}

class _ThemeModeDialogState extends State<ThemeModeDialog> {
  late ThemeMode selectedTheme;

  void handleValueChanged(ThemeMode? value) {
    setState(() => selectedTheme = value ?? widget.currentValue);
  }

  @override
  void initState() {
    super.initState();
    selectedTheme = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settingTheme),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ThemeMode.values
            .map((tm) => RadioListTile<ThemeMode>(
                  value: tm,
                  groupValue: selectedTheme,
                  title: Text(Translator.getTranslation(context, tm)),
                  onChanged: handleValueChanged,
                ))
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text(localizations.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, selectedTheme),
          child: Text(localizations.apply),
        )
      ],
    );
  }
}

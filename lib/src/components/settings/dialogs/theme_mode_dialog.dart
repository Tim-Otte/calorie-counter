import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'radio_dialog.dart';

class ThemeModeDialog extends StatelessWidget {
  const ThemeModeDialog({super.key, required this.currentValue});

  final ThemeMode currentValue;

  @override
  Widget build(BuildContext context) {
    return RadioDialog<ThemeMode>(
      title: AppLocalizations.of(context)!.settingTheme,
      initialValue: currentValue,
      values: ThemeMode.values,
      showSubtitles: false,
    );
  }
}

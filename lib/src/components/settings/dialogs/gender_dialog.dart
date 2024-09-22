import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/enums/gender.dart';
import '../../dialogs/radio_dialog.dart';

class GenderDialog extends StatelessWidget {
  const GenderDialog({super.key, required this.currentValue});

  final Gender currentValue;

  @override
  Widget build(BuildContext context) {
    return RadioDialog<Gender>(
      title: AppLocalizations.of(context)!.settingGender,
      initialValue: currentValue,
      values: Gender.values,
      showSubtitles: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/enums/all.dart' show Gender;
import '../../dialogs/all.dart';

class GenderDialog extends StatelessWidget {
  const GenderDialog({super.key, required this.currentValue});

  final Gender currentValue;

  @override
  Widget build(BuildContext context) {
    return EnumRadioDialog<Gender>(
      title: AppLocalizations.of(context)!.settingGender,
      initialValue: currentValue,
      values: Gender.values,
      showSubtitles: false,
    );
  }
}

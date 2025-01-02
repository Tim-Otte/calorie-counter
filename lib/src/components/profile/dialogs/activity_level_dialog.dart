import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/enums/all.dart' show ActivityLevel;
import '../../dialogs/all.dart';

class ActivityLevelDialog extends StatelessWidget {
  const ActivityLevelDialog({super.key, required this.currentValue});

  final ActivityLevel currentValue;

  @override
  Widget build(BuildContext context) {
    return EnumRadioDialog<ActivityLevel>(
      title: AppLocalizations.of(context)!.profileActivityLevel,
      initialValue: currentValue,
      values: ActivityLevel.values,
      showSubtitles: false,
    );
  }
}

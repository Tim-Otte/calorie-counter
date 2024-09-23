import 'package:calorie_counter/src/components/dialogs/radio_dialog.dart';
import 'package:flutter/material.dart';

import '../../tools/translator.dart';

class EnumRadioDialog<TEnum> extends StatelessWidget {
  const EnumRadioDialog({
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
  Widget build(BuildContext context) {
    return RadioDialog<TEnum>(
      title: title,
      values: values,
      initialValue: initialValue,
      getTitle: (value) => Translator.getTranslation(context, value),
      getSubtitle: showSubtitles
          ? (value) => Translator.getSubtitle(context, value)
          : null,
    );
  }
}

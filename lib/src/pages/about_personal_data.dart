import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPersonalDataPage extends StatelessWidget {
  const AboutPersonalDataPage({super.key});

  Widget getParagraph(
    ThemeData theme,
    AppLocalizations localizations,
    String title,
    String body, {
    bool showPadding = true,
  }) {
    return Padding(
      padding: showPadding
          ? const EdgeInsets.only(bottom: 30)
          : const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.primary),
          ),
          Text(body, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.aboutPersonalDataTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getParagraph(
                theme,
                localizations,
                localizations.aboutPersonalDataGenderTitle,
                localizations.aboutPersonalDataGenderBody,
              ),
              getParagraph(
                theme,
                localizations,
                localizations.aboutPersonalDataAgeTitle,
                localizations.aboutPersonalDataAgeBody,
              ),
              getParagraph(
                theme,
                localizations,
                localizations.aboutPersonalDataWeightHeightWaistTitle,
                localizations.aboutPersonalDataWeightHeightWaistBody,
                showPadding: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

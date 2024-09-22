import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPersonalDataBtmSheet extends StatelessWidget {
  const AboutPersonalDataBtmSheet({super.key});

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

    return DraggableScrollableSheet(
      expand: false,
      snap: true,
      initialChildSize: 0.3,
      minChildSize: 0.3,
      maxChildSize: 0.75,
      builder: (context, controller) => SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  localizations.aboutPersonalDataTitle,
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
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
                localizations.aboutPersonalDataWeightHeightTitle,
                localizations.aboutPersonalDataWeightHeightBody,
                showPadding: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

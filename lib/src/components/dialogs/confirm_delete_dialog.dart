import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(localizations.confirmDeleteTitle),
      content: Text(localizations.confirmDeleteText),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(localizations.no),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.error,
          ),
          child: Text(localizations.yes),
        ),
      ],
    );
  }
}

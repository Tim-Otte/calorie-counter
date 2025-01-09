import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../components/all.dart' as c;

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<StatefulWidget> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.addRecipePageTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Wrap(
            runSpacing: 20,
            children: [
              Text(
                localizations.recipeInformationTitle,
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.primary),
              ),
              c.FormField(
                label: Text(localizations.recipeName),
                icon: Symbols.label_rounded,
                initialValue: '',
                enableNextButton: true,
                onChanged: (value) => setState(() {}),
              ),
              c.FormField(
                label: Text(localizations.totalServingQty),
                icon: Symbols.pin_rounded,
                initialValue: '',
                onChanged: (value) => setState(() {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

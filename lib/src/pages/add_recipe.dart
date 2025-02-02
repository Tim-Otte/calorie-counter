import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../components/all.dart' as c;
import '../data/all.dart' show RecipeIngredientTemplate;
import '../extensions/all.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<StatefulWidget> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  String _recipeName = '';
  int _totalServings = 4;
  List<RecipeIngredientTemplate> _ingredients = [];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.addRecipePageTitle),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 100,
        child: BottomAppBar(
          elevation: 1,
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  var result =
                      await showModalBottomSheet<RecipeIngredientTemplate>(
                    context: context,
                    builder: (context) =>
                        c.IngredientBtmSheet(isEditMode: false),
                    isScrollControlled: true,
                    useSafeArea: true,
                  );
                  if (result != null) {
                    setState(() => _ingredients.add(result));
                  }
                },
                icon: Icon(Symbols.format_list_bulleted_add_rounded),
                tooltip: localizations.addIngredientTooltip,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _recipeName.isNotEmpty &&
                _totalServings > 0 &&
                _ingredients.isNotEmpty
            ? () async {}
            : null,
        icon: Icon(Symbols.save_rounded),
        label: Text(localizations.save),
        elevation: 0,
        backgroundColor: theme.colorScheme.secondaryContainer.useOpacity(
            _recipeName.isNotEmpty &&
                    _totalServings > 0 &&
                    _ingredients.isNotEmpty
                ? 1
                : 0.6),
        foregroundColor: theme.colorScheme.onSecondaryContainer.useOpacity(
            _recipeName.isNotEmpty &&
                    _totalServings > 0 &&
                    _ingredients.isNotEmpty
                ? 1
                : 0.6),
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
                initialValue: _recipeName,
                enableNextButton: true,
                onChanged: (value) => setState(() => _recipeName = value),
              ),
              c.FormField(
                label: Text(localizations.totalServingQty),
                icon: Symbols.pin_rounded,
                initialValue: _totalServings.toString(),
                onlyNumbers: true,
                onlyWholeNumbers: true,
                onChanged: (value) {
                  final totalServings = int.tryParse(value);

                  if (totalServings != null) {
                    setState(() => _totalServings = totalServings);
                  }
                },
              ),
              const Divider(),
              Text(
                localizations.ingredients,
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.primary),
              ),
              _ingredients.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        localizations.ingredientsEmpty,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium!.color
                                ?.useOpacity(0.7)),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _ingredients.length,
                      itemBuilder: (context, index) {
                        final item = _ingredients[index];

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            item.product!.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(item.product!.brand),
                          trailing: Text(
                              '${item.quantity} ${item.servingSize!.name}'),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

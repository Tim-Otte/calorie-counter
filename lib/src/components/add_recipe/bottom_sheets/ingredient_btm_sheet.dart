import 'package:calorie_counter/src/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../../data/database.dart';
import '../../../data/models/all.dart' show RecipeIngredientTemplate;
import '../../all.dart' as c;

typedef SearchItem = ({String label, String barcode});

class IngredientBtmSheet extends StatefulWidget {
  final RecipeIngredientTemplate? initialValue;
  final bool isEditMode;

  const IngredientBtmSheet({
    super.key,
    this.initialValue,
    required this.isEditMode,
  });

  @override
  State<IngredientBtmSheet> createState() => _IngredientBtmSheetState();
}

class _IngredientBtmSheetState extends State<IngredientBtmSheet> {
  var _data = RecipeIngredientTemplate();
  var _servingSizes = <ServingSizeData>[];

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      _data = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final database = Provider.of<AppDatabase>(context);
    final settingsController = Provider.of<SettingsController>(context);

    return Padding(
      padding: EdgeInsets.all(20)
          .copyWith(bottom: 20 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 20,
            children: [
              Text(
                widget.isEditMode
                    ? localizations.editIngredientTitle
                    : localizations.addIngredientTitle,
                style: theme.textTheme.headlineSmall,
              ),
              c.IngredientSelector(
                initialValue: _data.product,
                onChanged: (product) {
                  if (product != null) {
                    setState(() => _data.product = product);
                    database
                        .getServingSizesForProduct(
                            product.productCode,
                            product.isLiquid,
                            settingsController.measurementUnit)
                        .then((servingSizes) =>
                            setState(() => _servingSizes = servingSizes));
                  }
                },
              ),
              FractionallySizedBox(
                widthFactor: 0.375,
                child: c.FormField(
                  label: Text(localizations.servingSizeAmount),
                  initialValue: _data.quantity.toString(),
                  onlyNumbers: true,
                  enableNextButton: true,
                  onChanged: _data.product == null
                      ? null
                      : (value) {
                          var num = double.tryParse(value);
                          if (num != null) {
                            _data.quantity = num;
                          }
                        },
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.575,
                child: DropdownMenu(
                  dropdownMenuEntries: _servingSizes
                      .map((el) => DropdownMenuEntry(
                            value: el.id,
                            label: el.name,
                          ))
                      .toList(),
                  label: Text(localizations.servingSize),
                  initialSelection:
                      _servingSizes.any((x) => x.id == _data.servingSize?.id)
                          ? _data.servingSize?.id
                          : _servingSizes.firstOrNull?.id,
                  onSelected: _data.product == null
                      ? null
                      : (value) {
                          if (value != null) {
                            setState(() => _data.servingSize =
                                _servingSizes.firstWhere((x) => x.id == value));
                          }
                        },
                  expandedInsets: EdgeInsets.zero,
                  enabled: _data.product != null,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton.icon(
                    onPressed: () => Navigator.pop(context, _data),
                    label: Text(localizations.save),
                    icon: Icon(Symbols.save_rounded),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../controllers/settings_controller.dart';
import '../../data/all.dart';
import '../../extensions/all.dart';
import '../../tools/all.dart';
import '../all.dart' as c;

class ProductForm extends StatefulWidget {
  final ProductTemplate product;
  final List<ServingSizeTemplate> customServingSizes;
  final List<ServingSizeData> baseServingSizes;
  final ScrollController scrollController;
  final Function(
    ProductTemplate product,
    List<ServingSizeTemplate> servingSizes,
  ) onChange;

  const ProductForm({
    super.key,
    required this.product,
    required this.customServingSizes,
    required this.baseServingSizes,
    required this.scrollController,
    required this.onChange,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  late ProductTemplate _product;
  late List<ServingSizeTemplate> _servingSizes;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    _servingSizes = widget.customServingSizes;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final settingsController = Provider.of<SettingsController>(context);

    bool isImperial =
        settingsController.measurementUnit == MeasurementUnit.imperial;

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Wrap(
              runSpacing: 20,
              children: [
                Text(
                  localizations.productInformationTitle,
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.primary),
                ),
                c.FormField(
                  label: Text(localizations.productCode),
                  icon: Symbols.barcode_rounded,
                  initialValue: _product.productCode,
                  enableNextButton: true,
                  onChanged: (value) => setState(() {
                    _product.productCode = value;
                    widget.onChange(_product, _servingSizes);
                  }),
                ),
                c.FormField(
                  label: Text(localizations.productName),
                  icon: Symbols.label_rounded,
                  initialValue: _product.name,
                  enableNextButton: true,
                  onChanged: (value) => setState(() {
                    _product.name = value;
                    widget.onChange(_product, _servingSizes);
                  }),
                ),
                c.FormField(
                  label: Text(localizations.brand),
                  icon: Symbols.store_rounded,
                  initialValue: _product.brand,
                  enableNextButton: true,
                  onChanged: (value) => setState(() {
                    _product.brand = value;
                    widget.onChange(_product, _servingSizes);
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: InkWell(
              onTap: () => _toggleIsLiquid(context, localizations, theme, null),
              highlightColor: theme.highlightColor,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(
                            Symbols.emoji_food_beverage_rounded,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.isLiquid,
                              style: theme.textTheme.bodyLarge,
                            ),
                            Text(
                              _product.isLiquid
                                  ? localizations.isLiquid_true
                                  : localizations.isLiquid_false,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: theme.textTheme.bodyMedium!.color!
                                      .useOpacity(0.75)),
                            )
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: _product.isLiquid,
                      onChanged: (value) =>
                          _toggleIsLiquid(context, localizations, theme, value),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              runSpacing: 20,
              children: [
                const Divider(),
                Text(
                  localizations.nutritionalInformationPerServingTitle,
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.primary),
                ),
                c.FormField(
                  label: Text(localizations.calories),
                  icon: Symbols.mode_heat_rounded,
                  suffixText: "kcal",
                  onlyNumbers: true,
                  initialValue: _product.caloriesPer100?.toString() ?? '',
                  enableNextButton: true,
                  onChanged: (value) => setState(() {
                    _product.caloriesPer100 = double.tryParse(value);
                    widget.onChange(_product, _servingSizes);
                  }),
                ),
                c.FormField(
                  label: Text(localizations.carbs),
                  icon: Symbols.nutrition_rounded,
                  suffixText: "g",
                  hintText: isImperial && _product.carbsPer100 != null
                      ? localizations.equalsNOz(
                          UnitConverter.gramsToOunzes(_product.carbsPer100!))
                      : null,
                  onlyNumbers: true,
                  initialValue: _product.carbsPer100?.toString() ?? '',
                  enableNextButton: true,
                  onChanged: (value) => setState(() {
                    _product.carbsPer100 = double.tryParse(value);
                    widget.onChange(_product, _servingSizes);
                  }),
                ),
                c.FormField(
                  label: Text(localizations.fats),
                  icon: Symbols.water_drop_rounded,
                  suffixText: "g",
                  hintText: isImperial && _product.fatsPer100 != null
                      ? localizations.equalsNOz(
                          UnitConverter.gramsToOunzes(_product.fatsPer100!))
                      : null,
                  onlyNumbers: true,
                  initialValue: _product.fatsPer100?.toString() ?? '',
                  enableNextButton: true,
                  onChanged: (value) => setState(() {
                    _product.fatsPer100 = double.tryParse(value);
                    widget.onChange(_product, _servingSizes);
                  }),
                ),
                c.FormField(
                  label: Text(localizations.proteins),
                  icon: Symbols.exercise_rounded,
                  suffixText: "g",
                  hintText: isImperial && _product.proteinsPer100 != null
                      ? localizations.equalsNOz(
                          UnitConverter.gramsToOunzes(_product.proteinsPer100!))
                      : null,
                  onlyNumbers: true,
                  initialValue: _product.proteinsPer100?.toString() ?? '',
                  onChanged: (value) => setState(() {
                    _product.proteinsPer100 = double.tryParse(value);
                    widget.onChange(_product, _servingSizes);
                  }),
                ),
                const Divider(),
                Text(
                  localizations.customServingSizesTitle,
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.primary),
                ),
                _servingSizes.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(Symbols.no_meals_rounded),
                            ),
                            Text(localizations.customServingSizesEmpty)
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _servingSizes.length,
                        itemBuilder: (context, index) {
                          var item = _servingSizes[index];
                          return ListTile(
                            leading: Icon(Symbols.restaurant_rounded),
                            title: Text(item.name),
                            subtitle: Text(
                                "${item.amount} ${widget.baseServingSizes.where((el) => el.id == item.baseServingSize).first.short}"),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                  onPressed: () async => _editServingSize(item),
                                  icon: Icon(Symbols.edit_rounded),
                                  tooltip: localizations.edit,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    var result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) =>
                                          c.ConfirmDeleteDialog(),
                                    );
                                    if (result == true) {
                                      setState(() {
                                        _servingSizes.removeAt(index);
                                        widget.onChange(
                                            _product, _servingSizes);
                                      });
                                    }
                                  },
                                  icon: Icon(Symbols.delete_rounded),
                                  color: theme.colorScheme.error,
                                  tooltip: localizations.delete,
                                ),
                              ],
                            ),
                            contentPadding: EdgeInsets.all(0),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleIsLiquid(
    BuildContext context,
    AppLocalizations localizations,
    ThemeData theme,
    bool? value,
  ) {
    var newValue = value ?? !_product.isLiquid;
    setState(() => _product.isLiquid = newValue);

    var incompatibleUnitExists = _servingSizes
        .map((x) => widget.baseServingSizes
            .where((y) => y.id == x.baseServingSize)
            .first)
        .any((x) => x.isLiquid != newValue);

    if (incompatibleUnitExists) {
      ScaffoldMessenger.of(context)
          .showError(localizations.toastPleaseUpdateCustomServingSizes);
    }
  }

  Future<void> _editServingSize(ServingSizeTemplate servingSize) async {
    var result = await showModalBottomSheet<ServingSizeTemplate>(
      context: context,
      builder: (context) => c.ServingSizeBtmSheet(
        isEditMode: false,
        baseServingSizes: widget.baseServingSizes,
        initialValue: servingSize,
      ),
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: false,
      enableDrag: false,
    );

    if (result != null) {
      var index = _servingSizes.indexOf(servingSize);
      setState(() {
        _servingSizes[index] = result;
        widget.onChange(_product, _servingSizes);
      });
    }
  }
}

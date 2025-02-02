import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../data/database.dart';
import '../../extensions/all.dart';
import '../../pages/all.dart';

class ProductSelector extends StatefulWidget {
  final ProductData? initialValue;
  final Function(ProductData? value)? onChanged;

  const ProductSelector({
    super.key,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<ProductSelector> createState() => _ProductSelectorState();
}

class _ProductSelectorState extends State<ProductSelector> {
  ProductData? _product;

  @override
  void initState() {
    super.initState();
    _product = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return InkWell(
      onTap: widget.onChanged == null
          ? null
          : () async {
              ProductData? result = await context.navigateTo(
                (_) => SearchProductOrRecipePage(),
              );
              setState(() => _product = result);
              if (widget.onChanged != null) {
                widget.onChanged!(_product);
              }
            },
      highlightColor: theme.highlightColor,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Symbols.list_alt_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${localizations.product}:",
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      _product != null
                          ? "${_product!.name} (${_product!.brand})"
                          : localizations.notSet,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color:
                            theme.textTheme.bodyMedium!.color!.useOpacity(0.7),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const Icon(Symbols.chevron_forward_rounded),
          ],
        ),
      ),
    );
  }
}

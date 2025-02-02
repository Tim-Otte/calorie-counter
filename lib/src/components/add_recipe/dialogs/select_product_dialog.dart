import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../all.dart' show SearchProduct;

class SelectProductDialog extends StatelessWidget {
  const SelectProductDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.selectIngredientTitle),
        ),
        body: SearchProduct(
          onlyFavourites: true,
          onSelect: (product) => Navigator.of(context).pop(product),
        ),
      ),
    );
  }
}

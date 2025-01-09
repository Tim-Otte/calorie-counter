import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:openfoodfacts/openfoodfacts.dart' as openfoodfacts;
import 'package:provider/provider.dart';

import '../../data/all.dart';
import '../../extensions/all.dart';
import '../../pages/all.dart' show AddProductPage;
import '../../services/all.dart';

class OpenFoodFactsList extends StatelessWidget {
  final List<ServingSizeData> baseServingSizes;
  final List<openfoodfacts.Product> items;
  final Function(ProductData product) onSelect;

  const OpenFoodFactsList({
    super.key,
    required this.baseServingSizes,
    required this.items,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foodFactService = Provider.of<FoodFactService>(context);

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          title: Text(
            item.getBestProductName(foodFactService.language),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            item.getFirstBrand() ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => _editProduct(context, item),
          leading: (item.imageFrontSmallUrl?.isNotEmpty ?? false)
              ? CachedNetworkImage(
                  imageUrl: item.imageFrontSmallUrl!,
                  maxWidthDiskCache: 50,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: imageProvider),
                    ),
                  ),
                  placeholder: (context, url) =>
                      CircularProgressIndicator(color: theme.disabledColor),
                  errorWidget: (context, url, error) => const SizedBox(
                    width: 50,
                    child: Center(
                      child: Icon(Symbols.broken_image_rounded),
                    ),
                  ),
                )
              : const SizedBox(
                  width: 50,
                  child: Center(
                    child: Icon(Symbols.image_not_supported_rounded),
                  ),
                ),
          trailing: SizedBox(
            width: 75,
            child: Text(
              item.servingSize ?? '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        );
      },
    );
  }

  Future<void> _editProduct(
    BuildContext context,
    openfoodfacts.Product item,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final database = context.read<AppDatabase>();
    final foodFactService = context.read<FoodFactService>();

    final dbProduct =
        item.barcode != null ? await database.getProduct(item.barcode!) : null;

    if (dbProduct == null) {
      ProductData? result;

      if (context.mounted) {
        result = await context.navigateTo(
          (_) => AddProductPage(
            product: foodFactService.getProductDataFromProduct(item),
            servingSizes: foodFactService.getServingSizesFromProduct(
              item,
              baseServingSizes,
              localizations.serving,
              localizations.container,
            ),
          ),
        );
      }

      if (result != null) {
        onSelect(result);

        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } else {
      onSelect(dbProduct);
    }
  }
}

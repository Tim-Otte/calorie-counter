import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../all.dart';
import '../../data/all.dart';
import '../../services/all.dart';

class ProductSearch extends StatelessWidget {
  final List<ServingSizeData> servingSizes;
  final Function(
      ProductTemplate product, List<ServingSizeTemplate> servingSizes) onSelect;

  const ProductSearch({
    super.key,
    required this.servingSizes,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final foodFactService = Provider.of<FoodFactService>(context);

    return SearchableListView(
      searchFunction: (search) => foodFactService.search(search),
      searchMode: SearchMode.onPause,
      itemBuilder: (context, item) => ListTile(
        title: Text(item.getBestProductName(foodFactService.language)),
        subtitle: Text(item.getFirstBrand() ?? ''),
        onTap: () => onSelect(
          foodFactService.getProductDataFromProduct(item, servingSizes),
          foodFactService.getServingSizesFromProduct(
            item,
            servingSizes,
            localizations.serving,
            localizations.container,
          ),
        ),
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
                errorWidget: (context, url, error) =>
                    const Icon(Symbols.broken_image_rounded),
              )
            : const Icon(Symbols.image_not_supported_rounded),
        trailing: Text(item.servingSize ?? ''),
      ),
      errorBuilder: (context, error, searchFunction) => Expanded(
        child: Column(
          children: IconWithTextAndButton.get(
            context,
            icon: Symbols.sync_problem_rounded,
            text: localizations.errorWhileFetchingProducts,
            buttonIcon: Symbols.repeat_rounded,
            buttonText: localizations.tryAgain,
            onButtonPressed: searchFunction,
          ),
        ),
      ),
    );
  }
}

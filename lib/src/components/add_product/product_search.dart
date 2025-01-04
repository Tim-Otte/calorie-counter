import 'package:cached_network_image/cached_network_image.dart';
import 'package:calorie_counter/src/extensions/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../pages/all.dart' show AddProductPage;
import '../all.dart';
import '../../data/all.dart';
import '../../services/all.dart';

class ProductSearch extends StatelessWidget {
  final bool enableOnlineSearch;
  final List<ServingSizeData> baseServingSizes;
  final bool? onlyLiquids;
  final Widget? trailing;
  final FocusNode? focusNode;
  final Function(ProductData product) onSelect;

  const ProductSearch({
    super.key,
    required this.enableOnlineSearch,
    required this.baseServingSizes,
    this.onlyLiquids,
    this.trailing,
    this.focusNode,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final foodFactService = Provider.of<FoodFactService>(context);
    final database = Provider.of<AppDatabase>(context);

    if (enableOnlineSearch) {
      return SearchableListView(
        focusNode: focusNode,
        searchFunction: (search) => foodFactService.search(search),
        searchMode: SearchMode.onPause,
        trailing: trailing,
        itemBuilder: (context, item) => ListTile(
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
          onTap: () async {
            final dbProduct = item.barcode != null
                ? await database.getProduct(item.barcode!)
                : null;

            if (dbProduct == null) {
              ProductData? result;

              if (context.mounted) {
                result = await Navigator.push<ProductData>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductPage(
                      product: foodFactService.getProductDataFromProduct(item),
                      servingSizes: foodFactService.getServingSizesFromProduct(
                        item,
                        baseServingSizes,
                        localizations.serving,
                        localizations.container,
                      ),
                    ),
                  ),
                );
              }

              if (result != null) {
                onSelect(result);
              } else if (context.mounted) {
                Navigator.pop(context);
              }
            } else {
              onSelect(dbProduct);
            }
          },
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
        ),
        errorBuilder: (context, error, searchFunction) => Expanded(
          child: IconWithText.andButton(
            context,
            icon: Symbols.sync_problem_rounded,
            text: localizations.errorWhileFetchingProducts,
            buttonIcon: Symbols.repeat_rounded,
            buttonText: localizations.tryAgain,
            onButtonPressed: searchFunction,
          ),
        ),
      );
    } else {
      return FutureBuilder(
        future: database.filteredProducts(onlyLiquids: onlyLiquids),
        builder: (context, snapshot) => SearchableListView(
          initialData: snapshot.hasData ? snapshot.data : null,
          searchFunction: (search) => database.filteredProducts(
            text: search,
            onlyLiquids: onlyLiquids,
          ),
          trailing: trailing,
          itemBuilder: (context, item) => ListTile(
            title: Text(
              item.name,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(item.brand),
            onTap: () => onSelect(item),
            leading: Icon(
              Symbols.favorite_rounded,
              color: const Color(0xff8a1200),
            ),
            trailing: MenuAnchor(
              alignmentOffset: Offset(-100, 0),
              menuChildren: [
                MenuItemButton(
                  leadingIcon: Icon(
                    Symbols.edit_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {},
                  child: Text(localizations.edit),
                ),
                MenuItemButton(
                  leadingIcon: Icon(
                    Symbols.delete_rounded,
                    color: theme.colorScheme.error,
                  ),
                  onPressed: () {
                    database.deleteProduct(item.productCode);
                  },
                  child: Text(localizations.delete),
                ),
              ],
              builder: (_, controller, __) => IconButton(
                onPressed: controller.toggle,
                icon: Icon(Symbols.more_vert_rounded),
              ),
            ),
            contentPadding: EdgeInsets.only(left: 16, right: 10),
          ),
          errorBuilder: (context, error, searchFunction) => Expanded(
            child: IconWithText.andButton(
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
}

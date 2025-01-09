import 'package:calorie_counter/src/extensions/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../all.dart';
import '../../data/all.dart';

class FavouritesList extends StatelessWidget {
  final List<ProductData> items;
  final Function(ProductData product) onSelect;

  const FavouritesList({
    super.key,
    required this.items,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final database = Provider.of<AppDatabase>(context);

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
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
                onPressed: () async {
                  var result = await showDialog<bool>(
                    context: context,
                    builder: (context) => ConfirmDeleteDialog(),
                  );

                  if (result == true) {
                    database.deleteProduct(item.productCode);
                  }
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
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart' show ProductSearch;
import '../data/all.dart';
import 'all.dart' show AddProductPage;

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  var _baseServingSizes = <ServingSizeData>[];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final database = Provider.of<AppDatabase>(context);

    if (_baseServingSizes.isEmpty) {
      database
          .select(database.servingSize)
          .get()
          .then((value) => setState(() => _baseServingSizes = value));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.searchProductPageTitle),
      ),
      body: ProductSearch(
        baseServingSizes: _baseServingSizes,
        trailing: IconButton.filled(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AddProductPage()),
          ),
          icon: Icon(Symbols.edit_note_rounded),
          tooltip: localizations.switchToEditModeTooltip,
        ),
        onSelect: (product, servingSizes) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(
                product: product,
                servingSizes: servingSizes,
              ),
            ),
          );

          /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content:
                Text(localizations.toastProductDataSuccessfullyTransferred),
          ),
        ); */
        },
      ),
    );
  }
}

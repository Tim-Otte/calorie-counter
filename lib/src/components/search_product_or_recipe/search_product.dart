import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:openfoodfacts/openfoodfacts.dart' as openfoodfacts;
import 'package:provider/provider.dart';

import '../../data/all.dart';
import '../../extensions/all.dart';
import '../../services/all.dart' show FoodFactService;
import 'favourites_list.dart';
import 'openfoodfacts_list.dart';

class SearchProduct extends StatefulWidget {
  final FocusNode? searchFocusNode;
  final bool? onlyLiquids;
  final bool? onlyFavourites;
  final Function(ProductData product) onSelect;

  const SearchProduct({
    super.key,
    this.searchFocusNode,
    this.onlyLiquids,
    this.onlyFavourites,
    required this.onSelect,
  });

  @override
  State<StatefulWidget> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final _controller = TextEditingController();
  Timer? _debounceTimer;
  String? _searchText;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged({bool? forceUpdate}) {
    if (_searchText == _controller.text && (forceUpdate ?? false) == false) {
      return;
    }

    if (widget.onlyFavourites == true) {
      setState(() => _searchText = _controller.text);
    } else {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(
        const Duration(milliseconds: 750),
        () => setState(() => _searchText = _controller.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final database = Provider.of<AppDatabase>(context);
    final foodFactService = Provider.of<FoodFactService>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            autofocus: true,
            focusNode: widget.searchFocusNode,
            decoration: InputDecoration(
              label: Text(localizations.search),
              prefixIcon: const Icon(Symbols.search_rounded),
              filled: true,
            ),
            controller: _controller,
            textInputAction: TextInputAction.search,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                  stream: database.getFilteredProducts(
                    text: _searchText,
                    onlyLiquids: widget.onlyLiquids,
                  ),
                  builder: _getFavouritesSection,
                ),
                if (widget.onlyFavourites != true)
                  FutureBuilder(
                    initialData: <openfoodfacts.Product>[],
                    future: (_searchText ?? '').isEmpty
                        ? null
                        : foodFactService.search(_searchText!),
                    builder: _getOpenFoodFactsSection,
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _getFavouritesSection(
    BuildContext context,
    AsyncSnapshot<List<ProductData>> snapshot,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return SizedBox();
    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSectionTitle(
            theme,
            Symbols.favorite_rounded,
            localizations.favourites,
          ),
          FavouritesList(
            items: snapshot.data!,
            onSelect: widget.onSelect,
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget _getOpenFoodFactsSection(
    BuildContext context,
    AsyncSnapshot<List<openfoodfacts.Product>> snapshot,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final database = context.read<AppDatabase>();

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (snapshot.hasData) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
            stream: database.getFilteredProducts(text: _searchText),
            builder: (context, favouritesSnapshot) =>
                (favouritesSnapshot.data?.length ?? 0) > 0
                    ? _getSectionTitle(
                        theme,
                        Symbols.search_rounded,
                        localizations.search,
                      )
                    : SizedBox(),
          ),
          (_searchText ?? '').isEmpty
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    localizations.searchEmpty,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium!.color?.useOpacity(0.8),
                    ),
                  ),
                )
              : FutureBuilder(
                  future: database.getBaseServingSizes(),
                  builder: (context, baseServingSizeSnapshot) =>
                      OpenFoodFactsList(
                    baseServingSizes: baseServingSizeSnapshot.hasData
                        ? baseServingSizeSnapshot.data!
                        : [],
                    items: snapshot.data!,
                    onSelect: widget.onSelect,
                  ),
                )
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget _getSectionTitle(
    ThemeData theme,
    IconData icon,
    String title,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 20),
      child: Text(
        title,
        style: theme.textTheme.titleMedium
            ?.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}

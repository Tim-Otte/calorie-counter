import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart' show ProductSearch;
import '../data/all.dart';
import 'all.dart' show AddProductPage;

class SearchProductPage extends StatefulWidget {
  final Function(ProductData product) onSelect;
  final bool? onlyLiquids;

  const SearchProductPage({
    super.key,
    required this.onSelect,
    this.onlyLiquids,
  });

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _favoritesFocusNode = FocusNode();
  final _onlineFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabControllerChanged);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.searchProductPageTitle),
        bottom: TabBar(
          controller: _tabController,
          labelPadding: EdgeInsets.zero,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 7.5),
                    child: Icon(Symbols.favorite_rounded),
                  ),
                  Text(localizations.favourites),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 7.5),
                    child: Icon(Symbols.search_rounded),
                  ),
                  Text(localizations.search),
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: database.getBaseServingSizes(),
        builder: (context, snapshot) => snapshot.hasData
            ? TabBarView(
                controller: _tabController,
                children: [
                  ProductSearch(
                    focusNode: _favoritesFocusNode,
                    enableOnlineSearch: false,
                    baseServingSizes: snapshot.data!,
                    onlyLiquids: widget.onlyLiquids,
                    onSelect: widget.onSelect,
                  ),
                  ProductSearch(
                    focusNode: _onlineFocusNode,
                    enableOnlineSearch: true,
                    baseServingSizes: snapshot.data!,
                    trailing: IconButton.filled(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddProductPage()),
                      ),
                      icon: Icon(Symbols.edit_note_rounded),
                      tooltip: localizations.switchToEditModeTooltip,
                    ),
                    onSelect: widget.onSelect,
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabControllerChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabControllerChanged() {
    if (_tabController.index == 1) {
      _favoritesFocusNode.unfocus();
      _onlineFocusNode.requestFocus();
    } else {
      _onlineFocusNode.unfocus();
      _favoritesFocusNode.requestFocus();
    }
  }
}

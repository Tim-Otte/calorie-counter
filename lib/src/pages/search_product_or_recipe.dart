import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import 'all.dart' show AddProductPage, AddRecipePage, AddMealPage;
import '../components/all.dart' show SearchProduct, SearchRecipes;
import '../data/all.dart';
import '../extensions/all.dart';

class SearchProductOrRecipePage extends StatefulWidget {
  final bool? onlyLiquids;

  const SearchProductOrRecipePage({
    super.key,
    this.onlyLiquids,
  });

  @override
  State<SearchProductOrRecipePage> createState() =>
      _SearchProductOrRecipePageState();
}

class _SearchProductOrRecipePageState extends State<SearchProductOrRecipePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _productFocusNode = FocusNode();
  final _recipeFocusNode = FocusNode();
  int _currentTabIndex = 0;

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
        title: Text(localizations.searchProductOrRecipePageTitle),
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
                    child: Icon(
                      Symbols.nutrition_rounded,
                      fill: _currentTabIndex == 0 ? 1 : 0,
                    ),
                  ),
                  Text(localizations.products),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 7.5),
                    child: Icon(
                      Symbols.menu_book_rounded,
                      fill: _currentTabIndex == 1 ? 1 : 0,
                    ),
                  ),
                  Text(localizations.recipes),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: AnimatedCrossFade(
          firstChild: Icon(Symbols.checkbook_rounded),
          secondChild: Icon(Symbols.add_2_rounded),
          crossFadeState: CrossFadeState.values[_currentTabIndex],
          duration: Durations.medium1,
        ),
        onPressed: () => context.navigateTo(
          _currentTabIndex == 0
              ? (_) => AddProductPage()
              : (_) => AddRecipePage(),
        ),
      ),
      body: FutureBuilder(
        future: database.getBaseServingSizes(),
        builder: (context, snapshot) => snapshot.hasData
            ? TabBarView(
                controller: _tabController,
                children: [
                  SearchProduct(
                    searchFocusNode: _productFocusNode,
                    onSelect: (product) => context.navigateTo(
                      (_) => AddMealPage(product: product),
                    ),
                  ),
                  SearchRecipes(searchFocusNode: _recipeFocusNode),
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
    // Announce change to switch FAB icon
    if (_currentTabIndex != _tabController.index) {
      setState(() => _currentTabIndex = _tabController.index);
    }

    if (_tabController.index == 1) {
      _recipeFocusNode.requestFocus();
    } else {
      _productFocusNode.requestFocus();
    }
  }
}

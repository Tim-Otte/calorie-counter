import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../all.dart' show IconWithText;
import '../../data/all.dart';

class SearchRecipes extends StatefulWidget {
  final FocusNode searchFocusNode;

  const SearchRecipes({
    super.key,
    required this.searchFocusNode,
  });

  @override
  State<StatefulWidget> createState() => _SearchRecipesState();
}

class _SearchRecipesState extends State<SearchRecipes> {
  var _searchText = '';

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final database = Provider.of<AppDatabase>(context);

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
            textInputAction: TextInputAction.search,
            onChanged: (value) => setState(() => _searchText = value),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: database.getRecipes(text: _searchText),
            builder: (context, snapshot) =>
                snapshot.hasData && (snapshot.data?.isNotEmpty ?? false)
                    ? SingleChildScrollView(
                        child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];

                          return ListTile(
                            leading: Icon(Symbols.menu_book_rounded),
                            title: Text(item.name),
                          );
                        },
                      ))
                    : IconWithText(
                        icon: _searchText.isEmpty
                            ? Symbols.search_rounded
                            : Symbols.search_off_rounded,
                        text: _searchText.isEmpty
                            ? localizations.searchEmpty
                            : localizations.searchNoResult,
                      ),
          ),
        )
      ],
    );
  }
}

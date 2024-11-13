import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'all.dart';

class SearchableListView<T> extends StatefulWidget {
  final Future<List<T>> Function(String) searchFunction;
  final Widget? Function(BuildContext, T) itemBuilder;
  final Widget Function(
          BuildContext context, Object? error, void Function() searchFunction)
      errorBuilder;
  final SearchMode? searchMode;
  final Widget? trailing;

  const SearchableListView({
    super.key,
    required this.searchFunction,
    required this.itemBuilder,
    required this.errorBuilder,
    this.searchMode,
    this.trailing,
  });

  @override
  State<StatefulWidget> createState() => _SearchableListViewState<T>();
}

class _SearchableListViewState<T> extends State<SearchableListView<T>> {
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      label: Text(localizations.search),
                      prefixIcon: const Icon(Symbols.search_rounded),
                      filled: true,
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
        FutureBuilderWithCircularProgress(
          future: _searchText == null
              ? Future.value([])
              : widget.searchFunction(_searchText!),
          dataBuilder: (context, data) {
            return Expanded(
              child: data?.isNotEmpty ?? false
                  ? ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) =>
                          widget.itemBuilder(context, data[index]),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Icon(
                              _searchText?.isEmpty ?? true
                                  ? Symbols.manage_search_rounded
                                  : Symbols.search_off_rounded,
                              size: 75,
                              color: theme.iconTheme.color!.withOpacity(0.4),
                            ),
                          ),
                          Text(
                            _searchText?.isEmpty ?? true
                                ? localizations.searchEmpty
                                : localizations.searchNoResult,
                            style: theme.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
            );
          },
          errorBuilder: (context, error) => Expanded(
            child: widget.errorBuilder(
                context, error, () => _onSearchChanged(forceUpdate: true)),
          ),
        ),
      ],
    );
  }

  void _onSearchChanged({bool? forceUpdate}) {
    if (_searchText == _controller.text && (forceUpdate ?? false) == false) {
      return;
    }

    if (widget.searchMode == null ||
        widget.searchMode == SearchMode.immediate) {
      setState(() => _searchText = _controller.text);
    } else {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(
        const Duration(milliseconds: 750),
        () => setState(() => _searchText = _controller.text),
      );
    }
  }
}

enum SearchMode { immediate, onPause }

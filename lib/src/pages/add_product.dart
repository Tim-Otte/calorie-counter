import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart' as c;
import '../controllers/settings_controller.dart';
import '../data/all.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _scrollController = ScrollController();
  var _baseServingSizes = <ServingSizeData>[];
  var _servingSizes = <ServingSizeTemplate>[];
  var _product = ProductTemplate();

  bool _isInSearchMode = true;
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final database = Provider.of<AppDatabase>(context);
    final settingsController = Provider.of<SettingsController>(context);

    if (_baseServingSizes.isEmpty) {
      database
          .filteredServingSizes(
              measurementUnit:
                  settingsController.measurementUnit ?? MeasurementUnit.metric)
          .then((value) => setState(() => _baseServingSizes = value));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isInSearchMode
            ? localizations.addProductPageTitle_searchMode
            : localizations.addProductPageTitle),
        actions: [
          IconButton(
            onPressed: () => setState(() => _isInSearchMode = !_isInSearchMode),
            icon: Icon(_isInSearchMode
                ? Symbols.edit_note_rounded
                : Symbols.manage_search_rounded),
            tooltip: _isInSearchMode
                ? localizations.switchToEditModeTooltip
                : localizations.switchToSearchModeTooltip,
          ),
          const SizedBox(width: 10)
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _isInSearchMode ? 0 : 80,
        child: BottomAppBar(
          elevation: 1,
          child: Row(
            children: [
              IconButton(
                onPressed: () async => await _addServingSize(),
                icon: Icon(Symbols.add_notes_rounded),
                tooltip: localizations.addCustomServingSizeTooltip,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: _isInSearchMode
          ? null
          : FloatingActionButton.extended(
              onPressed: _isValid
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(_isValid ? 'Valid' : 'Not valid'),
                        ),
                      );
                    }
                  : null,
              icon: Icon(Symbols.save_rounded),
              label: Text(localizations.save),
              elevation: 0,
              backgroundColor: theme.colorScheme.secondaryContainer
                  .withOpacity(_isValid ? 1 : 0.6),
              foregroundColor: theme.colorScheme.onSecondaryContainer
                  .withOpacity(_isValid ? 1 : 0.6),
            ),
      body: _isInSearchMode
          ? c.ProductSearch(
              servingSizes: _baseServingSizes,
              onSelect: (product, servingSizes) {
                setState(() {
                  _product = product;
                  _servingSizes = servingSizes;
                  _isValid = _product.isNotEmpty;
                  _isInSearchMode = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                        localizations.toastProductDataSuccessfullyTransferred),
                  ),
                );
              },
            )
          : c.ProductForm(
              product: _product,
              customServingSizes: _servingSizes,
              baseServingSizes: _baseServingSizes,
              scrollController: _scrollController,
              onChange: (product, servingSizes) => setState(() {
                _product = product;
                _servingSizes = servingSizes;
                _isValid = _product.isNotEmpty && _servingSizes.isNotEmpty;
              }),
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _addServingSize() async {
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );

    if (mounted) {
      var result = await showModalBottomSheet<ServingSizeTemplate>(
        context: context,
        builder: (context) => c.ServingSizeBtmSheet(
          isEditMode: false,
          baseServingSizes: _baseServingSizes,
          initialValue: ServingSizeTemplate.fromValues(
            name: '',
            amount: 0,
            baseServingSize: _baseServingSizes
                .where((x) => x.isLiquid == _product.isLiquid)
                .first
                .id,
          ),
        ),
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: false,
        enableDrag: false,
      );

      if (result != null) {
        setState(() => _servingSizes.add(result));
      }
    }
  }
}

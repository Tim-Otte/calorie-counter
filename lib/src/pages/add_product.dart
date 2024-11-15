import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart' as c;
import '../data/all.dart';
import 'all.dart' show SearchProductPage;

class AddProductPage extends StatefulWidget {
  final ProductTemplate? product;
  final List<ServingSizeTemplate>? servingSizes;

  const AddProductPage({
    super.key,
    this.product,
    this.servingSizes,
  });

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _scrollController = ScrollController();
  var _baseServingSizes = <ServingSizeData>[];
  var _servingSizes = <ServingSizeTemplate>[];
  var _product = ProductTemplate();

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      _product = widget.product!;
    }

    if (widget.servingSizes != null) {
      _servingSizes = widget.servingSizes!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final database = Provider.of<AppDatabase>(context);

    if (_baseServingSizes.isEmpty) {
      database
          .select(database.servingSize)
          .get()
          .then((value) => setState(() => _baseServingSizes = value));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.addProductPageTitle),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchProductPage())),
            icon: Icon(Symbols.manage_search_rounded),
            tooltip: localizations.switchToSearchModeTooltip,
          ),
          const SizedBox(width: 10)
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 80,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _product.isNotEmpty && _servingSizes.isNotEmpty
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text('Valid'),
                  ),
                );
              }
            : null,
        icon: Icon(Symbols.save_rounded),
        label: Text(localizations.save),
        elevation: 0,
        backgroundColor: theme.colorScheme.secondaryContainer.withOpacity(
            _product.isNotEmpty && _servingSizes.isNotEmpty ? 1 : 0.6),
        foregroundColor: theme.colorScheme.onSecondaryContainer.withOpacity(
            _product.isNotEmpty && _servingSizes.isNotEmpty ? 1 : 0.6),
      ),
      body: _baseServingSizes.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : c.ProductForm(
              product: _product,
              customServingSizes: _servingSizes,
              baseServingSizes: _baseServingSizes,
              scrollController: _scrollController,
              onChange: (product, servingSizes) => setState(() {
                _product = product;
                _servingSizes = servingSizes;
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

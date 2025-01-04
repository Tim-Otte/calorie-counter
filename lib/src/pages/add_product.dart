import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart' as c;
import '../controllers/settings_controller.dart';
import '../data/all.dart';
import '../extensions/all.dart';

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

    return FutureBuilder(
      future: database.getBaseServingSizes(),
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: Text(localizations.addProductPageTitle),
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 100,
          child: BottomAppBar(
            elevation: 1,
            child: Row(
              children: [
                IconButton(
                  onPressed: snapshot.hasData
                      ? () async => await _addServingSize(snapshot.data!)
                      : null,
                  icon: Icon(Symbols.add_notes_rounded),
                  tooltip: localizations.addCustomServingSizeTooltip,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _product.isNotEmpty &&
                  _servingSizes.isNotEmpty &&
                  snapshot.hasData
              ? () async {
                  var servingSizes = _servingSizes.map(
                    (x) => x.getForInsert(
                        _product.productCode,
                        snapshot.data!
                            .where((y) => y.id == x.baseServingSize)
                            .first),
                  );

                  ProductData? product;

                  try {
                    await database.insertProductWithServingSizes(
                      _product.getForInsert(),
                      servingSizes.toList(),
                    );
                    product = await database.getProduct(_product.productCode);
                  } catch (ex) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showError(localizations.errorWhileSavingProductData);
                    }
                  }

                  if (context.mounted) {
                    Navigator.pop(context, product);
                  }
                }
              : null,
          icon: Icon(Symbols.save_rounded),
          label: Text(localizations.save),
          elevation: 0,
          backgroundColor: theme.colorScheme.secondaryContainer.useOpacity(
              _product.isNotEmpty && _servingSizes.isNotEmpty ? 1 : 0.6),
          foregroundColor: theme.colorScheme.onSecondaryContainer.useOpacity(
              _product.isNotEmpty && _servingSizes.isNotEmpty ? 1 : 0.6),
        ),
        body: snapshot.hasData
            ? c.ProductForm(
                product: _product,
                customServingSizes: _servingSizes,
                baseServingSizes: snapshot.data!,
                scrollController: _scrollController,
                onChange: (product, servingSizes) => setState(() {
                  _product = product;
                  _servingSizes = servingSizes;
                }),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _addServingSize(List<ServingSizeData> baseServingSizes) async {
    final settingsController = context.read<SettingsController>();

    baseServingSizes = baseServingSizes
        .where((x) =>
            x.isLiquid == _product.isLiquid &&
            x.measuringUnit ==
                (settingsController.measurementUnit ?? MeasurementUnit.metric))
        .toList();

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
          baseServingSizes: baseServingSizes,
          initialValue: ServingSizeTemplate.fromValues(
            name: '',
            short: '',
            amount: 0,
            baseServingSize: baseServingSizes.first.id,
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

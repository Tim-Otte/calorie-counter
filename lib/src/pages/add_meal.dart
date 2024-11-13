import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart' as c;
import '../data/database.dart';
import '../services/all.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key, this.productCode});

  final String? productCode;

  @override
  State<StatefulWidget> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  ServingSizeData? _servingSize;
  String? _productCode;
  double? _amount;

  @override
  void initState() {
    super.initState();
    _productCode = widget.productCode;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final foodFactService = Provider.of<FoodFactService>(context);

    if (widget.productCode != null) {
      foodFactService
          .getProduct(widget.productCode!)
          .then((p) => setState(() {}));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.addMealPageTitle),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Symbols.check),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20).copyWith(bottom: 10),
              child: c.FormField(
                label: Text(localizations.productName),
                icon: Symbols.barcode_rounded,
                initialValue: _productCode,
                onChanged: (value) => setState(() => _productCode = value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: c.ServingSizeSelector(
                initialValue: _servingSize,
                onChanged: (value) => setState(() => _servingSize = value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: c.FormField(
                label: Text(localizations.servingSizeAmount),
                icon: Symbols.numbers_rounded,
                suffixText: _servingSize?.short,
                initialValue: _amount?.toString(),
                onlyNumbers: true,
                onChanged: (value) => setState(() => _productCode = value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Wrap(
                runSpacing: 20,
                children: [
                  const Divider(),
                  Text(
                    localizations.nutritionalInformationPerServingTitle,
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: theme.colorScheme.primary),
                  ),
                  c.FormField(
                    label: Text(localizations.calories),
                    icon: Symbols.mode_heat_rounded,
                    suffixText: "kcal",
                    onlyNumbers: true,
                  ),
                  c.FormField(
                    label: Text(localizations.fats),
                    icon: Symbols.water_drop_rounded,
                    suffixText: "g",
                    onlyNumbers: true,
                  ),
                  c.FormField(
                    label: Text(localizations.proteins),
                    icon: Symbols.exercise_rounded,
                    suffixText: "g",
                    onlyNumbers: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

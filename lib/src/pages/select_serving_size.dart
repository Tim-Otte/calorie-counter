import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../components/all.dart';
import '../controllers/settings_controller.dart';
import '../data/all.dart';

class SelectServingSizePage extends StatefulWidget {
  const SelectServingSizePage({super.key});

  @override
  State<SelectServingSizePage> createState() => _SelectServingSizePageState();
}

class _SelectServingSizePageState extends State<SelectServingSizePage> {
  ServingSizeFilter _filter = ServingSizeFilter.all;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final database = Provider.of<AppDatabase>(context);
    final settingsController = Provider.of<SettingsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.selectServingSizePageTitle),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () async {
              var result = await showDialog<ServingSizeFilter>(
                context: context,
                builder: (context) => EnumRadioDialog<ServingSizeFilter>(
                  initialValue: _filter,
                  title: localizations.servingSizeFilter,
                  values: ServingSizeFilter.values,
                ),
              );
              if (result != null) {
                setState(() => _filter = result);
              }
            },
            icon: Icon(
              Symbols.filter_alt_rounded,
              fill: _filter == ServingSizeFilter.all ? 0 : 1,
            ),
          )
        ],
        actionsIconTheme: theme.iconTheme.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Symbols.add),
        onPressed: () {},
      ),
      body: SearchableListView(
        searchFunction: (searchText) => database.filteredBaseServingSizes(
          measurementUnit:
              settingsController.measurementUnit ?? MeasurementUnit.metric,
          filter: _filter,
          searchText: searchText,
        ),
        itemBuilder: (context, item) => ListTile(
          title: Text(item.name),
          leading: _filter != ServingSizeFilter.all
              ? null
              : Icon(
                  item.isLiquid
                      ? Symbols.water_drop_rounded
                      : Symbols.restaurant_rounded,
                ),
          trailing: item.short != null
              ? Text(
                  item.short!,
                  style: theme.textTheme.labelLarge!
                      .copyWith(color: theme.colorScheme.secondary),
                )
              : null,
          onTap: () => Navigator.pop(context, item),
        ),
        errorBuilder: (context, error, searchFunction) => Expanded(
          child: IconWithText.andButton(
            context,
            icon: Symbols.error_rounded,
            text: localizations.errorWhileFetchingServingSizes,
            buttonIcon: Symbols.repeat_rounded,
            buttonText: localizations.tryAgain,
            onButtonPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SelectServingSizePage()),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/settings/basic_tile.dart';
import '../components/settings/measurement_unit_dialog.dart';
import '../components/settings/section.dart';
import '../components/settings/switch_tile.dart';
import '../models/measurement_unit.dart';
import '../settings/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.controller});

  final SettingsController controller;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool isDarkMode;
  late MeasurementUnit measurementUnit;

  void setThemeMode(bool enforceDarkMode) {
    setState(() {
      isDarkMode = enforceDarkMode;
    });
    widget.controller
        .updateThemeMode(enforceDarkMode ? ThemeMode.dark : ThemeMode.system);
  }

  void setMeasuringUnit(MeasurementUnit? unit) {
    setState(() => measurementUnit = unit ?? MeasurementUnit.metric);
  }

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.controller.themeMode == ThemeMode.dark;
    measurementUnit = MeasurementUnit.metric;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsPageTitle),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: MaterialSettingsSection(
          margin: const EdgeInsetsDirectional.all(10),
          title: Text(localizations.settingsGeneralSection),
          tiles: [
            MaterialSwitchSettingsTile(
              leading: const Icon(Icons.palette),
              title: const Text('Theme'),
              description: Text(isDarkMode
                  ? localizations.settingEnforceDarkModeDescriptionEnabled
                  : localizations.settingEnforceDarkModeDescriptionDisabled),
              onToggle: setThemeMode,
              value: isDarkMode,
            ),
            MaterialBasicSettingsTile(
              leading: const Icon(Icons.straighten),
              title: const Text('Units'),
              onTap: (context) async {
                var result = await showDialog<MeasurementUnit>(
                  context: context,
                  builder: (context) =>
                      MeasurementUnitDialog(currentValue: measurementUnit),
                );

                if (result != null) {
                  setState(() => measurementUnit = result);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

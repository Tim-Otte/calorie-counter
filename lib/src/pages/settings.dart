import 'package:calorie_counter/src/components/settings/dialogs/height_input_dialog.dart';
import 'package:calorie_counter/src/components/settings/dialogs/theme_mode_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../components/settings/basic_tile.dart';
import '../components/settings/dialogs/measurement_unit_dialog.dart';
import '../components/settings/dialogs/weight_input_dialog.dart';
import '../components/settings/section.dart';
import '../models/measurement_unit.dart';
import '../settings/settings_controller.dart';
import '../tools/translator.dart';
import '../tools/unit_converter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.controller});

  final SettingsController controller;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeMode themeMode;
  late MeasurementUnit measurementUnit;
  DateTime? dateOfBirth;
  double? height;
  String? heightText;
  double? weight;
  String? weightText;

  void setThemeMode(ThemeMode? mode) {
    if (mode != null) {
      setState(() => themeMode = mode);
      widget.controller.updateThemeMode(mode);
    }
  }

  void setMeasuringUnit(MeasurementUnit? unit) {
    if (unit != null) {
      setState(() => measurementUnit = unit);

      if (height != null) setHeight(height);
      if (weight != null) setWeight(weight);
    }
  }

  void setDateOfBirth(DateTime? date) {
    if (date != null) {
      setState(() => dateOfBirth = date);
    }
  }

  void setHeight(double? value) {
    if (value != null) {
      setState(() => height = value);

      if (measurementUnit == MeasurementUnit.metric) {
        setState(() => heightText = "${value.round()} cm");
      } else {
        var imperial = UnitConverter.heightToImperial(value);
        setState(() => heightText =
            "${imperial.feet.round()}' ${imperial.inches.round()}\"");
      }
    }
  }

  void setWeight(double? value) {
    if (value != null) {
      setState(() => weight = value);

      if (measurementUnit == MeasurementUnit.metric) {
        setState(() => weightText = "${value.toStringAsFixed(1)} kg");
      } else {
        var imperial = UnitConverter.weightToImperial(value);
        setState(() => weightText = "${imperial.toStringAsFixed(1)} lbs");
      }
    }
  }

  /// Get the settings section for the general settings
  Widget getGeneralSettingsSection(AppLocalizations localizations) {
    return MaterialSettingsSection(
      margin: const EdgeInsetsDirectional.all(10),
      title: Text(localizations.settingsGeneralSection),
      tiles: [
        MaterialBasicSettingsTile(
          leading: const Icon(Icons.palette),
          title: Text(localizations.settingTheme),
          value: Text(Translator.getTranslation(context, themeMode)),
          onTap: (context) async {
            var result = await showDialog<ThemeMode>(
              context: context,
              builder: (context) => ThemeModeDialog(currentValue: themeMode),
            );
            setThemeMode(result);
          },
        ),
        MaterialBasicSettingsTile(
          leading: const Icon(Icons.straighten),
          title: Text(localizations.settingMeasurementUnit),
          value: Text(Translator.getTranslation(context, measurementUnit)),
          onTap: (context) async {
            var result = await showDialog<MeasurementUnit>(
              context: context,
              builder: (context) =>
                  MeasurementUnitDialog(currentValue: measurementUnit),
            );
            setMeasuringUnit(result);
          },
        )
      ],
    );
  }

  /// Get the settings section for the personal information
  Widget getPersonalSettingsSection(AppLocalizations localizations) {
    return MaterialSettingsSection(
      margin: const EdgeInsetsDirectional.all(10),
      title: Text(localizations.settingsPersonalInformationSection),
      tiles: [
        MaterialBasicSettingsTile(
          leading: const Icon(Icons.calendar_month),
          title: Text(localizations.settingDateOfBirth),
          description: Text(dateOfBirth == null
              ? localizations.notSet
              : "${DateFormat.yMMMd(localizations.localeName).format(dateOfBirth!)} / ${localizations.age}: ${(DateTime.now().difference(dateOfBirth!).inDays / 365.0).round()} ${localizations.years}"),
          onTap: (context) async {
            var result = await showDatePicker(
              context: context,
              firstDate:
                  DateTime(DateTime.now().year - 100, DateTime.january, 1),
              lastDate: DateTime.now().subtract(const Duration(days: 365)),
              initialDate: dateOfBirth,
            );
            setDateOfBirth(result);
          },
        ),
        MaterialBasicSettingsTile(
          leading: const Icon(Icons.height),
          title: Text(localizations.settingHeight),
          description:
              Text(heightText == null ? localizations.notSet : heightText!),
          onTap: (context) async {
            var result = await showDialog<double>(
              context: context,
              builder: (context) => HeightInputDialog(
                measurementUnit: measurementUnit,
                currentValue: height ?? 0,
              ),
            );
            setHeight(result);
          },
        ),
        MaterialBasicSettingsTile(
          leading: const Icon(Icons.scale),
          title: Text(localizations.settingWeight),
          description:
              Text(weightText == null ? localizations.notSet : weightText!),
          onTap: (context) async {
            var result = await showDialog<double>(
              context: context,
              builder: (context) => WeightInputDialog(
                measurementUnit: measurementUnit,
                currentValue: weight ?? 0,
              ),
            );
            setWeight(result);
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    themeMode = widget.controller.themeMode;
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
        child: Column(
          children: [
            getGeneralSettingsSection(localizations),
            getPersonalSettingsSection(localizations),
          ],
        ),
      ),
    );
  }
}

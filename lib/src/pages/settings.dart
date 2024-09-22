import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../components/settings/basic_tile.dart';
import '../components/settings/bottom_sheets/about_personal_data_btm_sheet.dart';
import '../components/settings/dialogs/dialogs.dart';
import '../components/settings/section.dart';
import '../models/enums/enums.dart';
import '../settings/settings_controller.dart';
import '../tools/tools.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.controller});

  final SettingsController controller;

  /// Get the settings section for the general settings
  Widget getGeneralSettingsSection(
      BuildContext context, AppLocalizations localizations) {
    return MaterialSettingsSection(
      margin: const EdgeInsetsDirectional.all(10),
      title: Text(localizations.settingsGeneralSection),
      tiles: [
        MaterialBasicSettingsTile(
          prefix: const Icon(Icons.palette),
          title: Text(localizations.settingTheme),
          value: Text(
            Translator.getTranslation(context, controller.themeMode),
          ),
          onTap: (context) async {
            var result = await showDialog<ThemeMode>(
              context: context,
              builder: (context) => ThemeModeDialog(
                currentValue: controller.themeMode,
              ),
            );
            controller.updateThemeMode(result);
          },
        ),
        MaterialBasicSettingsTile(
          prefix: const Icon(Icons.straighten),
          title: Text(localizations.settingMeasurementUnit),
          value: Text(
              Translator.getTranslation(context, controller.measurementUnit)),
          onTap: (context) async {
            var result = await showDialog<MeasurementUnit>(
              context: context,
              builder: (context) => MeasurementUnitDialog(
                currentValue: controller.measurementUnit,
              ),
            );
            controller.updateMeasurementUnit(result);
          },
        )
      ],
    );
  }

  /// Get the settings section for the personal information
  Widget getPersonalSettingsSection(
      BuildContext context, AppLocalizations localizations) {
    return MaterialSettingsSection(
      margin: const EdgeInsetsDirectional.all(10),
      title: Text(localizations.settingsPersonalInformationSection),
      tiles: [
        MaterialBasicSettingsTile(
          prefix: Icon(switch (controller.gender) {
            Gender.male => Icons.man,
            Gender.female => Icons.woman,
          }),
          title: Text(localizations.settingGender),
          value: Text(
            Translator.getTranslation(context, controller.gender),
          ),
          suffix: IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => const AboutPersonalDataBtmSheet(),
              isScrollControlled: true,
              useSafeArea: true,
              showDragHandle: true,
              enableDrag: true,
            ),
            icon: const Icon(Icons.info_outline),
            color: Theme.of(context).colorScheme.primary,
          ),
          onTap: (context) async {
            var result = await showDialog<Gender>(
              context: context,
              builder: (context) => GenderDialog(
                currentValue: controller.gender,
              ),
            );
            controller.updateGender(result);
          },
        ),
        MaterialBasicSettingsTile(
          prefix: const Icon(Icons.calendar_month),
          title: Text(localizations.settingDateOfBirth),
          description: Text(
              "${DateFormat.yMMMd(localizations.localeName).format(controller.dateOfBirth)} / ${localizations.age}: ${(DateTime.now().difference(controller.dateOfBirth).inDays / 365.0).round()} ${localizations.years}"),
          onTap: (context) async {
            var result = await showDatePicker(
              context: context,
              initialDatePickerMode: DatePickerMode.year,
              firstDate:
                  DateTime(DateTime.now().year - 100, DateTime.january, 1),
              lastDate: DateTime.now().subtract(const Duration(days: 365)),
              initialDate: controller.dateOfBirth,
            );
            controller.updateDateOfBirth(result);
          },
        ),
        MaterialBasicSettingsTile(
          prefix: const Icon(Icons.height),
          title: Text(localizations.settingHeight),
          description: Text(controller.heightString),
          onTap: (context) async {
            var result = await showDialog<double>(
              context: context,
              builder: (context) => HeightInputDialog(
                measurementUnit: controller.measurementUnit,
                currentValue: controller.height,
              ),
            );
            controller.updateHeight(result);
          },
        ),
        MaterialBasicSettingsTile(
          prefix: const Icon(Icons.scale),
          title: Text(localizations.settingWeight),
          description: Text(controller.weightString),
          onTap: (context) async {
            var result = await showDialog<double>(
              context: context,
              builder: (context) => WeightInputDialog(
                measurementUnit: controller.measurementUnit,
                currentValue: controller.weight,
              ),
            );
            controller.updateWeight(result);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      restorationId: 'settings',
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsPageTitle),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              getGeneralSettingsSection(context, localizations),
              getPersonalSettingsSection(context, localizations),
            ],
          ),
        ),
      ),
    );
  }
}

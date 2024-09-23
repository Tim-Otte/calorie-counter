import 'package:calorie_counter/src/extensions/enumerable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

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
          prefix: const Icon(Symbols.palette),
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
          prefix: const Icon(Symbols.translate),
          title: Text(localizations.settingLanguage),
          value: Text(
            controller.locale != null
                ? LocaleNames.of(context)!
                    .nameOf(controller.locale!.languageCode)!
                : localizations.systemDefault,
          ),
          onTap: (context) async {
            var result = await showDialog<String?>(
              context: context,
              builder: (context) => LanguageDialog(
                currentLocale:
                    controller.locale?.languageCode ?? localizations.localeName,
              ),
            );
            controller.updateLocale(result);
          },
        ),
        MaterialBasicSettingsTile(
          prefix: const Icon(Symbols.straighten),
          title: Text(localizations.settingMeasurementUnit),
          value: Text(
            controller.measurementUnit != null
                ? Translator.getTranslation(context, controller.measurementUnit)
                : localizations.notSet,
          ),
          onTap: (context) async {
            var result = await showDialog<MeasurementUnit>(
              context: context,
              builder: (context) => MeasurementUnitDialog(
                currentValue:
                    controller.measurementUnit ?? MeasurementUnit.metric,
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
          prefix: const Icon(Symbols.person_play),
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
            icon: const Icon(Symbols.info_rounded),
            color: Theme.of(context).colorScheme.primary,
          ),
          onTap: (context) async {
            var result = await showDialog<Gender>(
              context: context,
              builder: (context) => GenderDialog(
                currentValue: controller.gender ?? Gender.values.pickRandom(),
              ),
            );
            controller.updateGender(result);
          },
        ),
        MaterialBasicSettingsTile(
          prefix: const Icon(Symbols.calendar_month),
          title: Text(localizations.settingDateOfBirth),
          description: Text(
            controller.dateOfBirth != null
                ? localizations.settingDateOfBirthValue(
                    controller.dateOfBirth!,
                    (DateTime.now().difference(controller.dateOfBirth!).inDays /
                            365.0)
                        .round(),
                  )
                : localizations.notSet,
          ),
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
          prefix: const Icon(Symbols.height),
          title: Text(localizations.settingHeight),
          description: Text(controller.heightString ?? localizations.notSet),
          onTap: (context) async {
            var result = await showDialog<double>(
              context: context,
              builder: (context) => HeightInputDialog(
                measurementUnit:
                    controller.measurementUnit ?? MeasurementUnit.metric,
                currentValue: controller.height ?? 0,
              ),
            );
            controller.updateHeight(result);
          },
        ),
        MaterialBasicSettingsTile(
          prefix: const Icon(Symbols.scale),
          title: Text(localizations.settingWeight),
          description: Text(controller.weightString ?? localizations.notSet),
          onTap: (context) async {
            var result = await showDialog<double>(
              context: context,
              builder: (context) => WeightInputDialog(
                measurementUnit:
                    controller.measurementUnit ?? MeasurementUnit.metric,
                currentValue: controller.weight ?? 0,
              ),
            );
            controller.updateWeight(result);
          },
        ),
      ],
    );
  }

  /// Get the settings section for information about the app
  Widget getAboutSection(BuildContext context, AppLocalizations localizations) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, packageInfoSnapshot) => MaterialSettingsSection(
        title: Text(localizations.settingsAboutSection),
        margin: const EdgeInsetsDirectional.all(10),
        tiles: [
          MaterialBasicSettingsTile(
            prefix: const Icon(Symbols.tag),
            title: Text(localizations.settingAboutVersion),
            value: packageInfoSnapshot.hasData
                ? Text(packageInfoSnapshot.data!.version)
                : null,
            enabled: false,
          ),
          MaterialBasicSettingsTile(
            prefix: const Icon(
              Symbols.favorite_border_rounded,
              color: Color(0xFFCE364A),
            ),
            title: Text(localizations.settingAboutPackages),
            onTap: (context) => showLicensePage(
              context: context,
              applicationName: localizations.appTitle,
              applicationVersion: packageInfoSnapshot.hasData
                  ? packageInfoSnapshot.data!.version
                  : null,
            ),
          )
        ],
      ),
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
              getAboutSection(context, localizations),
            ],
          ),
        ),
      ),
    );
  }
}

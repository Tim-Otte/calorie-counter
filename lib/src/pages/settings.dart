import 'package:calorie_counter/src/extensions/android_device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/all.dart';
import '../controllers/settings_controller.dart';
import '../data/all.dart';
import '../services/all.dart';
import '../tools/all.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  /// Get the settings section for the general settings
  Widget _getGeneralSettingsSection(
    BuildContext context,
    AppLocalizations localizations,
  ) {
    final settingsController = Provider.of<SettingsController>(context);

    return FutureBuilder(
      future: DeviceInfoPlugin().androidInfo,
      builder: (context, androidInfoSnapshot) => MaterialSettingsSection(
        title: Text(localizations.settingsGeneralSection),
        tiles: [
          MaterialBasicSettingsTile(
            prefix: const Icon(Symbols.palette_rounded),
            title: Text(localizations.settingTheme),
            value: Text(
              Translator.getTranslation(context, settingsController.themeMode),
            ),
            onTap: (context) async {
              var result = await showDialog<ThemeMode>(
                context: context,
                builder: (context) => ThemeModeDialog(
                  currentValue: settingsController.themeMode,
                ),
              );
              settingsController.updateThemeMode(result);
            },
          ),
          MaterialSwitchSettingsTile(
            prefix: const Icon(Symbols.format_paint_rounded),
            title: Text(localizations.settingMaterialYou),
            description: Text(localizations.settingMaterialYouSubtitle),
            value: settingsController.useMaterialYou,
            enabled: androidInfoSnapshot.hasData &&
                androidInfoSnapshot.data!.getMajorVersion() >= 12,
            onToggle: (value) => settingsController.updateUseMaterialYou(value),
          ),
          MaterialBasicSettingsTile(
            prefix: const Icon(Symbols.translate_rounded),
            title: Text(localizations.settingLanguage),
            value: Text(
              settingsController.locale != null
                  ? LocaleNames.of(context)!
                      .nameOf(settingsController.locale!.languageCode)!
                  : localizations.systemDefault,
            ),
            onTap: (context) async {
              var result = await showDialog<String?>(
                context: context,
                builder: (context) => LanguageDialog(
                  currentLocale: settingsController.locale?.languageCode ??
                      localizations.localeName,
                ),
              );
              settingsController.updateLocale(result);
            },
          ),
          MaterialBasicSettingsTile(
            prefix: const Icon(Symbols.straighten_rounded),
            title: Text(localizations.settingMeasurementUnit),
            value: Text(
              settingsController.isMeasurementUnitSet
                  ? Translator.getTranslation(
                      context, settingsController.measurementUnit)
                  : localizations.notSet,
            ),
            onTap: (context) async {
              var result = await showDialog<MeasurementUnit>(
                context: context,
                builder: (context) => MeasurementUnitDialog(
                  currentValue: settingsController.measurementUnit,
                ),
              );
              settingsController.updateMeasurementUnit(result);
            },
          )
        ],
      ),
    );
  }

  /// Get the settings section for information about the app
  Widget _getAboutSection(
      BuildContext context, AppLocalizations localizations) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, packageInfoSnapshot) => MaterialSettingsSection(
        title: Text(localizations.settingsAboutSection),
        tiles: [
          MaterialBasicSettingsTile(
            prefix: const Icon(Symbols.tag_rounded),
            title: Text(localizations.settingAboutVersion),
            value: packageInfoSnapshot.hasData
                ? Text(packageInfoSnapshot.data!.version)
                : null,
            enabled: false,
          ),
          MaterialBasicSettingsTile(
            prefix: Icon(
              Symbols.nutrition_rounded,
              color: FoodFactService.brandColor,
            ),
            suffix: Icon(
              Symbols.open_in_new_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(localizations.settingAboutOpenFoodFacts),
            description: Text(localizations.settingAboutOpenFoodFactsSubtitle),
            onTap: (context) async => await launchUrl(
              FoodFactService.brandUri,
              mode: LaunchMode.inAppBrowserView,
            ),
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
              _getGeneralSettingsSection(context, localizations),
              _getAboutSection(context, localizations),
            ],
          ),
        ),
      ),
    );
  }
}

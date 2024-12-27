import 'package:calorie_counter/src/extensions/android_device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/all.dart';
import '../controllers/settings_controller.dart';
import '../data/all.dart';
import '../services/all.dart';
import '../tools/all.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController _controller;

  const SettingsPage({super.key, required SettingsController controller})
      : _controller = controller;

  /// Get the settings section for the general settings
  Widget _getGeneralSettingsSection(
      BuildContext context, AppLocalizations localizations) {
    return FutureBuilder(
      future: DeviceInfoPlugin().androidInfo,
      builder: (context, androidInfoSnapshot) => MaterialSettingsSection(
        margin: const EdgeInsetsDirectional.all(10),
        title: Text(localizations.settingsGeneralSection),
        tiles: [
          MaterialBasicSettingsTile(
            prefix: const Icon(Symbols.palette_rounded),
            title: Text(localizations.settingTheme),
            value: Text(
              Translator.getTranslation(context, _controller.themeMode),
            ),
            onTap: (context) async {
              var result = await showDialog<ThemeMode>(
                context: context,
                builder: (context) => ThemeModeDialog(
                  currentValue: _controller.themeMode,
                ),
              );
              _controller.updateThemeMode(result);
            },
          ),
          MaterialSwitchSettingsTile(
            prefix: const Icon(Symbols.format_paint_rounded),
            title: Text(localizations.settingMaterialYou),
            description: Text(localizations.settingMaterialYouSubtitle),
            value: _controller.useMaterialYou,
            enabled: androidInfoSnapshot.hasData &&
                androidInfoSnapshot.data!.getMajorVersion() >= 12,
            onToggle: (value) => _controller.updateUseMaterialYou(value),
          ),
          MaterialBasicSettingsTile(
            prefix: const Icon(Symbols.translate_rounded),
            title: Text(localizations.settingLanguage),
            value: Text(
              _controller.locale != null
                  ? LocaleNames.of(context)!
                      .nameOf(_controller.locale!.languageCode)!
                  : localizations.systemDefault,
            ),
            onTap: (context) async {
              var result = await showDialog<String?>(
                context: context,
                builder: (context) => LanguageDialog(
                  currentLocale: _controller.locale?.languageCode ??
                      localizations.localeName,
                ),
              );
              _controller.updateLocale(result);
            },
          ),
          MaterialBasicSettingsTile(
            prefix: const Icon(Symbols.straighten_rounded),
            title: Text(localizations.settingMeasurementUnit),
            value: Text(
              _controller.measurementUnit != null
                  ? Translator.getTranslation(
                      context, _controller.measurementUnit)
                  : localizations.notSet,
            ),
            onTap: (context) async {
              var result = await showDialog<MeasurementUnit>(
                context: context,
                builder: (context) => MeasurementUnitDialog(
                  currentValue:
                      _controller.measurementUnit ?? MeasurementUnit.metric,
                ),
              );
              _controller.updateMeasurementUnit(result);
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
        margin: const EdgeInsetsDirectional.all(10),
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

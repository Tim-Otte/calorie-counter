import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import 'all.dart' show SettingsPage, AboutPersonalDataPage;
import '../components/all.dart';
import '../controllers/settings_controller.dart';
import '../extensions/enumerable.dart';
import '../data/all.dart';
import '../tools/all.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Provider.of<SettingsController>(context);
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      restorationId: 'profile',
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profilePageTitle),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: Icon(
              Symbols.settings_rounded,
              color: theme.colorScheme.primary,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            MaterialSettingsSection(
              tiles: [
                MaterialBasicSettingsTile(
                  prefix: const Icon(Symbols.person_play_rounded),
                  title: Text(localizations.profileGender),
                  value: Text(
                    settingsController.gender != null
                        ? Translator.getTranslation(
                            context, settingsController.gender)
                        : localizations.notSet,
                  ),
                  onTap: (context) async {
                    var result = await showDialog<Gender>(
                      context: context,
                      builder: (context) => GenderDialog(
                        currentValue: settingsController.gender ??
                            Gender.values.pickRandom(),
                      ),
                    );
                    settingsController.updateGender(result);
                  },
                ),
                MaterialBasicSettingsTile(
                  prefix: const Icon(Symbols.calendar_month_rounded),
                  title: Text(localizations.profileDateOfBirth),
                  description: Text(
                    settingsController.dateOfBirth != null
                        ? localizations.profileDateOfBirthValue(
                            settingsController.dateOfBirth!,
                            settingsController.age!,
                          )
                        : localizations.notSet,
                  ),
                  onTap: (context) async {
                    var result = await showDatePicker(
                      context: context,
                      initialDatePickerMode:
                          settingsController.dateOfBirth == null
                              ? DatePickerMode.year
                              : DatePickerMode.day,
                      firstDate: DateTime(
                          DateTime.now().year - 100, DateTime.january, 1),
                      lastDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      initialDate: settingsController.dateOfBirth,
                    );
                    settingsController.updateDateOfBirth(result);
                  },
                ),
                MaterialBasicSettingsTile(
                  prefix: const Icon(Symbols.height_rounded),
                  title: Text(localizations.profileHeight),
                  description: Text(
                      settingsController.heightString ?? localizations.notSet),
                  onTap: (context) async {
                    var result = await showDialog<double>(
                      context: context,
                      builder: (context) => HeightInputDialog(
                        measurementUnit: settingsController.measurementUnit ??
                            MeasurementUnit.metric,
                        currentValue: settingsController.height ?? 0,
                      ),
                    );
                    settingsController.updateHeight(result);
                  },
                ),
                MaterialBasicSettingsTile(
                  prefix: const Icon(Symbols.scale_rounded),
                  title: Text(localizations.profileWeight),
                  description: Text(
                      settingsController.weightString ?? localizations.notSet),
                  onTap: (context) async {
                    var result = await showDialog<double>(
                      context: context,
                      builder: (context) => WeightInputDialog(
                        measurementUnit: settingsController.measurementUnit ??
                            MeasurementUnit.metric,
                        currentValue: settingsController.weight ?? 0,
                      ),
                    );
                    settingsController.updateWeight(result);
                  },
                ),
                MaterialBasicSettingsTile(
                  prefix: const Icon(Symbols.measuring_tape_rounded),
                  title: Text(localizations.profileWaistCircumference),
                  description: Text(
                      settingsController.waistCircumferenceString ??
                          localizations.notSet),
                  onTap: (context) async {
                    var result = await showDialog<double>(
                      context: context,
                      builder: (context) => WaistCircumferenceInputDialog(
                        measurementUnit: settingsController.measurementUnit ??
                            MeasurementUnit.metric,
                        currentValue:
                            settingsController.waistCircumference ?? 0,
                      ),
                    );
                    settingsController.updateWaistCircumference(result);
                  },
                ),
                MaterialBasicSettingsTile(
                  prefix: const Icon(Symbols.directions_run_rounded),
                  title: Text(localizations.profileActivityLevel),
                  value: Text(
                    settingsController.activityLevel != null
                        ? Translator.getTranslation(
                            context,
                            settingsController.activityLevel,
                          )
                        : localizations.notSet,
                  ),
                  onTap: (context) async {
                    var result = await showDialog<ActivityLevel>(
                      context: context,
                      builder: (context) => ActivityLevelDialog(
                        currentValue: settingsController.activityLevel ??
                            ActivityLevel.values.pickRandom(),
                      ),
                    );
                    settingsController.updateActivityLevel(result);
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Divider(),
            ),
            MaterialSettingsSection(tiles: [
              MaterialBasicSettingsTile(
                prefix: const Icon(Symbols.query_stats_rounded),
                title: Text(localizations.profileDataUsageTitle),
                description: Text(localizations.profileDataUsageSubtitle),
                suffix: const Icon(Symbols.chevron_forward_rounded),
                onTap: (context) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPersonalDataPage(),
                  ),
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}

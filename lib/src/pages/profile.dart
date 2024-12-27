import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'settings.dart';
import '../components/all.dart';
import '../controllers/settings_controller.dart';
import '../extensions/enumerable.dart';
import '../data/all.dart';
import '../tools/all.dart';

class ProfilePage extends StatelessWidget {
  final SettingsController _controller;

  const ProfilePage({super.key, required SettingsController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      restorationId: 'profile',
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profilePageTitle),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: const Icon(Symbols.info_rounded),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => const AboutPersonalDataBtmSheet(),
              isScrollControlled: true,
              useSafeArea: true,
              showDragHandle: true,
              enableDrag: true,
            ),
          ),
          IconButton(
            icon: Icon(Symbols.settings_rounded),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(controller: _controller),
              ),
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: MaterialSettingsSection(
          margin: const EdgeInsetsDirectional.all(10),
          tiles: [
            MaterialBasicSettingsTile(
              prefix: const Icon(Symbols.person_play_rounded),
              title: Text(localizations.profileGender),
              value: Text(
                _controller.gender != null
                    ? Translator.getTranslation(context, _controller.gender)
                    : localizations.notSet,
              ),
              disableSuffixPadding: true,
              onTap: (context) async {
                var result = await showDialog<Gender>(
                  context: context,
                  builder: (context) => GenderDialog(
                    currentValue:
                        _controller.gender ?? Gender.values.pickRandom(),
                  ),
                );
                _controller.updateGender(result);
              },
            ),
            MaterialBasicSettingsTile(
              prefix: const Icon(Symbols.calendar_month_rounded),
              title: Text(localizations.profileDateOfBirth),
              description: Text(
                _controller.dateOfBirth != null
                    ? localizations.profileDateOfBirthValue(
                        _controller.dateOfBirth!,
                        (DateTime.now()
                                    .difference(_controller.dateOfBirth!)
                                    .inDays /
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
                  initialDate: _controller.dateOfBirth,
                );
                _controller.updateDateOfBirth(result);
              },
            ),
            MaterialBasicSettingsTile(
              prefix: const Icon(Symbols.height_rounded),
              title: Text(localizations.profileHeight),
              description:
                  Text(_controller.heightString ?? localizations.notSet),
              onTap: (context) async {
                var result = await showDialog<double>(
                  context: context,
                  builder: (context) => HeightInputDialog(
                    measurementUnit:
                        _controller.measurementUnit ?? MeasurementUnit.metric,
                    currentValue: _controller.height ?? 0,
                  ),
                );
                _controller.updateHeight(result);
              },
            ),
            MaterialBasicSettingsTile(
              prefix: const Icon(Symbols.scale_rounded),
              title: Text(localizations.profileWeight),
              description:
                  Text(_controller.weightString ?? localizations.notSet),
              onTap: (context) async {
                var result = await showDialog<double>(
                  context: context,
                  builder: (context) => WeightInputDialog(
                    measurementUnit:
                        _controller.measurementUnit ?? MeasurementUnit.metric,
                    currentValue: _controller.weight ?? 0,
                  ),
                );
                _controller.updateWeight(result);
              },
            ),
            MaterialBasicSettingsTile(
              prefix: const Icon(Symbols.measuring_tape_rounded),
              title: Text(localizations.profileWaistCircumference),
              description: Text(
                  _controller.waistCircumferenceString ?? localizations.notSet),
              onTap: (context) async {
                var result = await showDialog<double>(
                  context: context,
                  builder: (context) => WaistCircumferenceInputDialog(
                    measurementUnit:
                        _controller.measurementUnit ?? MeasurementUnit.metric,
                    currentValue: _controller.waistCircumference ?? 0,
                  ),
                );
                _controller.updateWaistCircumference(result);
              },
            ),
          ],
        ),
      ),
    );
  }
}

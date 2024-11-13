import 'dart:io';

import 'package:flutter/material.dart';

import '../data/enums/all.dart';
import '../tools/all.dart';
import '../services/all.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService, this._foodfactService);

  final SettingsService _settingsService;
  final FoodFactService _foodfactService;

  ThemeMode _themeMode = ThemeMode.system;
  String? _locale;
  MeasurementUnit? _measurementUnit;
  Gender? _gender;
  DateTime? _dateOfBirth;
  double? _height;
  double? _weight;

  ThemeMode get themeMode => _themeMode;
  Locale? get locale =>
      _locale != null ? Locale.fromSubtags(languageCode: _locale!) : null;
  MeasurementUnit? get measurementUnit => _measurementUnit;
  Gender? get gender => _gender;
  DateTime? get dateOfBirth => _dateOfBirth;

  double? get height => _height;
  String? get heightString {
    if (height == null) return null;

    if (measurementUnit == null || measurementUnit == MeasurementUnit.metric) {
      return "${height!.round()} cm";
    } else {
      var imperial = UnitConverter.heightToImperial(height!);
      return "${imperial.feet.round()}' ${imperial.inches.round()}\"";
    }
  }

  double? get weight => _weight;
  String? get weightString {
    if (weight == null) return null;

    if (measurementUnit == null || measurementUnit == MeasurementUnit.metric) {
      return "${weight!.toStringAsFixed(1)} kg";
    } else {
      var imperial = UnitConverter.weightToImperial(weight!);
      return "${imperial.toStringAsFixed(1)} lb";
    }
  }

  /// Load the user's settings from the SettingsService
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.getThemeMode();
    _locale = await _settingsService.getLocale();
    _measurementUnit = await _settingsService.getMeasurementUnit();
    _gender = await _settingsService.getGender();
    _dateOfBirth = await _settingsService.getDateOfBirth();
    _height = await _settingsService.getHeight();
    _weight = await _settingsService.getWeight();

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    _foodfactService.setLanguage(
        locale ?? Locale.fromSubtags(languageCode: Platform.localeName));
  }

  /// Update and persist the ThemeMode
  Future<void> updateThemeMode(ThemeMode? value) async {
    if (value == null || value == _themeMode) return;

    _themeMode = value;
    notifyListeners();
    await _settingsService.updateThemeMode(value);
  }

  /// Update and persist the locale
  Future<void> updateLocale(String? value) async {
    if (value == null || value == _locale) return;

    _locale = value;
    notifyListeners();
    await _settingsService.updateLocale(value);
    _foodfactService.setLanguage(Locale.fromSubtags(languageCode: value));
  }

  /// Update and persist the MeasurementUnit
  Future<void> updateMeasurementUnit(MeasurementUnit? value) async {
    if (value == null || value == _measurementUnit) return;

    _measurementUnit = value;
    notifyListeners();
    await _settingsService.updateMeasurementUnit(value);
  }

  /// Update and persist the Gender
  Future<void> updateGender(Gender? value) async {
    if (value == null || value == _gender) return;

    _gender = value;
    notifyListeners();
    await _settingsService.updateGender(value);
  }

  /// Update and persist the date of birth
  Future<void> updateDateOfBirth(DateTime? value) async {
    if (value == null || value == _dateOfBirth) return;

    _dateOfBirth = value;
    notifyListeners();
    await _settingsService.updateDateOfBirth(value);
  }

  /// Update and persist the height
  Future<void> updateHeight(double? value) async {
    if (value == null || value == _height) return;

    _height = value;
    notifyListeners();
    await _settingsService.updateHeight(value);
  }

  /// Update and persist the weight
  Future<void> updateWeight(double? value) async {
    if (value == null || value == _weight) return;

    _weight = value;
    notifyListeners();
    await _settingsService.updateWeight(value);
  }
}
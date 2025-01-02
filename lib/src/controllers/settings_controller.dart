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
  bool _useMaterialYou = false;
  String? _locale;
  MeasurementUnit? _measurementUnit;
  Gender? _gender;
  DateTime? _dateOfBirth;
  double? _height;
  double? _weight;
  double? _waistCircumference;
  ActivityLevel? _activityLevel;

  ThemeMode get themeMode => _themeMode;
  bool get useMaterialYou => _useMaterialYou;
  Locale? get locale =>
      _locale != null ? Locale.fromSubtags(languageCode: _locale!) : null;
  MeasurementUnit? get measurementUnit => _measurementUnit;
  Gender? get gender => _gender;
  DateTime? get dateOfBirth => _dateOfBirth;

  int? get age {
    if (dateOfBirth == null) return null;

    const avgLengthOfYear = 365.2425;

    return (DateTime.now().difference(dateOfBirth!).inDays / avgLengthOfYear)
        .floor();
  }

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
      var imperial = UnitConverter.kilogrammesToPounds(weight!);
      return "${imperial.toStringAsFixed(1)} lb";
    }
  }

  double? get waistCircumference => _waistCircumference;
  String? get waistCircumferenceString {
    if (waistCircumference == null) return null;

    if (measurementUnit == null || measurementUnit == MeasurementUnit.metric) {
      return "${waistCircumference!.toStringAsFixed(1)} cm";
    } else {
      var imperial = UnitConverter.centimetersToInches(waistCircumference!);
      return "${imperial.toStringAsFixed(1)}\"";
    }
  }

  ActivityLevel? get activityLevel => _activityLevel;

  /// Load the user's settings from the SettingsService
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.getThemeMode();
    _useMaterialYou = await _settingsService.getUseMaterialYou();
    _locale = await _settingsService.getLocale();
    _measurementUnit = await _settingsService.getMeasurementUnit();
    _gender = await _settingsService.getGender();
    _dateOfBirth = await _settingsService.getDateOfBirth();
    _height = await _settingsService.getHeight();
    _weight = await _settingsService.getWeight();
    _waistCircumference = await _settingsService.getWaistCircumference();
    _activityLevel = await _settingsService.getActivityLevel();

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

  /// Update and persist the Material You preference
  Future<void> updateUseMaterialYou(bool value) async {
    if (value == _useMaterialYou) return;

    _useMaterialYou = value;
    notifyListeners();
    await _settingsService.updateUseMaterialYou(value);
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

  /// Update and persist the hip circumference
  Future<void> updateWaistCircumference(double? value) async {
    if (value == null || value == _waistCircumference) return;

    _waistCircumference = value;
    notifyListeners();
    await _settingsService.updateWaistCircumference(value);
  }

  /// Update and persist the activity level
  Future<void> updateActivityLevel(ActivityLevel? value) async {
    if (value == null || value == _activityLevel) return;

    _activityLevel = value;
    notifyListeners();
    await _settingsService.updateActivityLevel(value);
  }

  /// Calculate the Total Daily Energy Expenditure (TDEE) based on the user's settings.
  /// The TDEE is the number of calories the user needs to consume daily to maintain
  /// their current weight.
  double calculateTDEE() {
    double bmr = _calculateBMR();

    return bmr *
        switch (activityLevel) {
          ActivityLevel.sedentary => 1.2,
          ActivityLevel.lightlyActive => 1.375,
          ActivityLevel.moderatelyActive => 1.55,
          ActivityLevel.active => 1.725,
          ActivityLevel.veryActive => 1.9,
          _ => 1.0,
        };
  }

  /// Calculates the Basal Metabolic Rate (BMR) based on the user's weight, height,
  /// date of birth, and gender.
  ///
  /// The formula used is a variation of the
  /// [Mifflin-St Jeor Equation](https://en.wikipedia.org/wiki/Harris–Benedict_equation):
  /// - For males: `calories = (9.99 * weight) + (6.25 * height) - (4.92 * age) + 5`
  /// - For females: `calories = (9.99 * weight) + (6.25 * height) - (4.92 * age) - 161`
  ///
  /// If the gender is not specified, the base calorie calculation is returned without
  /// the gender adjustment.
  double _calculateBMR() {
    double bmr =
        (9.99 * (weight ?? 0)) + (6.25 * (height ?? 0)) - (4.92 * (age ?? 0));

    if (gender == Gender.male) {
      return bmr + 5;
    } else if (gender == Gender.female) {
      return bmr - 161;
    } else {
      return bmr;
    }
  }

  /// Calculates the daily carbohydrate intake range (45% to 65% of TDEE).
  /// Returns the range in grams.
  ({double min, double max}) calculateMinMaxDailyCarbs() {
    return _calcMinMax(calculateTDEE(), 0.45, 0.65, 4);
  }

  /// Calculates the daily fat intake range (20% to 35% of TDEE).
  /// Returns the range in grams.
  ({double min, double max}) calculateMinMaxDailyFats() {
    return _calcMinMax(calculateTDEE(), 0.2, 0.35, 9);
  }

  /// Calculates the daily protein intake range (10% to 35% of TDEE).
  /// Returns the range in grams.
  ({double min, double max}) calculateMinMaxDailyProteins() {
    return _calcMinMax(calculateTDEE(), 0.1, 0.35, 4);
  }

  /// Calculates an allowed range of any nutriment based on the user's TDEE
  ///  and the calories per gram for that nutriment.
  ({double min, double max}) _calcMinMax(
    double caloriesPerDay,
    double minPercentage,
    double maxPercentage,
    double caloriesPerGram,
  ) {
    return (
      min: caloriesPerDay * minPercentage / caloriesPerGram,
      max: caloriesPerDay * maxPercentage / caloriesPerGram
    );
  }
}

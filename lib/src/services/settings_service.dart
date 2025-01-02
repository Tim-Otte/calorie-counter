import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/enums/all.dart';

/// A service that stores and retrieves user settings.
class SettingsService {
  final asyncPrefs = SharedPreferencesAsync();

  /// Loads the user's preferred ThemeMode.
  Future<ThemeMode> getThemeMode() {
    return asyncPrefs.getInt('themeMode').then(
        (value) => value != null ? ThemeMode.values[value] : ThemeMode.system);
  }

  /// Saves the user's preferred ThemeMode.
  Future<void> updateThemeMode(ThemeMode value) {
    return asyncPrefs.setInt('themeMode', value.index);
  }

  /// Loads the user's preference regarding Material You.
  Future<bool> getUseMaterialYou() {
    return asyncPrefs.getBool('useMaterialYou').then((value) => value ?? false);
  }

  /// Saves the user's preference regarding Material You.
  Future<void> updateUseMaterialYou(bool value) {
    return asyncPrefs.setBool('useMaterialYou', value);
  }

  /// Loads the user's preferred locale.
  Future<String?> getLocale() {
    return asyncPrefs.getString('locale');
  }

  /// Saves the user's preferred locale.
  Future<void> updateLocale(String value) {
    return asyncPrefs.setString('locale', value);
  }

  /// Loads the user's preferred MeasurementUnit.
  Future<MeasurementUnit?> getMeasurementUnit() {
    return asyncPrefs
        .getInt('measurementUnit')
        .then((value) => value != null ? MeasurementUnit.values[value] : null);
  }

  /// Saves the user's preferred MeasurementUnit.
  Future<void> updateMeasurementUnit(MeasurementUnit value) {
    return asyncPrefs.setInt('measurementUnit', value.index);
  }

  /// Loads the user's gender.
  Future<Gender?> getGender() {
    return asyncPrefs
        .getInt('gender')
        .then((value) => value != null ? Gender.values[value] : null);
  }

  /// Saves the user's gender.
  Future<void> updateGender(Gender value) {
    return asyncPrefs.setInt('gender', value.index);
  }

  /// Loads the user's date of birth.
  Future<DateTime?> getDateOfBirth() {
    return asyncPrefs.getInt('dateOfBirth').then((value) =>
        value != null ? DateTime.fromMillisecondsSinceEpoch(value) : null);
  }

  /// Saves the user's date of birth.
  Future<void> updateDateOfBirth(DateTime value) {
    return asyncPrefs.setInt('dateOfBirth', value.millisecondsSinceEpoch);
  }

  /// Loads the user's height.
  Future<double?> getHeight() {
    return asyncPrefs.getDouble('height');
  }

  /// Saves the user's height.
  Future<void> updateHeight(double value) {
    return asyncPrefs.setDouble('height', value);
  }

  /// Loads the user's weight.
  Future<double?> getWeight() {
    return asyncPrefs.getDouble('weight');
  }

  /// Saves the user's weight.
  Future<void> updateWeight(double value) {
    return asyncPrefs.setDouble('weight', value);
  }

  /// Loads the user's hip circumference.
  Future<double?> getWaistCircumference() {
    return asyncPrefs.getDouble('waistCircumference');
  }

  /// Saves the user's hip circumference.
  Future<void> updateWaistCircumference(double value) {
    return asyncPrefs.setDouble('waistCircumference', value);
  }

  /// Loads the user's activity level.
  Future<ActivityLevel?> getActivityLevel() {
    return asyncPrefs
        .getInt('activityLevel')
        .then((value) => value != null ? ActivityLevel.values[value] : null);
  }

  /// Saves the user's activity level.
  Future<void> updateActivityLevel(ActivityLevel value) {
    return asyncPrefs.setInt('activityLevel', value.index);
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/enums/all.dart';

/// A service that stores and retrieves user settings.
class SettingsService {
  /// Loads the user's preferred ThemeMode.
  Future<ThemeMode> getThemeMode() {
    return SharedPreferencesAsync().getInt('themeMode').then(
        (value) => value != null ? ThemeMode.values[value] : ThemeMode.system);
  }

  /// Saves the user's preferred ThemeMode.
  Future<void> updateThemeMode(ThemeMode value) {
    return SharedPreferencesAsync().setInt('themeMode', value.index);
  }

  /// Loads the user's preference regarding Material You.
  Future<bool> getUseMaterialYou() {
    return SharedPreferencesAsync()
        .getBool('useMaterialYou')
        .then((value) => value ?? false);
  }

  /// Saves the user's preference regarding Material You.
  Future<void> updateUseMaterialYou(bool value) {
    return SharedPreferencesAsync().setBool('useMaterialYou', value);
  }

  /// Loads the user's preferred locale.
  Future<String?> getLocale() {
    return SharedPreferencesAsync().getString('locale');
  }

  /// Saves the user's preferred locale.
  Future<void> updateLocale(String value) {
    return SharedPreferencesAsync().setString('locale', value);
  }

  /// Loads the user's preferred MeasurementUnit.
  Future<MeasurementUnit?> getMeasurementUnit() {
    return SharedPreferencesAsync()
        .getInt('measurementUnit')
        .then((value) => value != null ? MeasurementUnit.values[value] : null);
  }

  /// Saves the user's preferred MeasurementUnit.
  Future<void> updateMeasurementUnit(MeasurementUnit value) {
    return SharedPreferencesAsync().setInt('measurementUnit', value.index);
  }

  /// Loads the user's gender.
  Future<Gender?> getGender() {
    return SharedPreferencesAsync()
        .getInt('gender')
        .then((value) => value != null ? Gender.values[value] : null);
  }

  /// Saves the user's gender.
  Future<void> updateGender(Gender value) {
    return SharedPreferencesAsync().setInt('gender', value.index);
  }

  /// Loads the user's date of birth.
  Future<DateTime?> getDateOfBirth() {
    return SharedPreferencesAsync().getInt('dateOfBirth').then((value) =>
        value != null ? DateTime.fromMillisecondsSinceEpoch(value) : null);
  }

  /// Saves the user's date of birth.
  Future<void> updateDateOfBirth(DateTime value) {
    return SharedPreferencesAsync()
        .setInt('dateOfBirth', value.millisecondsSinceEpoch);
  }

  /// Loads the user's height.
  Future<double?> getHeight() {
    return SharedPreferencesAsync().getDouble('height');
  }

  /// Saves the user's height.
  Future<void> updateHeight(double value) {
    return SharedPreferencesAsync().setDouble('height', value);
  }

  /// Loads the user's weight.
  Future<double?> getWeight() {
    return SharedPreferencesAsync().getDouble('weight');
  }

  /// Saves the user's weight.
  Future<void> updateWeight(double value) {
    return SharedPreferencesAsync().setDouble('weight', value);
  }

  /// Loads the user's hip circumference.
  Future<double?> getWaistCircumference() {
    return SharedPreferencesAsync().getDouble('WaistCircumference');
  }

  /// Saves the user's hip circumference.
  Future<void> updateWaistCircumference(double value) {
    return SharedPreferencesAsync().setDouble('WaistCircumference', value);
  }
}

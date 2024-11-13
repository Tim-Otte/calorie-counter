import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/enums/all.dart';

/// A service that stores and retrieves user settings.
class SettingsService {
  /// Loads the User's preferred ThemeMode
  Future<ThemeMode> getThemeMode() {
    return SharedPreferencesAsync().getInt('themeMode').then(
        (value) => value != null ? ThemeMode.values[value] : ThemeMode.system);
  }

  /// Persists the user's preferred ThemeMode
  Future<void> updateThemeMode(ThemeMode value) {
    return SharedPreferencesAsync().setInt('themeMode', value.index);
  }

  /// Loads the User's preferred locale
  Future<String?> getLocale() {
    return SharedPreferencesAsync().getString('locale');
  }

  /// Persists the user's preferred locale
  Future<void> updateLocale(String value) {
    return SharedPreferencesAsync().setString('locale', value);
  }

  /// Loads the User's preferred MeasurementUnit
  Future<MeasurementUnit?> getMeasurementUnit() {
    return SharedPreferencesAsync()
        .getInt('measurementUnit')
        .then((value) => value != null ? MeasurementUnit.values[value] : null);
  }

  /// Persists the user's preferred MeasurementUnit
  Future<void> updateMeasurementUnit(MeasurementUnit value) {
    return SharedPreferencesAsync().setInt('measurementUnit', value.index);
  }

  /// Loads the User's Gender
  Future<Gender?> getGender() {
    return SharedPreferencesAsync()
        .getInt('gender')
        .then((value) => value != null ? Gender.values[value] : null);
  }

  /// Persists the user's Gender
  Future<void> updateGender(Gender value) {
    return SharedPreferencesAsync().setInt('gender', value.index);
  }

  /// Loads the User's Gender
  Future<DateTime?> getDateOfBirth() {
    return SharedPreferencesAsync().getInt('dateOfBirth').then((value) =>
        value != null ? DateTime.fromMillisecondsSinceEpoch(value) : null);
  }

  /// Persists the user's Gender
  Future<void> updateDateOfBirth(DateTime value) {
    return SharedPreferencesAsync()
        .setInt('dateOfBirth', value.millisecondsSinceEpoch);
  }

  /// Loads the User's height
  Future<double?> getHeight() {
    return SharedPreferencesAsync().getDouble('height');
  }

  /// Persists the user's height
  Future<void> updateHeight(double value) {
    return SharedPreferencesAsync().setDouble('height', value);
  }

  /// Loads the User's weight
  Future<double?> getWeight() {
    return SharedPreferencesAsync().getDouble('weight');
  }

  /// Persists the user's weight
  Future<void> updateWeight(double value) {
    return SharedPreferencesAsync().setDouble('weight', value);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/measurement_unit.dart';

class Translator {
  static String getTranslation<TEnum>(BuildContext context, TEnum enumValue) {
    if (enumValue is MeasurementUnit) {
      switch (enumValue) {
        case MeasurementUnit.metric:
          return AppLocalizations.of(context)!.measurementUnitMetric;
        case MeasurementUnit.imperial:
          return AppLocalizations.of(context)!.measurementUnitImperial;
        default:
          throw UnsupportedError(
              'There is no translation for the given measurement unit');
      }
    } else if (enumValue is ThemeMode) {
      switch (enumValue) {
        case ThemeMode.dark:
          return AppLocalizations.of(context)!.themeModeDark;
        case ThemeMode.light:
          return AppLocalizations.of(context)!.themeModeLight;
        case ThemeMode.system:
          return AppLocalizations.of(context)!.themeModeSystem;
        default:
          throw UnsupportedError(
              'There is no translation for the given theme mode');
      }
    } else {
      throw UnsupportedError('Unsupported enum type');
    }
  }

  static String getSubtitle(
      BuildContext context, MeasurementUnit measurementUnit) {
    switch (measurementUnit) {
      case MeasurementUnit.metric:
        return AppLocalizations.of(context)!.measurementUnitMetricSubtitle;
      case MeasurementUnit.imperial:
        return AppLocalizations.of(context)!.measurementUnitImperialSubtitle;
      default:
        throw UnsupportedError(
            'There is no translation for the given measurement unit subtitle');
    }
  }
}

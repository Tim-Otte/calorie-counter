import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

class RegularExpressions {
  static bool allowComma =
      (numberFormatSymbols[Intl.getCurrentLocale()]?.DECIMAL_SEP ?? '.') == ',';

  /// A [RegExp] to validate that the input is a valid weight
  static RegExp weightInputValidator = RegExp(
      "^((?:(?:[1-5][0-9])|(?:[1-9]))[0-9](?:${allowComma ? '[,.]' : '.'}[0-9])?)\$");

  /// A [RegExp] that defines which characters are allowed in the weight input
  static RegExp weightAllowedCharacters =
      RegExp("[0-9${allowComma ? ',.' : '.'}]");

  /// A [RegExp] to validate that the input is a valid hip circumference
  static RegExp hipCircumferenceInputValidator = RegExp(
      "^((?:(?:[1-9][0-9])|(?:[1-9]))[0-9](?:${allowComma ? '[,.]' : '.'}[0-9])?)\$");

  /// A [RegExp] that defines which characters are allowed in the hip circumference input
  static RegExp hipCircumferenceAllowedCharacters =
      RegExp("[0-9${allowComma ? ',.' : '.'}]");

  /// Returns depending on [isMetric] a [RegExp] to validate that the input is a valid height
  static RegExp getHeightInputValidator(bool isMetric) => RegExp(isMetric
          ? "^((?:[3-9][0-9])|(?:[1-2][0-9][0-9]))\$" // Allowing inputs between 30 and 299 cm
          : "^([1-9])'\\s?(?:((?:0?[0-9])|(?:1[0-1]))\")?\$" // Allowing inputs between 1 ft and 9 ft 11 in
      );

  /// A [RegExp] that defines which characters are allowed in the height input
  static RegExp getHeightAllowedCharacters(bool isMetric) =>
      RegExp(isMetric ? "[0-9]" : "[0-9'\"\\s]");

  /// A [RegExp] that defines which characters are allowed in a decimal input
  static RegExp decimalAllowedCharacters =
      RegExp("[0-9${allowComma ? ',.' : '.'}]");
}

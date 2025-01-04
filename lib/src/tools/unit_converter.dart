class UnitConverter {
  static const double cmInInch = 2.54;
  static const double cmInFoot = 30.48;
  static const double kgInPound = 0.453592;
  static const double gInOunzes = 28.3495;

  /// Converts height from centimeters to feet and inches.
  ///
  /// Returns a map with keys 'feet' and 'inches'.
  static ({double feet, double inches}) heightToImperial(double centimeters) {
    double feet = (centimeters - (centimeters % cmInFoot)) / cmInFoot;
    double inches = (centimeters - (feet * cmInFoot)) / cmInInch;

    return (feet: feet, inches: inches);
  }

  /// Converts height from feet and inches to centimeters.
  static double heightToMetric(double feet, double inches) {
    return (feet * cmInFoot) + (inches * cmInInch);
  }

  /// Converts centimeters to inches.
  static double centimetersToInches(double centimeters) {
    return centimeters / cmInInch;
  }

  /// Converts inches to centimeters.
  static double inchesToCentimeters(double inches) {
    return inches * cmInInch;
  }

  /// Converts kilogrammes to pounds.
  static double kilogrammesToPounds(double kilogrammes) {
    return kilogrammes / kgInPound;
  }

  /// Converts pounds to kilogrammes.
  static double poundsToKilogrammes(double pounds) {
    return pounds * kgInPound;
  }

  /// Converts grammes to ounces.
  static double gramsToOunzes(double grammes) {
    return grammes / gInOunzes;
  }
}

class UnitConverter {
  static const double cmInInch = 2.54;
  static const double cmInFoot = 30.48;
  static const double kgInPound = 0.453592;

  static ({double feet, double inches}) heightToImperial(double centimeters) {
    double feet = (centimeters - (centimeters % cmInFoot)) / cmInFoot;
    double inches = (centimeters - (feet * cmInFoot)) / cmInInch;

    return (feet: feet, inches: inches);
  }

  static double heightToMetric(double feet, double inches) {
    return (feet * cmInFoot) + (inches * cmInInch);
  }

  static double weightToImperial(double kilogrammes) {
    return kilogrammes / kgInPound;
  }

  static double weightToMetric(double pounds) {
    return pounds * kgInPound;
  }
}

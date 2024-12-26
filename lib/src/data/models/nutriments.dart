class Nutriments {
  final double calories;
  final double carbs;
  final double fats;
  final double proteins;

  const Nutriments({
    required this.calories,
    required this.carbs,
    required this.fats,
    required this.proteins,
  });

  static Nutriments get empty => const Nutriments(
        calories: 0,
        carbs: 0,
        fats: 0,
        proteins: 0,
      );
}

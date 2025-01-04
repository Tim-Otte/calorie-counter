enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  drink,
  other;

  /// Suggests a meal type based on the current hour of the day.
  ///
  /// The method uses the current hour to determine the appropriate meal type:
  /// - If the hour is less than or equal to 10, it suggests `MealType.breakfast`.
  /// - If the hour is less than or equal to 14, it suggests `MealType.lunch`.
  /// - Otherwise, it suggests `MealType.dinner`.
  ///
  /// Returns:
  ///   A [MealType] value representing the suggested meal type.
  static MealType suggest(bool isLiquid) => isLiquid
      ? MealType.drink
      : switch (DateTime.now().hour) {
          <= 10 => MealType.breakfast,
          <= 14 => MealType.lunch,
          _ => MealType.dinner,
        };
}

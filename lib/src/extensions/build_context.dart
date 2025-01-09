import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  /// Navigates to a new route and returns the result when the route is popped.
  ///
  /// This method uses the `Navigator.push` function to navigate to a new route
  /// defined by the `builder` function. The `builder` function takes the current
  /// `BuildContext` and returns a widget of type `TDestination`.
  ///
  /// The method returns a `Future` that completes to the result of type `TResult`
  /// when the new route is popped.
  ///
  /// Type Parameters:
  /// - [TResult]: The type of the result returned when the route is popped.
  /// - [TDestination]: The type of the widget to navigate to.
  ///
  /// Parameters:
  /// - [builder]: A function that takes the current `BuildContext` and returns
  ///   a widget of type `TDestination`.
  /// - [replace]: (Optional) Defines if the route should be pushed or replaced.
  ///
  /// Returns a `Future` that completes to the result of type `TResult` when the route is
  /// popped.
  Future<TResult?> navigateTo<TResult, TDestination extends Widget>(
    TDestination Function(BuildContext context) builder, {
    bool? replace,
  }) {
    final route =
        MaterialPageRoute<TResult>(builder: (context) => builder(this));

    return (replace ?? false)
        ? Navigator.pushReplacement(this, route)
        : Navigator.push(this, route);
  }
}

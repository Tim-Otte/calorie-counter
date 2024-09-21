import 'dart:math';

extension ListExtensions on List {
  T pickRandom<T>() {
    return this[Random().nextInt(length)];
  }
}

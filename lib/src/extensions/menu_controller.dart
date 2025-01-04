import 'package:flutter/material.dart';

extension MenuControllerExtensions on MenuController {
  void toggle() {
    if (isOpen) {
      close();
    } else {
      open();
    }
  }
}

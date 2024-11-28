import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

extension ScaffoldMessengerStateExtensions on ScaffoldMessengerState {
  void showError(String errorText) {
    showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Symbols.warning_rounded,
                  color: Theme.of(context).colorScheme.onError),
            ),
            Flexible(
              child: Text(errorText),
            ),
          ],
        ),
      ),
    );
  }
}

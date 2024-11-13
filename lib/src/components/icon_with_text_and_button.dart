import 'package:flutter/material.dart';

class IconWithTextAndButton {
  static List<Widget> get(BuildContext context,
      {required IconData icon,
      required String text,
      required IconData buttonIcon,
      required String buttonText,
      required VoidCallback onButtonPressed}) {
    return [
      Icon(icon, size: 75),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
      ElevatedButton.icon(
        onPressed: onButtonPressed,
        icon: Icon(buttonIcon),
        label: Text(buttonText),
      ),
    ];
  }
}

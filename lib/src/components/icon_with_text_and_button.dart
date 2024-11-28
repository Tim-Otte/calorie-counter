import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String text;

  const IconWithText({
    super.key,
    required this.icon,
    this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Icon(
              icon,
              size: 75,
              color: iconColor ?? theme.colorScheme.secondary.withOpacity(0.75),
            ),
          ),
          Text(
            text,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontStyle: FontStyle.italic,
              color: theme.textTheme.bodyLarge!.color!.withOpacity(0.75),
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  static Widget andButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required IconData buttonIcon,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
        ],
      ),
    );
  }
}

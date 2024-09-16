import 'package:flutter/material.dart';

import 'tile_type.dart';

class MaterialSettingsTile extends StatelessWidget {
  const MaterialSettingsTile({
    required this.tileType,
    this.leading,
    required this.title,
    this.description,
    this.onTap,
    this.onToggle,
    this.value,
    this.initialValue,
    required this.enabled,
    this.trailing,
    Key? key,
  }) : super(key: key);

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget? title;
  final Widget? description;
  final Function(BuildContext context)? onTap;
  final Function(bool value)? onToggle;
  final Widget? value;
  final bool? initialValue;
  final bool enabled;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled
              ? () {
                  if (onToggle != null) {
                    onToggle!.call(!(initialValue ?? false));
                  } else {
                    onTap?.call(context);
                  }
                }
              : null,
          highlightColor: theme.highlightColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Row(
            children: [
              // Icon
              if (leading != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24),
                  child: IconTheme(
                    data: theme.iconTheme,
                    child: leading!,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 24,
                    end: 24,
                    bottom: 19 * scaleFactor,
                    top: 19 * scaleFactor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          color: theme.textTheme.titleMedium!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        child: title ?? Container(),
                      ),
                      if (value != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                            child: value!,
                          ),
                        )
                      else if (description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                            child: description!,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (trailing != null) trailing!
            ],
          ),
        ),
      ),
    );
  }
}

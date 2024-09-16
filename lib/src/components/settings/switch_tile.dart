import 'package:calorie_counter/src/components/settings/tile.dart';
import 'package:flutter/material.dart';

import 'tile_type.dart';

class MaterialSwitchSettingsTile extends MaterialSettingsTile {
  MaterialSwitchSettingsTile({
    required Widget? leading,
    required Widget title,
    Widget? description,
    Widget? trailing,
    required Function(bool) onToggle,
    required bool value,
    bool enabled = true,
    Key? key,
  }) : super(
          tileType: SettingsTileType.switchTile,
          leading: leading,
          title: title,
          onToggle: onToggle,
          initialValue: value,
          enabled: enabled,
          key: key,
          description: description,
          trailing: trailing != null
              ? Row(
                  children: [
                    trailing,
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: Switch(
                        value: value,
                        onChanged: enabled ? onToggle : null,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
                  child: Switch(
                    value: value,
                    onChanged: enabled ? onToggle : null,
                  ),
                ),
        );
}

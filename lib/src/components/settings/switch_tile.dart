import 'package:calorie_counter/src/components/settings/tile.dart';
import 'package:flutter/material.dart';

import 'tile_type.dart';

class MaterialSwitchSettingsTile extends MaterialSettingsTile {
  MaterialSwitchSettingsTile({
    required super.leading,
    required Widget super.title,
    super.description,
    Widget? trailing,
    required Function(bool) super.onToggle,
    required bool value,
    super.enabled = true,
    super.key,
  }) : super(
          tileType: SettingsTileType.switchTile,
          initialValue: value,
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

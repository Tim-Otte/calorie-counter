import 'package:calorie_counter/src/components/settings/tile.dart';
import 'package:flutter/material.dart';

import 'tile_type.dart';

class MaterialBasicSettingsTile extends MaterialSettingsTile {
  MaterialBasicSettingsTile({
    Key? key,
    required Widget? leading,
    required Widget title,
    Widget? description,
    Widget? trailing,
    Widget? value,
    required Function(BuildContext) onTap,
    bool enabled = true,
  }) : super(
          key: key,
          tileType: SettingsTileType.switchTile,
          leading: leading,
          title: title,
          onTap: onTap,
          enabled: enabled,
          description: description,
          value: value,
          trailing: trailing != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: trailing,
                )
              : null,
        );
}

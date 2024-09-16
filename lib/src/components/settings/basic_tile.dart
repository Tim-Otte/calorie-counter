import 'package:calorie_counter/src/components/settings/tile.dart';
import 'package:flutter/material.dart';

import 'tile_type.dart';

class MaterialBasicSettingsTile extends MaterialSettingsTile {
  MaterialBasicSettingsTile({
    required Widget? leading,
    required Widget title,
    Widget? description,
    Widget? trailing,
    required Function(BuildContext) onTap,
    bool enabled = true,
    Key? key,
  }) : super(
          tileType: SettingsTileType.switchTile,
          leading: leading,
          title: title,
          onTap: onTap,
          enabled: enabled,
          key: key,
          description: description,
          trailing: trailing != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: trailing,
                )
              : null,
        );
}

import 'package:calorie_counter/src/components/settings/tile.dart';
import 'package:flutter/material.dart';

import 'tile_type.dart';

class MaterialNavigationSettingsTile extends MaterialSettingsTile {
  const MaterialNavigationSettingsTile({
    required Widget? leading,
    required Widget title,
    Widget? description,
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
          trailing: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.chevron_right),
          ),
        );
}

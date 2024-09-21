import 'package:calorie_counter/src/components/settings/tile.dart';
import 'package:flutter/material.dart';

import 'tile_type.dart';

class MaterialNavigationSettingsTile extends MaterialSettingsTile {
  const MaterialNavigationSettingsTile({
    required super.leading,
    required Widget super.title,
    super.description,
    required Function(BuildContext) super.onTap,
    super.enabled = true,
    super.key,
  }) : super(
          tileType: SettingsTileType.switchTile,
          trailing: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.chevron_right),
          ),
        );
}

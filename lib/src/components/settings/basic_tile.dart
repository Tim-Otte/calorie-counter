import 'package:calorie_counter/src/components/settings/tile.dart';
import 'package:flutter/material.dart';

import 'tile_type.dart';

class MaterialBasicSettingsTile extends MaterialSettingsTile {
  MaterialBasicSettingsTile({
    super.key,
    required super.prefix,
    required Widget super.title,
    super.description,
    Widget? suffix,
    super.value,
    required Function(BuildContext) super.onTap,
    super.enabled = true,
  }) : super(
          tileType: SettingsTileType.switchTile,
          suffix: suffix != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: suffix,
                )
              : null,
        );
}

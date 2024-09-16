import 'package:flutter/material.dart';

import 'tile.dart';

class MaterialSettingsSection extends StatelessWidget {
  const MaterialSettingsSection({
    required this.tiles,
    required this.margin,
    this.title,
    Key? key,
  }) : super(key: key);

  final List<MaterialSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return buildSectionBody(context);
  }

  Widget buildSectionBody(BuildContext context) {
    final tileList = buildTileList();

    if (title == null) {
      return tileList;
    }

    final theme = Theme.of(context);
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: 24 * scaleFactor,
            bottom: 10 * scaleFactor,
            start: 24,
            end: 24,
          ),
          child: DefaultTextStyle(
            style: theme.textTheme.titleMedium!,
            child: title!,
          ),
        ),
        Container(
          color: theme.colorScheme.background,
          child: tileList,
        ),
      ],
    );
  }

  Widget buildTileList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tiles.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => tiles[index],
    );
  }
}

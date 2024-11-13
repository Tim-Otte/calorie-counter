import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../data/database.dart';
import '../../pages/all.dart';

class ServingSizeSelector extends StatefulWidget {
  final ServingSizeData? initialValue;
  final Function(ServingSizeData? value)? onChanged;

  const ServingSizeSelector({super.key, this.initialValue, this.onChanged});

  @override
  State<ServingSizeSelector> createState() => _ServingSizeSelectorState();
}

class _ServingSizeSelectorState extends State<ServingSizeSelector> {
  ServingSizeData? _servingSize;

  @override
  void initState() {
    super.initState();
    _servingSize = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return InkWell(
      onTap: widget.onChanged == null
          ? null
          : () async {
              final result = await Navigator.push<ServingSizeData>(
                context,
                MaterialPageRoute(
                  builder: (_) => const SelectServingSizePage(),
                ),
              );
              setState(() => _servingSize = result);
              if (widget.onChanged != null) {
                widget.onChanged!(_servingSize);
              }
            },
      highlightColor: theme.highlightColor,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Symbols.list_alt_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${localizations.servingSize}:",
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      _servingSize?.name ?? localizations.notSet,
                      style: theme.textTheme.bodyMedium,
                    )
                  ],
                ),
              ],
            ),
            const Icon(Symbols.chevron_forward_rounded),
          ],
        ),
      ),
    );
  }
}

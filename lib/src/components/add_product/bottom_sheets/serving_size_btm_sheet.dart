import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../data/all.dart' show ServingSizeData;
import '../../../data/models/all.dart' show ServingSizeTemplate;
import '../../all.dart' as c;

class ServingSizeBtmSheet extends StatefulWidget {
  final ServingSizeTemplate? initialValue;
  final List<ServingSizeData> baseServingSizes;
  final bool isEditMode;

  const ServingSizeBtmSheet({
    super.key,
    this.initialValue,
    required this.baseServingSizes,
    required this.isEditMode,
  });

  @override
  State<ServingSizeBtmSheet> createState() => _ServingSizeBtmSheetState();
}

class _ServingSizeBtmSheetState extends State<ServingSizeBtmSheet> {
  var _data = ServingSizeTemplate();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _data = widget.initialValue!;

      if (!widget.baseServingSizes.any((x) => x.id == _data.baseServingSize)) {
        _data.baseServingSize = widget.baseServingSizes.first.id;
      }
    } else {
      _data.baseServingSize = widget.baseServingSizes.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.all(20)
          .copyWith(bottom: 20 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 20,
            children: [
              Text(
                widget.isEditMode
                    ? localizations.editCustomServingSizeTitle
                    : localizations.addCustomServingSizeTitle,
                style: theme.textTheme.headlineMedium,
              ),
              c.FormField(
                label: Text(localizations.servingSizeName),
                initialValue: _data.name,
                enableNextButton: true,
                onChanged: (value) => setState(() => _data.name = value),
              ),
              FractionallySizedBox(
                widthFactor: 0.475,
                child: c.FormField(
                  label: Text(localizations.servingSizeAmount),
                  initialValue: _data.amount.toString(),
                  onlyNumbers: true,
                  enableNextButton: true,
                  onChanged: (value) {
                    var num = double.tryParse(value);
                    if (num != null) {
                      _data.amount = num;
                    }
                  },
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.475,
                child: DropdownMenu(
                  dropdownMenuEntries: widget.baseServingSizes
                      .map((el) => DropdownMenuEntry(
                            value: el.id,
                            label: el.name,
                          ))
                      .toList(),
                  label: Text(localizations.servingSize),
                  initialSelection: widget.baseServingSizes
                          .any((x) => x.id == _data.baseServingSize)
                      ? _data.baseServingSize
                      : widget.baseServingSizes.first.id,
                  onSelected: (value) {
                    if (value != null) {
                      setState(() => _data.baseServingSize = value);
                    }
                  },
                  expandedInsets: EdgeInsets.zero,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton.icon(
                    onPressed: () => Navigator.pop(context, _data),
                    label: Text(localizations.save),
                    icon: Icon(Symbols.save_rounded),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

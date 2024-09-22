import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todayPageTitle),
        forceMaterialTransparency: true,
      ),
      body: const Text('Test 1'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Symbols.barcode_scanner),
        onPressed: () {},
      ),
    );
  }
}

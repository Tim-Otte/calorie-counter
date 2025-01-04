import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import 'data/all.dart' show AppDatabase;
import 'pages/all.dart';
import 'controllers/settings_controller.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final database = Provider.of<AppDatabase>(context);

    // Database updates
    database.createDefaultServingSizes(localizations);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: <Widget>[
          const TodayPage(),
          const MonthlyOverviewPage(),
          SettingsPage(controller: widget.settingsController),
        ].elementAt(currentPage),
      ),
      floatingActionButton: currentPage == 0
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FloatingActionButton(
                    heroTag: 'add_consumable_manually',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchProductPage(
                          onSelect: (product, isNewProduct) {
                            final route = MaterialPageRoute(
                              builder: (_) => AddMealPage(product: product),
                            );
                            if (isNewProduct) {
                              Navigator.pushReplacement(context, route);
                            } else {
                              Navigator.push(context, route);
                            }
                          },
                        ),
                      ),
                    ),
                    mini: true,
                    backgroundColor: colorScheme.tertiary,
                    child: Icon(
                      Symbols.add,
                      color: colorScheme.onTertiary,
                      weight: 800,
                    ),
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'scan_consumable',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (colorScheme) => const ScanBarcodePage()),
                  ),
                  child: const Icon(Symbols.barcode_scanner),
                )
              ],
            )
          : null,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: NavigationBar(
        backgroundColor: colorScheme.primary.withOpacity(0.1),
        indicatorColor: colorScheme.primary.withOpacity(0.69),
        onDestinationSelected: (value) {
          setState(() => currentPage = value);
          unawaited(HapticFeedback.selectionClick());
        },
        selectedIndex: currentPage,
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Symbols.today),
            selectedIcon: const Icon(Symbols.today, fill: 1),
            label: localizations.todayPageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Symbols.calendar_month),
            selectedIcon: const Icon(Symbols.calendar_month, fill: 1),
            label: localizations.monthlyOverviewPageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Symbols.settings),
            selectedIcon: const Icon(Symbols.settings, fill: 1),
            label: localizations.settingsPageTitle,
          ),
        ],
      ),
    );
  }
}

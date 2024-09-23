import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'pages/pages.dart';
import 'settings/settings_controller.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: <Widget>[
          const TodayPage(),
          const MonthlyOverviewPage(),
          SettingsPage(controller: super.widget.settingsController),
        ].elementAt(currentPage),
      ),
      floatingActionButton: currentPage == 0
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FloatingActionButton(
                    onPressed: () {},
                    mini: true,
                    backgroundColor: const Color.fromARGB(172, 207, 207, 207),
                    child: const Icon(
                      Symbols.add,
                      color: Color(0xff333333),
                      weight: 800,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {},
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
          HapticFeedback.selectionClick();
        },
        selectedIndex: currentPage,
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Symbols.today),
            selectedIcon: const Icon(Symbols.today, fill: 1),
            label: AppLocalizations.of(context)!.todayPageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Symbols.calendar_month),
            selectedIcon: const Icon(Symbols.calendar_month, fill: 1),
            label: AppLocalizations.of(context)!.monthlyOverviewPageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Symbols.settings),
            selectedIcon: const Icon(Symbols.settings, fill: 1),
            label: AppLocalizations.of(context)!.settingsPageTitle,
          ),
        ],
      ),
    );
  }
}

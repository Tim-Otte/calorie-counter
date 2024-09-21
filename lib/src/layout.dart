import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: <Widget>[
          const TodayPage(),
          const MonthlyOverviewPage(),
          SettingsPage(controller: super.widget.settingsController),
        ].elementAt(currentPage),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() => currentPage = value);
          HapticFeedback.selectionClick();
        },
        selectedIndex: currentPage,
        indicatorColor: theme.primaryColor,
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.today),
            label: AppLocalizations.of(context)!.todayPageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month),
            label: AppLocalizations.of(context)!.monthlyOverviewPageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settingsPageTitle,
          ),
        ],
      ),
    );
  }
}

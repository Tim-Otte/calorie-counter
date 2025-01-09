import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'extensions/all.dart';
import 'pages/all.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: <Widget>[
          const TodayPage(),
          const MonthlyOverviewPage(),
          const ProfilePage(),
        ].elementAt(_currentPage),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Today page
                _getNavigationItem(
                  context: context,
                  index: 0,
                  icon: Symbols.today_rounded,
                  label: localizations.todayPageTitle,
                ),
                // Monthly overview page
                _getNavigationItem(
                  context: context,
                  index: 1,
                  icon: Symbols.calendar_month_rounded,
                  label: localizations.monthlyOverviewPageTitle,
                ),
                // Profile page
                _getNavigationItem(
                  context: context,
                  index: 2,
                  icon: Symbols.account_circle_rounded,
                  label: localizations.profilePageTitle,
                ),
                SizedBox(width: 10),
              ],
            ),
            Positioned(
              right: 22,
              bottom: 6,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.surface,
                    width: 2,
                  ),
                  color: theme.colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  key: ValueKey('btn_add_any_meal'),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    foregroundColor: theme.colorScheme.onSecondaryContainer,
                    padding: EdgeInsets.all(4),
                    visualDensity: VisualDensity.compact,
                    elevation: 3,
                    shadowColor: theme.shadowColor,
                  ),
                  icon: Icon(
                    Symbols.add_rounded,
                  ),
                  onPressed: () => _showProductSearch(context),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'scan_consumable',
        shape: const CircleBorder(),
        onPressed: () {
          unawaited(HapticFeedback.selectionClick());
          context.navigateTo((_) => ScanBarcodePage());
        },
        child: const Icon(Symbols.barcode_scanner_rounded),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void _showProductSearch(BuildContext context) {
    unawaited(HapticFeedback.selectionClick());

    context.navigateTo((_) => SearchProductOrRecipePage());
  }

  Widget _getNavigationItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final isSelected = _currentPage == index;

    return InkWell(
      onTap: () {
        unawaited(HapticFeedback.selectionClick());
        setState(() => _currentPage = index);
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: Wrap(
        spacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: [
          AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            firstChild: IconButton.filledTonal(
              key: ValueKey('bottom_nav_${index}_active'),
              icon: Icon(icon, fill: 1),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              visualDensity: VisualDensity.compact,
              isSelected: isSelected,
              onPressed: () => setState(() => _currentPage = index),
            ),
            secondChild: IconButton(
              key: ValueKey('bottom_nav_$index'),
              icon: Icon(icon),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              visualDensity: VisualDensity.compact,
              isSelected: isSelected,
              onPressed: () => setState(() => _currentPage = index),
            ),
            crossFadeState: isSelected
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
          Text(
            label,
            style: isSelected
                ? theme.bottomNavigationBarTheme.selectedLabelStyle
                : theme.bottomNavigationBarTheme.unselectedLabelStyle,
          ),
        ],
      ),
    );
  }
}

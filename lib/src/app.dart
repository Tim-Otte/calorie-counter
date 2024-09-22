import 'package:calorie_counter/src/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final bool useMaterial3 = true;
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('de', ''), // German, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData.from(
            useMaterial3: useMaterial3,
            colorScheme: const ColorScheme.light(
              primary: Color(0xff3b6939),
              onPrimary: Color(0xffffffff),
              primaryContainer: Color(0xffbcf0b4),
              onPrimaryContainer: Color(0xff002204),
              secondary: Color(0xff52634f),
              onSecondary: Color(0xffffffff),
              secondaryContainer: Color(0xffd5e8cf),
              onSecondaryContainer: Color(0xff111f0f),
              tertiary: Color(0xff38656a),
              onTertiary: Color(0xffffffff),
              tertiaryContainer: Color(0xffbcebf0),
              onTertiaryContainer: Color(0xff002023),
              surface: Color(0xfff7fbf1),
              onSurface: Color(0xff191d17),
              surfaceContainerHighest: Color(0xffe0e4db),
              onSurfaceVariant: Color(0xff424940),
              outline: Color(0xff72796f),
              shadow: Color(0xff000000),
            ),
          ),
          darkTheme: ThemeData.from(
            useMaterial3: useMaterial3,
            colorScheme: const ColorScheme.dark(
              primary: Color(0xffa1d39a),
              onPrimary: Color(0xff0a390f),
              primaryContainer: Color(0xff235024),
              onPrimaryContainer: Color(0xffbcf0b4),
              secondary: Color(0xff296b2a),
              onSecondary: Color(0xffffffff),
              secondaryContainer: Color(0xff76bb6f),
              onSecondaryContainer: Color(0xff002203),
              tertiary: Color(0xff38656a),
              onTertiary: Color(0xffffffff),
              tertiaryContainer: Color(0xffbcebf0),
              onTertiaryContainer: Color(0xff002023),
              surface: Color(0xFF141414),
              onSurface: Color(0xffe0e4db),
              surfaceContainerHighest: Color(0xff323630),
              onSurfaceVariant: Color(0xffc2c9bd),
              outline: Color(0xff8c9388),
              shadow: Color(0xff0a0a0a),
            ),
          ),
          themeMode: settingsController.themeMode,

          home: MainLayout(settingsController: settingsController),

          debugShowCheckedModeBanner: false,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          /* onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case SampleItemListView.routeName:
                  default:
                    return const SampleItemListView();
                }
              },
            );
          }, */
        );
      },
    );
  }
}

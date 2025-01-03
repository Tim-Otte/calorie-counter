import 'package:calorie_counter/src/controllers/settings_controller.dart';
import 'package:calorie_counter/src/data/all.dart';
import 'package:calorie_counter/src/pages/all.dart';
import 'package:calorie_counter/src/services/all.dart';
import 'package:calorie_counter/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  group('MainLayout', () {
    late FoodFactService foodFactService;
    late SettingsController settingsController;

    setUp(() async {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();

      foodFactService = FoodFactService();
      settingsController = SettingsController(
        SettingsService(),
        foodFactService,
      );

      foodFactService.setupApiConfig();
      await settingsController.loadSettings();
    });

    Future<void> pumpAppAndSettle(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider(
              create: (_) => AppDatabase(forTesting: true),
              dispose: (_, db) => db.close(),
            ),
            Provider(create: (_) => foodFactService),
            ChangeNotifierProvider(create: (_) => settingsController),
          ],
          child: MyApp(),
        ),
      );

      await tester.pumpAndSettle();
    }

    testWidgets('should display initial page', (WidgetTester tester) async {
      await pumpAppAndSettle(tester);

      expect(find.byType(TodayPage), findsOneWidget);
    });

    testWidgets('should navigate to MonthlyOverviewPage',
        (WidgetTester tester) async {
      await pumpAppAndSettle(tester);

      await tester.tap(find.byKey(ValueKey('bottom_nav_1')));
      await tester.pumpAndSettle();

      expect(find.byType(MonthlyOverviewPage), findsOneWidget);
    });

    testWidgets('should navigate to ProfilePage', (WidgetTester tester) async {
      await pumpAppAndSettle(tester);

      await tester.tap(find.byKey(ValueKey('bottom_nav_2')));
      await tester.pumpAndSettle();

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('should open ScanBarcodePage on FAB press',
        (WidgetTester tester) async {
      await pumpAppAndSettle(tester);

      await tester.tap(find.byIcon(Symbols.barcode_scanner_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(ScanBarcodePage), findsOneWidget);
    });

    testWidgets('should open SearchProductPage on search button press',
        (WidgetTester tester) async {
      await pumpAppAndSettle(tester);

      await tester.tap(find.byKey(ValueKey('btn_add_any_meal')));

      // pumpAndSettle does not work with CircularProgressIndicator
      for (int i = 0; i < 10; i++) {
        await tester.pump(Duration(seconds: 10));
      }

      expect(find.byType(SearchProductPage), findsOneWidget);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/data/database.dart';
import 'src/controllers/settings_controller.dart';
import 'src/services/all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final foodFactService = FoodFactService();
  final settingsController = SettingsController(
    SettingsService(),
    foodFactService,
  );

  foodFactService.setupApiConfig();
  settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => AppDatabase()),
      Provider(create: (_) => foodFactService),
      ChangeNotifierProvider(create: (_) => settingsController),
    ],
    child: MyApp(),
  ));
}

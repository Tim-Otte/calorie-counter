import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/models/database.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  database.initAppSetting();

  final settingsController = SettingsController(SettingsService());

  settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(Provider<AppDatabase>(
    create: (_) => AppDatabase(),
    child: MyApp(settingsController: settingsController),
  ));
}

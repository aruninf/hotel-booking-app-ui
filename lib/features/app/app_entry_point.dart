import 'dart:async';

import 'package:nudge/core/config/app_config.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/core/preferences/preferences.dart';
import 'package:nudge/core/preferences/shared_pref.dart';
import 'package:nudge/features/app/app_initializer.dart';
import 'package:nudge/features/app/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppEntryPoint {
  AppEntryPoint(AppConfiguration buildVariant) {
    envSettings = buildVariant;
    initializeStartUpDependenciesAndRun();
  }

  static AppConfiguration? envSettings;

  static Future<void> initializeStartUpDependenciesAndRun() async {
    await AppInitializer.init();

    final prefs = await SharedPreferences.getInstance();
    final appPrefs = AppSharedPref(prefs);

    final hasSeen = await appPrefs.getString(PreferenceKeys.hasSeenExplainer);

    final initialRoute =
        (hasSeen == 'false' || hasSeen == null)
            ? AppRoutes.explainerScreen
            : AppRoutes.loginPage;

    runApp(MyApp(initialRoute: initialRoute));
  }
}

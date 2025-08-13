import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nudge/core/config/environment_helper.dart';
import 'package:nudge/core/dio_provider/dio_api_client.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/core/preferences/preferences.dart';
import 'package:nudge/core/preferences/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInitializer {
  static Future<void> init() async {
    if (Platform.isAndroid) {
      unawaited(_setHighRefreshRate());
    }

    unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await _initializeSharedPreferences();
    injectDependencies();
  }

  static Future<void> _setHighRefreshRate() async {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> _initializeSharedPreferences() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    Get.put(
      sharedPreferences,
    ); // Put the instance of SharedPreferences into Get
  }

  static void injectDependencies() {
    Get
      ..put(const FlutterSecureStorage())
      // ..lazyPut(() => FirebaseNotificationService())
      ..put(Preferences(Get.find()))
      ..put(SharedPreferences.getInstance())
      ..put(AppSharedPref(Get.find()))
      ..put(Dio())
      ..put(EnvironmentHelper())
      ..put(DioApiClient(Get.find(), Get.find(), Get.find()));
  }
}

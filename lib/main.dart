import 'package:flutter/material.dart';
import 'package:nudge/core/build_variants/app_environment_enum.dart';
import 'package:nudge/core/config/app_config.dart';
import 'package:nudge/features/app/app_entry_point.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const buildVariant = AppConfiguration(
    baseUrl: "https://api.example.com",
    appEnvironment: AppEnvironment.production,
  );

  AppEntryPoint(buildVariant);
}

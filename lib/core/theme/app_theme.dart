import 'package:flutter/services.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) => ThemeData(
    useMaterial3: true,
    // fontFamily: GoogleFonts.inter().fontFamily,
    fontFamily: FontFamily.inter,
    brightness: Brightness.light,
    // textTheme: Theme.of(context).textTheme.apply(
    //   bodyColor: AppColors.neutral900,
    //   displayColor: AppColors.neutral900,
    // ),
    textTheme: AppTextStyle.lightTextTheme,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary500),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: const RoundedRectangleBorder(),
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.colorWhite,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.colorWhite,
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(context.text.titleMedium),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: WidgetStatePropertyAll(AppColors.primary500),
      ),
    ),
    scaffoldBackgroundColor: AppColors.transparent,
    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.transparent,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      backgroundColor: AppColors.transparent,
      foregroundColor: AppColors.white,
    ),
  );
}

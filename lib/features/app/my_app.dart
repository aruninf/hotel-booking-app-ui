import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/core/theme/app_theme.dart';

class MyApp extends StatefulWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      precacheImage(Assets.images.splash.provider(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppUtils.unfocusKeyboard(context),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              systemNavigationBarColor: AppColors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              // statusBarBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
              // for ios
              statusBarIconBrightness: Brightness.dark, // for android
            ),
          );
          return GetMaterialApp(
            // initialBinding: ProfileBindings(),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appTheme(context),
            getPages: AppRoutes.appPages,
            initialRoute: widget.initialRoute,
            home: child,
            defaultTransition: Transition.fadeIn,
          );
        },
      ),
    );
  }
}

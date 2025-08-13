import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/core/preferences/preferences.dart';
import 'package:nudge/core/preferences/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
    ).then((c) => Get.offNamed(AppRoutes.loginPage));
    //_navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final appPrefs = AppSharedPref(prefs);

    final hasSeen = await appPrefs.getString(PreferenceKeys.hasSeenExplainer);

    if (hasSeen == 'false') {
      Get.offNamed(AppRoutes.loginPage);
    } else {
      Get.offNamed(AppRoutes.explainerScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.02, 0.2, 0.5, 0.9],
            colors: [
              Color(0xFFFBF5FD),
              Color(0xFFCAB9E1),
              Color(0xFF724DAE),
              Color(0xFF09012F),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.images.mainLogo.path,
                height: 179,
                width: 60,
              ),
              VerticalSpacing(30),
              Text(
                'NUDGE',
                style: context.text.titleLarge!.copyWith(
                  color: AppColors.white,
                  fontSize: 60,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.loginPage);
                },
                child: Text('Skip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

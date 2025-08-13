import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nudge/gen/assets.gen.dart'; // Ensure this exists for PNGs

class AppGradientScaffold extends StatelessWidget {
  const AppGradientScaffold({
    super.key,
    required this.child,
    this.safeArea = true,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor = Colors.white,
    this.floatingActionButton,
    this.appBar,
    this.bottomLogo = false,
  });

  final Widget child;
  final bool safeArea;
  final bool resizeToAvoidBottomInset;
  final Color backgroundColor;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool bottomLogo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      extendBody: true,
      body: Stack(
        children: [
          ..._buildCommonGradientImages(size),
          if (bottomLogo)
            Positioned(
              bottom: 0,
              left: 0,
              child: Center(
                child: Image.asset(
                  Assets.images.dnaHalfLogo.path, // Adjust to your logo asset
                  width: 143,
                  height: 429,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }

  List<Widget> _buildCommonGradientImages(Size size) {
    return [
      Positioned(
        top: 0,
        right: 0,
        child: ColorFiltered(
          colorFilter: ColorFilter.matrix(_saturationMatrix(1.6)),
          child: Image.asset(
            Assets.images.gradientLogin1.path,
            width: size.width * 0.5,
            height: size.height * 0.25,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: ColorFiltered(
          colorFilter: ColorFilter.matrix(_saturationMatrix(2.0)),
          child: Image.asset(
            Assets.images.gradientLogin2.path,
            width: size.width * 0.45,
            height: size.height * 0.22,
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: ColorFiltered(
          colorFilter: ColorFilter.matrix(_saturationMatrix(2.0)),
          child: Image.asset(
            Assets.images.gradientLogin3.path,
            width: size.width * 0.6,
            height: size.height * 0.28,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Positioned(
        right: size.height * -0.06,
        bottom: size.height * 0.05,
        child: ColorFiltered(
          colorFilter: ColorFilter.matrix(_saturationMatrix(8.5)),
          child: Image.asset(
            Assets.images.gradientLogin4.path,
            width: size.width * 0.7,
            height: size.height * 0.4,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Positioned(
        right: 0,
        bottom: size.height * 0.04,
        child: ColorFiltered(
          colorFilter: ColorFilter.matrix(_saturationMatrix(2.0)),
          child: Image.asset(
            Assets.images.gradientLogin5.path,
            width: size.width * 0.5,
            height: size.height * 0.6,
          ),
        ),
      ),
    ];
  }

  List<double> _saturationMatrix(double saturation) {
    final double invSat = 1 - saturation;
    final double r = 0.2126 * invSat;
    final double g = 0.7152 * invSat;
    final double b = 0.0722 * invSat;

    return <double>[
      r + saturation,
      g,
      b,
      0,
      0,
      r,
      g + saturation,
      b,
      0,
      0,
      r,
      g,
      b + saturation,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ];
  }
}

import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/common/app_gradient_appbar.dart';
import 'package:nudge/core/extension/extensions.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoutes.loginPage);
        return true;
      },
      child: AppGradientScaffold(
        bottomLogo: true,
        backgroundColor: AppColors.white,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppGradientAppBar(
            onBackTap: () => Get.offAllNamed(AppRoutes.loginPage),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: 34,
              right: 33,
            ).copyWith(top: context.devicePaddingTop + 31),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.images.circleCheck.path),
                  VerticalSpacing(30),
                  Text(
                    'Password changed!',
                    style: context.text.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  VerticalSpacing(12),
                  Text(
                    'Your password has been changed successfully.',
                    style: context.text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  VerticalSpacing(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.5),
                    child: AppOutlinedButton(
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.loginPage);
                      },
                      isLoading: false,
                      backgroundColor: AppColors.purpleButton,
                      textColor: Colors.green,
                      text: 'BACK TO LOG IN',
                      textStyle: context.text.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      height: 58,
                    ),
                  ),
                  VerticalSpacing(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

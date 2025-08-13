import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/login/presentation/controllers/login_controller.dart';
import 'package:nudge/features/login/presentation/controllers/reset_global_initializer.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_bindings.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'lognkey',
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.red,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    //   statusBarColor: AppColors.primaryContainerColor,
    //   statusBarIconBrightness: Brightness.light,
    // ));
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final controller = Get.find<LoginController>();

    return AppGradientScaffold(
      // resizeToAvoidBottomInset: true,
      // backgroundColor: AppColors.white,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ).copyWith(top: context.devicePaddingTop + 31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Top logo and text
            Column(
              children: [
                SvgPicture.asset(
                  Assets.images.logoSVG.path,
                  height: 137,
                  width: 46,
                ),
                VerticalSpacing(6),
                SizedBox(
                  height: 41,
                  width: 126,
                  child: Assets.images.nudgeTitleLogo.image(),
                ),
              ],
            ),
            VerticalSpacing(100),

            /// Form Section
            Form(
              key: loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
                    style: context.text.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  VerticalSpacing(20),
                  Obx(
                    () => AppTextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      labelText: 'Your email',
                      style: context.text.titleMedium?.copyWith(
                        color: AppColors.neutral900,
                      ),
                      controller: controller.emailController,
                      focusNode: controller.emailFocusNode,
                      validator:
                          ValidationBuilder().email('*Invalid Email').build(),
                      prefixIcon:
                          controller.showEmailPrefixIcon.value
                              ? Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: SvgPicture.asset(
                                  Assets.images.messageIcon.path,
                                ),
                              )
                              : null,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  VerticalSpacing(20),
                  Obx(
                    () => AppTextFormField(
                      labelText: 'Your password',
                      style: context.text.titleMedium?.copyWith(
                        color: AppColors.neutral900,
                      ),
                      controller: controller.passwordController,
                      focusNode: controller.passwordFocusNode,
                      obscureText: controller.showPassword.value,
                      validator: ValidationBuilder().required().build(),
                      prefixIcon:
                          controller.showPasswordPrefixIcon.value
                              ? Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: SvgPicture.asset(
                                  Assets.images.lockIcon.path,
                                ),
                              )
                              : null,
                      suffixIcon:
                          controller.showPasswordSuffixIcon.value
                              ? Padding(
                                padding: EdgeInsets.only(right: 6),
                                child: IconButton(
                                  onPressed: () {
                                    controller.togglePasswordVisibility();
                                  },
                                  icon: SvgPicture.asset(
                                    controller.showPassword.value
                                        ? Assets.images.eye.path
                                        : Assets.images.eyeClose.path,
                                  ),
                                ),
                              )
                              : null,
                      textInputType: TextInputType.visiblePassword,
                    ),
                  ),
                  VerticalSpacing(30),
                  GestureDetector(
                    onTap: () {
                      ResetGlobalInitializer.initialize();
                      Get.toNamed(AppRoutes.forgotPass);
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Forgot Password?',
                        style: context.text.titleMedium!.copyWith(
                          color: AppColors.primary800,
                        ),
                      ),
                    ),
                  ),
                  VerticalSpacing(30),
                  if (!keyboardVisible)
                    Column(
                      children: [
                        Center(
                          child: AppOutlinedButtonWithArrow(
                            onPressed: () {
                              // ChatInitializer.initialize();
                              Get.offAllNamed(AppRoutes.dashboard);
                            },
                            isLoading: false,
                            backgroundColor: AppColors.purpleButton,
                            textColor: Colors.green,
                            text: 'SIGN IN',
                            textStyle: context.text.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                            height: 58,
                            width: 271,
                          ),
                        ),
                        VerticalSpacing(20),
                        GestureDetector(
                          onTap: () {
                            if (!Get.isRegistered<OnboardingController>()) {
                              OnboardingInitializer.initialize();
                            }
                            final onboardingController =
                                Get.find<OnboardingController>();
                            onboardingController.clearFields();
                            Get.toNamed(AppRoutes.signupScreen);
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: RichText(
                                text: TextSpan(
                                  style: context.text.titleMedium?.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.color120D26,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Don\'t have an account? '),
                                    TextSpan(
                                      text: 'Sign Up',
                                      style: context.text.titleMedium?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.signupTextBtn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

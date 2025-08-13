import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = Get.find<OnboardingController>();

  Future<void> _selectDate(BuildContext context) async {
    final today = DateTime.now();
    final eighteenYearsAgo = DateTime(today.year - 18, today.month, today.day);

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: eighteenYearsAgo,
      firstDate: DateTime(1900),
      lastDate: eighteenYearsAgo,
    );

    if (selectedDate != null) {
      controller.dobController.text = '${selectedDate.toLocal()}'.split(' ')[0];
      controller.dob.value = controller.dobController.text;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(AppRoutes.loginPage);
        return false;
      },
      child: AppGradientScaffold(
        backgroundColor: AppColors.white,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          resizeToAvoidBottomInset: true,
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(kToolbarHeight),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 3),
          //     child: AppGradientAppBarWithStepper(
          //       index: 0,
          //       onBackTap: () => Get.offNamed(AppRoutes.loginPage),
          //     ),
          //   ),
          // ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ).copyWith(bottom: context.devicePaddingBottom),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(10),
                  Text(
                    'Create your account',
                    style: context.text.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const VerticalSpacing(20),
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Form(
                        key: controller.formDetailsKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextFormField(
                              labelText: 'Full Name',
                              controller: controller.nameController,
                              validator: ValidationBuilder().required().build(),
                              textInputType: TextInputType.text,
                              style: context.text.titleMedium?.copyWith(
                                color: AppColors.neutral900,
                              ),
                              onChanged: (_) => controller.checkFieldsFilled(),
                            ),
                            const VerticalSpacing(30),
                            AppTextFormField(
                              labelText: 'Email',
                              controller: controller.emailController,
                              validator:
                                  ValidationBuilder()
                                      .email('*Invalid Email')
                                      .required()
                                      .build(),
                              textInputType: TextInputType.emailAddress,
                              style: context.text.titleMedium?.copyWith(
                                color: AppColors.neutral900,
                              ),
                              onChanged: (_) => controller.checkFieldsFilled(),
                            ),
                            const VerticalSpacing(30),
                            AppTextFormField(
                              labelText: 'Phone Number',
                              controller: controller.phoneController,
                              maxLength: 11,
                              validator:
                                  ValidationBuilder()
                                      .required()
                                      .phone()
                                      .maxLength(12, 'Phone number too long')
                                      .minLength(10, 'Phone number too short')
                                      .build(),
                              textInputType: TextInputType.number,
                              style: context.text.titleMedium?.copyWith(
                                color: AppColors.neutral900,
                              ),
                              onChanged: (_) => controller.checkFieldsFilled(),
                            ),
                            const VerticalSpacing(30),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: AppTextFormField(
                                  labelText: 'Date of Birth',
                                  controller: controller.dobController,
                                  isReadOnly: true,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Date of Birth is required';
                                    }
                                    return null;
                                  },
                                  style: context.text.titleMedium?.copyWith(
                                    color: AppColors.neutral900,
                                  ),
                                ),
                              ),
                            ),
                            const VerticalSpacing(30),
                            AppTextFormField(
                              labelText: 'Location',
                              controller: controller.locationController,
                              validator: ValidationBuilder().required().build(),
                              textInputType: TextInputType.text,
                              style: context.text.titleMedium?.copyWith(
                                color: AppColors.neutral900,
                              ),
                              onChanged: (_) => controller.checkFieldsFilled(),
                            ),
                            const VerticalSpacing(30),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                    ),
                                    child: Opacity(
                                      opacity:
                                          controller.isOnboardingValid.value
                                              ? 1.0
                                              : 0.5,
                                      child: AppOutlinedButtonWithArrow(
                                        onPressed: () {
                                          controller.validateOnboarding(
                                            controller.formDetailsKey,
                                          );

                                          if (controller
                                              .isOnboardingValid
                                              .value) {
                                            // final phone = controller
                                            //     .phoneController.text
                                            //     .trim();
                                            controller.moveToNextPage(
                                              controller
                                                  .pageController
                                                  .value
                                                  .page!
                                                  .toInt(),
                                            );
                                          }
                                        },
                                        isLoading: false,
                                        backgroundColor: AppColors.purpleButton,
                                        textColor: Colors.green,
                                        text: 'CONTINUE',
                                        textStyle: context.text.titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.white,
                                            ),
                                        height: 58,
                                        width: 271,
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalSpacing(30),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamed(AppRoutes.loginPage);
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      style: context.text.titleMedium?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.neutral600,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Already have an account? ',
                                        ),
                                        TextSpan(
                                          text: 'Sign In',
                                          style: context.text.titleMedium
                                              ?.copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.signupTextBtn,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VerticalSpacing(20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

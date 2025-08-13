import 'package:flutter_svg/svg.dart';
import 'package:nudge/core/extension/extensions.dart';

class AppSuccessScreenParam {
  AppSuccessScreenParam({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.buttonText,
    this.width = 300,
    this.secondarybuttonText,
    this.secondaryOnPressed,
    this.secondaryButton = false,
    this.popRouteName,
    this.onPressed,
  });

  final String title;
  final String subtitle;
  final String image;
  final String buttonText;
  final String? secondarybuttonText;
  final String? popRouteName;
  final bool secondaryButton;
  final double width;
  final void Function(BuildContext context)? onPressed;
  final void Function(BuildContext context)? secondaryOnPressed;
}

class AppSuccessScreen extends StatefulWidget {
  const AppSuccessScreen({super.key});

  @override
  State<AppSuccessScreen> createState() => _AppSuccessScreenState();
}

class _AppSuccessScreenState extends State<AppSuccessScreen> {
  final AppSuccessScreenParam param = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      bottomLogo: true,
      backgroundColor: AppColors.white,
      child: AppScaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const VerticalSpacing(74),
                Center(
                  child: SvgPicture.asset(param.image, width: 56, height: 56),
                ),
                const VerticalSpacing(30),
                Text(
                  param.title,
                  style: context.text.titleLarge!.copyWith(
                    fontSize: 24,
                    color: AppColors.titleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const VerticalSpacing(12),
                Text(
                  param.subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLGRegular.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
                const VerticalSpacing(30),
                AppOutlinedButton(
                  text: param.buttonText,
                  textStyle: context.text.titleLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    if (param.popRouteName != null) {
                      Navigator.popUntil(
                        context,
                        (route) => route.settings.name == param.popRouteName,
                      );
                    } else {
                      param.onPressed?.call(context);
                    }
                  },
                ),
                if (param.secondarybuttonText != null)
                  if (param.secondaryButton)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: AppOutlinedButton.white(
                        text: param.secondarybuttonText!,
                        onPressed: () {
                          param.secondaryOnPressed?.call(context);
                        },
                      ),
                    )
                  else
                    AppTextButton(
                      label: param.secondarybuttonText!,
                      onTap: () {
                        param.secondaryOnPressed?.call(context);
                      },
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                    ),
                const VerticalSpacing(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

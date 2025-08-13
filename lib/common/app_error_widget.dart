import 'package:nudge/core/extension/extensions.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    this.title = AppConstants.errorMessage,
    super.key,
    this.onTap,
  });

  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Error'),
        AppTextButton(label: 'Retry', onTap: onTap),
      ],
    );
  }
}

import 'package:nudge/core/extension/extensions.dart';

class AppAboutDialog extends StatelessWidget {
  const AppAboutDialog({
    required this.title,
    required this.primaryText,
    super.key,
    this.subtitle,
    this.onPrimaryPress,
    this.onSecondaryPress,
    this.secondaryText,
  });

  final String title;
  final String? subtitle;
  final void Function()? onPrimaryPress;
  final void Function()? onSecondaryPress;
  final String? secondaryText;
  final String primaryText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            const VerticalSpacing(12),
            Text(title, style: context.text.titleMedium),
            const VerticalSpacing(12),
            if (subtitle != null)
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: context.text.titleMedium,
              ),
            const VerticalSpacing(16),
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    text: primaryText,
                    onPressed: onPrimaryPress,
                  ),
                ),
                const HorizontalSpacing(8),
                Expanded(
                  child: AppOutlinedButton.white(
                    text: 'Back',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

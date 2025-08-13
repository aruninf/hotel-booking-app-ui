import 'package:nudge/core/extension/extensions.dart';

class DrawerHeaderWithBack extends StatelessWidget {
  const DrawerHeaderWithBack({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            AppWidgetKey.bottomBarController.jumpToPreviousTab();
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        Text(title, style: AppTextStyles.textHeadingH3),
        InkWell(
          onTap: () {
            AppWidgetKey.mainScaffold.currentState!.openDrawer();
          },
          child: Assets.images.menu.svg(width: 32),
        ),
      ],
    );
  }
}

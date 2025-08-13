import 'package:nudge/core/extension/extensions.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width = 82});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Hero(tag: 'app-logo', child: Assets.images.logo.image(width: width));
  }
}

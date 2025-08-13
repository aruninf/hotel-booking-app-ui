import 'package:nudge/core/extension/extensions.dart';

class AppLeadingButton extends StatelessWidget {
  const AppLeadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Padding(padding: EdgeInsets.only(left: 8)),
      ),
    );
  }
}

import 'package:nudge/core/extension/extensions.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppOutlinedButton(
          onPressed: () {},
          text: 'Reject',
          backgroundColor: Colors.white,
          width: 80,
          textColor: Colors.black,
          borderColor: Colors.grey,
          borderRadius: 30,
          height: 45,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.foundationPrimary500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 14),
          ),
          child: Text(
            "Accept",
            style: context.text.titleLarge!.copyWith(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

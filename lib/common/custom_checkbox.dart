import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/core/extension/extensions.dart';

class CustomCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final String title;

  const CustomCheckbox({
    super.key,
    this.initialValue = false,
    required this.onChanged,
    required this.title,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  void _toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onChanged(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Keep background transparent
      child: InkWell(
        onTap: _toggleCheckbox,
        borderRadius: BorderRadius.circular(6),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                padding: EdgeInsets.all(4),
                duration: Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color:
                      isChecked ? AppColors.primary500 : AppColors.transparent,
                  border: Border.all(color: AppColors.foundation100, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child:
                    isChecked
                        ? SvgPicture.asset(Assets.images.check.path)
                        : null,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.title,
                  style: context.text.titleMedium?.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

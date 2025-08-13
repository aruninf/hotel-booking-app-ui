import 'package:nudge/core/extension/extensions.dart';

class TabButton extends StatefulWidget {
  const TabButton({
    super.key,
    required this.ontap,
    required this.onTabSelected,
  });

  final Function() ontap;
  final Function(int) onTabSelected;

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  int selectedTab = 0;
  int selectedDate = 1;
  final List<String> tabOptions = ['All', 'Events', 'Places'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabOptions.length, (index) {
        final isSelected = selectedTab == index;
        return GestureDetector(
          onTap: () {
            setState(() => selectedTab = index);
            widget.onTabSelected(index);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : AppColors.tabContainer,
              borderRadius: BorderRadius.circular(24),
              boxShadow:
                  isSelected
                      ? [
                        BoxShadow(
                          color: const Color(0x2E2E4F1F).withOpacity(0.12),
                          offset: const Offset(0, 6),
                          blurRadius: 20,
                        ),
                      ]
                      : [],
              // border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              tabOptions[index],
              style: context.text.labelMedium!.copyWith(
                fontSize: 14,
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }),
    );
  }
}

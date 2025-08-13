import 'package:nudge/core/extension/extensions.dart';

class SearchTabs extends StatefulWidget {
  const SearchTabs({super.key, required this.ontap});

  final Function() ontap;

  @override
  State<SearchTabs> createState() => _SearchTabsState();
}

class _SearchTabsState extends State<SearchTabs> {
  int selectedTab = 0;
  int selectedDate = 1;
  final List<String> tabOptions = [
    'Business',
    'Design',
    'Technology',
    'Marketing',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      child: Row(
        children: List.generate(tabOptions.length, (index) {
          final isSelected = selectedTab == index;
          return GestureDetector(
            onTap: () => setState(() => selectedTab = index),
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
                            spreadRadius: 0,
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
      ),
    );
  }
}

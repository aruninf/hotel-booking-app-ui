import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nudge/core/extension/extensions.dart';

class AppSearchDropdown extends StatefulWidget {
  const AppSearchDropdown({
    required this.title,
    required this.isAppointment,
    super.key,
    this.onSelected,
  });

  final bool isAppointment;
  final void Function(MenuItem?)? onSelected;
  final String title;

  @override
  State<AppSearchDropdown> createState() => _AppSearchDropdownState();
}

class _AppSearchDropdownState extends State<AppSearchDropdown> {
  // To store the filtered list of menu items based on search input
  List<MenuItem> filteredMenuItems = [];
  TextEditingController searchController = TextEditingController();
  bool requestFocus = false;

  // Function to filter the items based on the search query
  void filterMenuItems(String query) {
    setState(() {
      filteredMenuItems =
          (widget.isAppointment ? appointmentItems : menuItems)
              .where(
                (item) =>
                    item.label.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      filteredMenuItems = widget.isAppointment ? appointmentItems : menuItems;
      setState(() {});
      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          requestFocus = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<MenuItem>(
      width: MediaQuery.of(context).size.width * 0.9,
      hintText: widget.title,
      menuHeight: 260.h,
      trailingIcon: Assets.images.down.svg(),
      enableSearch: false,
      onSelected: (MenuItem? selectedItem) {
        setState(() {
          if (selectedItem != null) {
            // Deselect all items first
            filteredMenuItems =
                filteredMenuItems.map((item) {
                  // Deselect every item
                  return item.copyWith(isSelected: false);
                }).toList();

            // Ensure the selectedItem exists in the filteredMenuItems list
            final index = filteredMenuItems.indexWhere(
              (item) => item.id == selectedItem.id,
            );

            if (index != -1) {
              // Select the clicked item
              filteredMenuItems[index] = selectedItem.copyWith(
                isSelected: true,
              );
            }
          }
        });

        widget.onSelected?.call(selectedItem);
      },
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.neutral50, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.neutral50, width: 0.5),
        ),
        filled: true,
        fillColor: AppColors.colorWhite, // White background for input
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
          AppColors.colorWhite,
        ), // White dropdown
        elevation: WidgetStateProperty.all(4), // Dropdown elevation
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded dropdown edges
          ),
        ),
      ),
      dropdownMenuEntries: [
        // Search field inside the dropdown
        DropdownMenuEntry<MenuItem>(
          enabled: false,
          label: 'Search',
          value: MenuItem(id: 69, label: 'Search Field'),
          labelWidget: AppTextFormFieldWithoutLabel(
            prefixIcon: Assets.images.searchSmall.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.neutral500,
                BlendMode.srcIn,
              ),
            ),
            focusedBorderColor: AppColors.neutral500,
            controller: searchController,
            autofocus: requestFocus,

            // Ensure focus stays on search field
            onChanged: (query) {
              // Instead of rebuilding everything, filter items on change
              filterMenuItems(query);
            },
          ),
        ),
        // Display filtered menu items in the dropdown with checkmarks
        ...filteredMenuItems.map((MenuItem menu) {
          return DropdownMenuEntry<MenuItem>(
            value: menu,
            label: menu.label,
            labelWidget: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 8),
                  child: Icon(
                    Icons.check,
                    size: 20,
                    color:
                        menu.isSelected
                            ? AppColors.primary500
                            : AppColors.colorWhite,
                  ),
                ),
                Text(menu.label),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class MenuItem {
  MenuItem({required this.id, required this.label, this.isSelected = false});

  final int id;
  final String label;
  final bool isSelected;

  // Create a copy with a new isSelected state
  MenuItem copyWith({bool? isSelected}) {
    return MenuItem(
      id: id,
      label: label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

List<MenuItem> menuItems = [
  MenuItem(id: 1, label: 'Charlotte Evans'),
  MenuItem(id: 2, label: 'Mason Taylor'),
  MenuItem(id: 3, label: 'Isla Brown'),
  MenuItem(id: 4, label: 'Charlotte Evans'),
  MenuItem(id: 5, label: 'Olivia Smith'),
  MenuItem(id: 6, label: 'Jack Thompson'),
  MenuItem(id: 7, label: 'Liam Williams'),
];
List<MenuItem> appointmentItems = [
  MenuItem(id: 1, label: 'Type 1'),
  MenuItem(id: 2, label: 'Type 2'),
  MenuItem(id: 3, label: 'Type 3'),
];

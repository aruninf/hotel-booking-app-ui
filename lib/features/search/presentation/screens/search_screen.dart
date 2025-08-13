import 'package:nudge/common/common_event_card.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/home/presentation/controllers/home_controller.dart';
import 'package:nudge/features/search/presentation/controllers/search_controller.dart'
    as search;
import 'package:nudge/features/search/presentation/screens/widgets/search_tabs.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = Get.find<search.SearchController>();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isSearchFocused = _searchFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.white, // Top color (e.g., purple)
            AppColors.bottomScaffoldGradient, // Bottom color (e.g., deep blue)
          ],
        ),
      ),
      child: AppScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: AppColors.transparent,
          // backgroundColor: AppColors.transparent,
          title: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              'Search',
              style: context.text.displaySmall?.copyWith(
                color: AppColors.titleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            // Search Row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ).copyWith(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppTextFormFieldWithoutLabel(
                      focusNode: _searchFocusNode,
                      controller: homeController.searchSearchController,
                      hintText: 'Search',
                      hintStyle: context.text.bodyMedium!.copyWith(
                        fontSize: 14,
                        color: Color(0x80616679),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Color(0xffeeeeee),
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      prefixIcon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  HorizontalSpacing(12),
                  GestureDetector(
                    onTap: () {
                      // Search action
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffeeeeee), width: 1),
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x80D3D1D8),
                            offset: Offset(0, 40),
                            blurRadius: 60,
                          ),
                        ],
                      ),
                      child: Assets.images.filterBar.svg(height: 21, width: 21),
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpacing(19),
            Padding(
              padding: const EdgeInsets.only(left: 34),
              child:
                  _isSearchFocused
                      ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '120 results found',
                          style: context.text.titleSmall!.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.color757575,
                          ),
                        ),
                      )
                      : SearchTabs(ontap: () {}),
            ),
            VerticalSpacing(19),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ).copyWith(bottom: 20 + context.devicePaddingBottom),
                child: Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Obx(
                    () => ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder:
                          (context, index) => const VerticalSpacing(18),
                      itemCount: controller.events.length,
                      itemBuilder: (context, index) {
                        final event = controller.events[index];
                        return CommonEventCard(event: event);
                      },
                    ),
                  ),
                ),
              ),
            ),
            // PageView for swipe + toggle
          ],
        ),
      ),
    );
  }
}

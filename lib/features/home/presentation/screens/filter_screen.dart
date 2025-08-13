import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/services.dart';
import 'package:nudge/common/app_gradient_appbar_with_stepper.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:nudge/features/home/presentation/screens/widgets/tab_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int selectedTab = 0;
  int selectedDate = 1;
  RangeValues _priceRange = const RangeValues(20, 120);

  final List<String> tabOptions = ['All', 'Events', 'Places'];
  final List<String> dateOptions = ['Today', 'Tomorrow', 'This Week'];
  final List<String> allInterests = [
    'Technology',
    'Design',
    'Business',
    'Marketing',
    'Events',
    'Finance',
    'Engineering',
  ];
  List<String> selectedInterests = ['Technology', 'Design'];
  bool isSearching = false;
  String searchText = '';
  bool _showCalendar = false;
  List<DateTime?> _selectedDateRange = [null, null]; // Start and End Date

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(DashboardScreen(initialIndex: 0));
        return false;
      },
      child: CustomScaffold(
        child: AppScaffold(
          backgroundColor: AppColors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppGradientAppBar(
            title: 'Filter',
            onBackTap: () {
              Get.offAll(DashboardScreen(initialIndex: 0));
            },
            titleSpacing: 0,
          ),
          body: Padding(
            padding: EdgeInsets.only(bottom: context.devicePaddingBottom),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(8),

                    /// Top Tabs
                    TabButton(ontap: () {}, onTabSelected: (p0) {}),
                    VerticalSpacing(28),

                    /// Interests
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Interests",
                        style: context.text.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    VerticalSpacing(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap:
                              () => setState(() => isSearching = !isSearching),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade300),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF505588,
                                  ).withOpacity(0.06),
                                  blurRadius: 30,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    selectedInterests.join(', '),
                                    style: TextStyle(color: Colors.black),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        if (isSearching) VerticalSpacing(16),
                        if (isSearching)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF505588,
                                  ).withOpacity(0.06),
                                  blurRadius: 30,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 12,
                              ),
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search interest',
                                      prefixIcon: Assets.images.search.svg(
                                        colorFilter: ColorFilter.mode(
                                          AppColors.neutral600,
                                          BlendMode.srcIn,
                                        ),
                                        width: 11,
                                        height: 11,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        searchText = value;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Scrollbar(
                                        radius: Radius.circular(12),

                                        // thumbVisibility: true,
                                        thickness: 8,
                                        // isAlwaysShown: true,
                                        child: ListView(
                                          children:
                                              allInterests
                                                  .where(
                                                    (interest) => interest
                                                        .toLowerCase()
                                                        .contains(
                                                          searchText
                                                              .toLowerCase(),
                                                        ),
                                                  )
                                                  .map((interest) {
                                                    final isSelected =
                                                        selectedInterests
                                                            .contains(interest);
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            top: 15,
                                                          ),
                                                      child: Row(
                                                        spacing: 10,
                                                        children: [
                                                          Transform.scale(
                                                            scale: 1.4,
                                                            child: Checkbox(
                                                              value: isSelected,
                                                              activeColor:
                                                                  AppColors
                                                                      .foundation500,
                                                              onChanged: (
                                                                bool? selected,
                                                              ) {
                                                                setState(() {
                                                                  if (selected ==
                                                                      true) {
                                                                    selectedInterests
                                                                        .add(
                                                                          interest,
                                                                        );
                                                                  } else {
                                                                    selectedInterests
                                                                        .remove(
                                                                          interest,
                                                                        );
                                                                  }
                                                                });
                                                              },
                                                              // contentPadding:
                                                              //     EdgeInsets.symmetric(
                                                              //         horizontal: 16.0),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      4.0,
                                                                    ),
                                                              ),
                                                              side: BorderSide(
                                                                color:
                                                                    AppColors
                                                                        .neutral500,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            interest,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  })
                                                  .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    VerticalSpacing(28),

                    /// Time & Date
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Time & Date",
                        style: context.text.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 18,
                      ), // ← Prevent clipping
                      child: Row(
                        children: List.generate(dateOptions.length, (index) {
                          final isSelected = selectedDate == index;
                          return GestureDetector(
                            onTap: () => setState(() => selectedDate = index),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppColors.foundation500
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow:
                                    isSelected
                                        ? []
                                        : [
                                          BoxShadow(
                                            color: const Color(
                                              0x2E2E4F1F,
                                            ).withOpacity(0.12),
                                            offset: const Offset(0, 6),
                                            blurRadius: 20,
                                          ),
                                        ],
                              ),
                              child: Text(
                                dateOptions[index],
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? AppColors.white
                                          : AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showCalendar = !_showCalendar;
                          });
                        },
                        child: Row(
                          children: [
                            Assets.images.calendar.svg(
                              colorFilter: const ColorFilter.mode(
                                AppColors.foundation500,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(child: Text("Choose from calendar")),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: AppColors.foundation500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_showCalendar) VerticalSpacing(12),
                    if (_showCalendar)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF505588).withOpacity(0.06),
                              blurRadius: 30,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            calendarType: CalendarDatePicker2Type.range,

                            modePickersGap: 0,
                            weekdayLabels: [
                              'Mo',
                              'Tu',
                              'We',
                              'Th',
                              'Fr',
                              'Sa',
                              'Su',
                            ],
                            weekdayLabelTextStyle: context.text.labelMedium!
                                .copyWith(
                                  color: AppColors.neutral400,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),

                            selectedDayHighlightColor: AppColors.foundation500,
                            selectedDayTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),

                            todayTextStyle: const TextStyle(
                              color: Colors.black,
                            ),

                            centerAlignModePicker: true,
                            dayTextStyle: const TextStyle(color: Colors.black),

                            disableModePicker: true,
                            // hide dropdowns
                            controlsTextStyle: TextStyle(
                              color: AppColors.neutral600,
                              fontWeight: FontWeight.w700,
                              wordSpacing: -20,
                            ),
                          ),
                          value: _selectedDateRange,
                          onValueChanged: (dates) {
                            setState(() {
                              _selectedDateRange = dates;

                              // if (_selectedDateRange.length == 2 &&
                              //     _selectedDateRange[0] != null &&
                              //     _selectedDateRange[1] != null) {
                              //   _showCalendar = false;
                              // }
                            });
                          },
                        ),
                      ),
                    VerticalSpacing(28),

                    /// Location
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Location",
                        style: context.text.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    VerticalSpacing(16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF505588).withOpacity(0.06),
                            blurRadius: 30,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Color(0xFFA380D6).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Assets.images.mapColouredPng.image(
                                width: 14,
                                height: 14,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(child: Text("Gold Coast, AUS")),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.foundation500,
                          ),
                        ],
                      ),
                    ),
                    VerticalSpacing(28),

                    /// Price Range
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            "Select price range",
                            style: context.text.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        VerticalSpacing(16),
                        Text(
                          "\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}",
                          style: const TextStyle(
                            color: AppColors.foundation500,
                          ),
                        ),
                      ],
                    ),
                    VerticalSpacing(28),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3,
                        activeTrackColor: AppColors.foundation500,
                        inactiveTrackColor: AppColors.secondary100,
                        rangeThumbShape: CustomThumbShape(),
                      ),
                      child: RangeSlider(
                        values: _priceRange,
                        min: 0,
                        max: 150,
                        onChanged: (values) {
                          setState(() {
                            _priceRange = values;
                          });
                        },
                      ),
                    ),
                    VerticalSpacing(40),

                    /// Apply Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.5),
                      child: AppOutlinedButtonWithArrow(
                        onPressed: () {
                          Get.offAll(DashboardScreen(initialIndex: 0));
                        },
                        isLoading: false,
                        backgroundColor: AppColors.foundation500,
                        textColor: Colors.green,
                        text: 'APPLY',
                        textStyle: context.text.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                        height: 58,
                      ),
                    ),

                    VerticalSpacing(16),

                    /// Reset Filters
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Reset Filters",
                          style: TextStyle(color: AppColors.foundation500),
                        ),
                      ),
                    ),
                    VerticalSpacing(context.devicePaddingBottom + 50),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 60),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomThumbShape extends RangeSliderThumbShape {
  static const double _thumbSize = 40.0;
  static const double _triangleSize = 10.0;
  static const double _arrowSpacing = 6.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(_thumbSize / 2);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    bool isOnTop = false,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: _thumbSize, height: _thumbSize),
      const Radius.circular(8),
    );
    final Paint paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

    final Paint borderPaint =
        Paint()
          ..color = AppColors.foundation500
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    canvas.drawRRect(rrect, paint);
    canvas.drawRRect(rrect, borderPaint);

    // Draw the left triangle pointing INWARD (<|)
    Path leftTrianglePath = Path();
    leftTrianglePath.moveTo(center.dx - (_arrowSpacing / 2), center.dy);
    leftTrianglePath.lineTo(
      center.dx - (_arrowSpacing / 2) - _triangleSize,
      center.dy - _triangleSize / 2,
    );
    leftTrianglePath.lineTo(
      center.dx - (_arrowSpacing / 2) - _triangleSize,
      center.dy + _triangleSize / 2,
    );
    leftTrianglePath.close();

    // Draw the right triangle pointing INWARD (|>)
    Path rightTrianglePath = Path();
    rightTrianglePath.moveTo(center.dx + (_arrowSpacing / 2), center.dy);
    rightTrianglePath.lineTo(
      center.dx + (_arrowSpacing / 2) + _triangleSize,
      center.dy - _triangleSize / 2,
    );
    rightTrianglePath.lineTo(
      center.dx + (_arrowSpacing / 2) + _triangleSize,
      center.dy + _triangleSize / 2,
    );
    rightTrianglePath.close();

    // Instead of flipping, directly draw the triangles with points facing inward

    // Draw the left triangle pointing inward (<|)
    Path leftInwardTriangle = Path();
    // Start at the left point of the triangle
    leftInwardTriangle.moveTo(
      center.dx - (_arrowSpacing / 2) - _triangleSize,
      center.dy,
    );
    // Draw line to top-right corner
    leftInwardTriangle.lineTo(
      center.dx - (_arrowSpacing / 2),
      center.dy - _triangleSize / 2,
    );
    // Draw line to bottom-right corner
    leftInwardTriangle.lineTo(
      center.dx - (_arrowSpacing / 2),
      center.dy + _triangleSize / 2,
    );
    leftInwardTriangle.close();

    // Draw the right triangle pointing inward (|>)
    Path rightInwardTriangle = Path();
    // Start at the right point of the triangle
    rightInwardTriangle.moveTo(
      center.dx + (_arrowSpacing / 2) + _triangleSize,
      center.dy,
    );
    // Draw line to top-left corner
    rightInwardTriangle.lineTo(
      center.dx + (_arrowSpacing / 2),
      center.dy - _triangleSize / 2,
    );
    // Draw line to bottom-left corner
    rightInwardTriangle.lineTo(
      center.dx + (_arrowSpacing / 2),
      center.dy + _triangleSize / 2,
    );
    rightInwardTriangle.close();

    canvas.drawPath(leftInwardTriangle, Paint()..color = Colors.black54);
    canvas.drawPath(rightInwardTriangle, Paint()..color = Colors.black54);
  }
}

// class CustomRangeTrackShape extends RangeSliderTrackShape {
//   @override
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final double trackHeight = sliderTheme.trackHeight ?? 4.0;
//     final double trackLeft = offset.dx + 12;
//     final double trackTop =
//         offset.dy + (parentBox.size.height - trackHeight) / 2;
//     final double trackWidth = parentBox.size.width - 24;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }

//   @override
//   void paint({
//     required PaintingContext context,
//     required RenderBox parentBox,
//     required SliderThemeData sliderTheme,
//     required Animation<double> enableAnimation,
//     required Offset offset,
//     required TextDirection textDirection,
//     required RangeValues values,
//     required double trackHeight,
//     required List<Offset> thumbCenters,
//     bool isEnabled = true,
//     bool isDiscrete = false,
//   }) {
//     if (thumbCenters.isEmpty) {
//       return;
//     }

//     final Canvas canvas = context.canvas;
//     final double trackLeft = offset.dx + 12;
//     final double trackTop =
//         offset.dy + (parentBox.size.height - trackHeight) / 2;
//     final double trackWidth = parentBox.size.width - 24;

//     // Draw inactive track
//     final Paint inactivePaint = Paint()
//       ..color = sliderTheme.inactiveTrackColor ?? Colors.grey.shade300
//       ..style = PaintingStyle.fill;

//     final Rect inactiveTrackRect = Rect.fromLTWH(
//       trackLeft,
//       trackTop,
//       trackWidth,
//       trackHeight,
//     );

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//           inactiveTrackRect, Radius.circular(trackHeight / 2)),
//       inactivePaint,
//     );

//     // Draw active track
//     final Paint activePaint = Paint()
//       ..color = sliderTheme.activeTrackColor ?? Colors.purple
//       ..style = PaintingStyle.fill;

//     final double leftThumbOffset = thumbCenters[0].dx;
//     final double rightThumbOffset = thumbCenters[1].dx;

//     final Rect activeTrackRect = Rect.fromLTWH(
//       leftThumbOffset,
//       trackTop,
//       rightThumbOffset - leftThumbOffset,
//       trackHeight,
//     );

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//           activeTrackRect, Radius.circular(trackHeight / 2)),
//       activePaint,
//     );
//   }
// }

// class CustomThumbShape extends RangeSliderThumbShape {
//   static const double _thumbSize = 30;
//   static final Widget _icon = Assets.images.priceRangeIcon.svg(
//     colorFilter: const ColorFilter.mode(
//       AppColors.white,
//       BlendMode.srcIn,
//     ),
//   );

//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
//       const Size(_thumbSize, _thumbSize);

//   @override
//   void paint(
//     PaintingContext context,
//     Offset center, {
//     Animation<double>? activationAnimation,
//     Animation<double>? enableAnimation,
//     bool? isDiscrete,
//     bool? isEnabled,
//     bool? isOnTop,
//     bool? isPressed,
//     SliderThemeData? sliderTheme,
//     TextDirection? textDirection,
//     Thumb? thumb,
//   }) {
//     final Canvas canvas = context.canvas;

//     final RRect rrect = RRect.fromRectAndRadius(
//       Rect.fromCenter(center: center, width: _thumbSize, height: _thumbSize),
//       const Radius.circular(8),
//     );

//     final Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

//     final Paint borderPaint = Paint()
//       ..color = AppColors.primaryContainerColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;

//     canvas.drawRRect(rrect, paint);
//     canvas.drawRRect(rrect, borderPaint);

//     // Draw double arrow (you can replace this with an IconPainter if needed)
//     final textPainter = TextPainter(
//       text: const TextSpan(
//         text: '⇔',
//         style: TextStyle(
//           fontSize: 16,
//           color: AppColors.primaryContainerColor,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       textDirection: textDirection ?? TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(
//       canvas,
//       Offset(
//         center.dx - textPainter.width / 2,
//         center.dy - textPainter.height / 2,
//       ),
//     );
//   }
// }

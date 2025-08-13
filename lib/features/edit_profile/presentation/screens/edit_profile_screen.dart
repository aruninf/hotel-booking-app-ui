import 'package:intl/intl.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/edit_profile/presentation/controllers/edit_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller = Get.find<EditProfileController>();

  bool showInterestSelection = false;
  late TextEditingController interestController;
  late TextEditingController searchController;

  final Set<String> selectedAreas = {'Business'};

  List<String> interets = [
    'Business',
    'Design',
    'Technology',
    'Architecture',
    'Engineering',
    'Marketing',
  ];

  List<String> filteredinterets = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    interestController = TextEditingController(text: 'Business');
    searchController = TextEditingController();

    filteredinterets = List.from(interets);
  }

  @override
  void dispose() {
    interestController.dispose();
    searchController.dispose();

    scrollController.dispose();
    super.dispose();
  }

  void updateSelectedAreas(String area, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedAreas.add(area);
      } else {
        selectedAreas.remove(area);
      }
      interestController.text = selectedAreas.join(', ');
    });
  }

  void filterAreas(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredinterets = List.from(interets);
      } else {
        filteredinterets =
            interets
                .where(
                  (area) => area.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          title: 'Edit Profile',
          onTap: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 18,
          ).copyWith(bottom: context.devicePaddingBottom + 28),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Form(
                    key: controller.formkey,
                    child: Column(
                      children: [
                        AppTextFormField(
                          labelText: 'Full Name',
                          controller: controller.nameController,
                          textInputType: TextInputType.name,
                          autofillHints: const [AutofillHints.givenName],
                          validator: ValidationBuilder().required().build(),
                        ),
                        const VerticalSpacing(30),
                        AppTextFormField(
                          labelText: 'Email Address',
                          controller: controller.emailController,
                          validator: ValidationBuilder().required().build(),
                          textInputType: TextInputType.emailAddress,
                        ),
                        const VerticalSpacing(30),
                        AppTextFormField(
                          controller: controller.dobController,
                          isReadOnly: true,
                          onTap: () async {
                            try {
                              var selectedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    controller.dobController.text.isNotEmpty
                                        ? DateFormat(
                                          'dd-MM-yyyy',
                                        ).parse(controller.dobController.text)
                                        : DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                              );

                              if (selectedDate != null) {
                                controller.dobController.text = DateFormat(
                                  'dd-MM-yyyy',
                                ).format(selectedDate);
                              }
                            } catch (e) {
                              print('Error parsing date: $e');
                            }
                          },
                          labelText: 'Date of Birth',
                          validator: ValidationBuilder().required().build(),
                        ),
                        const VerticalSpacing(30),
                        AppTextFormField(
                          labelText: 'Phone Number',
                          controller: controller.phoneNumberController,
                          textInputType: TextInputType.phone,
                          maxLength: 11,
                          validator:
                              ValidationBuilder()
                                  .required()
                                  .phone()
                                  .maxLength(12, 'Phone number too long')
                                  .minLength(10, 'Phone number too short')
                                  .build(),
                        ),
                        const VerticalSpacing(30),
                        AppTextFormField(
                          labelText: 'Location',
                          controller: controller.locationController,
                          validator: ValidationBuilder().required().build(),
                        ),
                        const VerticalSpacing(30),
                        AppTextFormField(
                          labelText: 'Interests',
                          isReadOnly: true,
                          controller: interestController,
                          suffixIcon: Assets.images.downArrow.svg().paddingOnly(
                            right: 12,
                          ),
                          onTap: () {
                            setState(() {
                              showInterestSelection = !showInterestSelection;
                            });
                            if (showInterestSelection) {
                              scrollController.animateTo(
                                300,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                        if (showInterestSelection)
                          SearchAddNewField(
                            searchController: searchController,
                            hintText: 'Search',
                            interest: filteredinterets,
                            filterAreas: filterAreas,
                            updateSelectedAreas: updateSelectedAreas,
                            selectedAreas: selectedAreas,
                          ).paddingOnly(bottom: 16),
                        const VerticalSpacing(16),
                      ],
                    ),
                  ),
                ),
              ),
              if (!isKeyboardVisible)
                AppOutlinedButton(
                  text: 'SAVE CHANGES',
                  onPressed: () async {
                    if (!AppUtils.validateForm(controller.formkey)) {
                      return;
                    }
                    UiHelper.showloaderdialog(context);
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.pop(Get.overlayContext!);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              if (MediaQuery.of(context).size.height < 700)
                const VerticalSpacing(20),
            ],
          ),
        ),
      ),
    );
  }
}

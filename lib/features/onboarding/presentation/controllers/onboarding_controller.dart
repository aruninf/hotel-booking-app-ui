import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/data/source/onboarding_remote_source.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingController extends GetxController with WidgetsBindingObserver {
  OnboardingController({required this.remoteSource});

  final OnboardingRemoteSource remoteSource;

  late GlobalKey<FormState> formDetailsKey;
  late GlobalKey<FormState> verifyPhoneKey;
  late GlobalKey<FormState> newPassKey;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController = TextEditingController();
  late TextEditingController locationController;

  late TextEditingController newPassword;
  late TextEditingController confirmPassword;
  late TextEditingController pinController;
  late TextEditingController otpController;
  late TextEditingController searchController;

  final isFormValid = false.obs;
  final isOnboardingValid = false.obs;
  final isPhoneVerifyValid = false.obs;
  RxInt countdown = 10.obs;
  RxBool isValidated = true.obs;
  RxString otp = ''.obs;
  RxBool canResend = false.obs;
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  RxBool isConfirmPassword = false.obs;
  RxBool isPasswordValid = false.obs;
  RxBool containsNumber = false.obs;
  RxBool containsLetter = false.obs;
  RxBool containsSymbol = false.obs;
  RxBool hasMinLength = false.obs;
  Rx<XFile?> selectedImage = Rx<XFile?>(null);
  var filteredInterests = <Interests>[].obs;
  Timer? timer;

  Rx<PageController> pageController = PageController().obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  RxInt pageIndex = 0.obs;

  RxBool allPushNotification = false.obs;
  RxBool notification1 = true.obs;
  RxBool notification2 = false.obs;
  RxBool notification3 = true.obs;
  RxBool notification4 = true.obs;
  RxBool notification5 = false.obs;
  RxBool notification6 = false.obs;
  RxBool notification7 = false.obs;
  RxBool isLocationGranted = false.obs;
  RxString dob = ''.obs;

  var interests =
      <Interests>[
        Interests(name: 'Flutter'),
        Interests(name: 'Dart'),
        Interests(name: 'JavaScript'),
        Interests(name: 'Python'),
        Interests(name: 'Java'),
        Interests(name: 'SQL'),
        Interests(name: 'HTML'),
        Interests(name: 'CSS'),
        Interests(name: 'Node.js'),
        Interests(name: 'React'),
        Interests(name: 'Go'),
        Interests(name: 'Swift'),
        Interests(name: 'Kotlin'),
        Interests(name: 'Ruby'),
        Interests(name: 'C++'),
        Interests(name: 'PHP'),
      ].obs;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    formDetailsKey = GlobalKey<FormState>();
    verifyPhoneKey = GlobalKey<FormState>();
    newPassKey = GlobalKey<FormState>();

    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    locationController = TextEditingController();

    otpController = TextEditingController();
    pinController = TextEditingController();
    newPassword = TextEditingController();
    confirmPassword = TextEditingController();

    searchController = TextEditingController();

    filteredInterests.assignAll(interests);

    searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(Duration(milliseconds: 300), () {
        filterInterests(searchController.text);
      });
    });
    WidgetsBinding.instance.addObserver(this);
    checkPermission();

    createPasswordFocusNode.addListener(
      _updateCreatePasswordPrefixIconVisibility,
    );
    createConfirmPasswordFocusNode.addListener(
      _updateCreateConfirmPasswordPrefixIconVisibility,
    );

    newPassword.addListener(_updateCreatePasswordPrefixIconVisibility);
    confirmPassword.addListener(
      _updateCreateConfirmPasswordPrefixIconVisibility,
    );

    // confirmPassword.addListener(() {
    //   isConfirmPassword.value = true;
    //   validateForm(newPassKey);
    // });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Handle lifecycle changes as needed
    if (state == AppLifecycleState.resumed) {
      // App has come to the foreground (resumed), check permission again
      checkPermission();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    // dobController.dispose();
    locationController.dispose();

    otpController.dispose();
    pinController.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    searchController.dispose();

    createPasswordFocusNode.dispose();
    createConfirmPasswordFocusNode.dispose();

    timer?.cancel();
    _debounce?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void pageControllerDispose() {
    pageController.value.dispose();
  }

  void moveToPreviousPage() {
    if (pageController.value.page != null && pageController.value.page! > 0) {
      pageController.value.animateToPage(
        pageController.value.page!.toInt() - 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  void moveToNextPage(int currentIndex) {
    pageController.value.animateToPage(
      pageController.value.page!.toInt() + 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void startTimer() {
    countdown.value = 30;
    canResend.value = false;
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (Timer timer) {
      if (countdown.value == 0) {
        timer.cancel();
        canResend.value = true;
      } else {
        countdown.value--;
      }
    });
  }

  void resendCode() {
    if (!canResend.value) return;
    timer?.cancel();
    countdown.value = 10;
    startTimer();
  }

  seePassword() {
    showPassword.value = !showPassword.value;
  }

  seeConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void validateForm(GlobalKey<FormState> formState) {
    isFormValid.value = formState.currentState?.validate() ?? false;
  }

  void validateVerifyPhoneForm() {
    final isValid = verifyPhoneKey.currentState?.validate() ?? false;
    isPhoneVerifyValid.value = isValid;
  }

  void validateOnboarding(GlobalKey<FormState> key) {
    final isValid = key.currentState?.validate() ?? false;
    final isDobFilled = dob.value.isNotEmpty;
    isOnboardingValid.value = isValid && isDobFilled;
  }

  void validatePassword(String value) {
    hasMinLength.value = value.length >= 8;
    containsNumber.value = value.contains(RegExp(r'\d'));
    containsLetter.value = value.contains(RegExp(r'[A-Za-z]'));
    containsSymbol.value = value.contains(
      RegExp(r'[!@#\$%^&*(),.?":{}|<>\[\]\\/~`_\-+=]'),
    );

    isPasswordValid.value =
        hasMinLength.value &&
        containsNumber.value &&
        containsLetter.value &&
        containsSymbol.value;

    validateForm(newPassKey);
  }

  void validateAndRoute() {
    final isValid = verifyPhoneKey.currentState?.validate() ?? false;
    if (isValid) {
      moveToNextPage(pageController.value.page!.toInt());
    }
  }

  void toggleSelection(int index) {
    int originalIndex = interests.indexWhere(
      (element) => element.name == filteredInterests[index].name,
    );

    if (originalIndex != -1) {
      interests[originalIndex].selected = !interests[originalIndex].selected;
    }

    filteredInterests[index].selected = !filteredInterests[index].selected;
    update();
  }

  void filterInterests(String query) {
    if (query.isEmpty) {
      filteredInterests.assignAll(interests);
    } else {
      filteredInterests.assignAll(
        interests.where(
          (interest) =>
              interest.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  void checkPermission() async {
    var status = await Permission.location.status;
    isLocationGranted.value = status.isGranted;
  }

  void requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      isLocationGranted.value = true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void checkFieldsFilled() {
    isOnboardingValid.value =
        nameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        dob.value.trim().isNotEmpty &&
        locationController.text.trim().isNotEmpty;
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    locationController.clear();
    dobController.clear();
    pinController.clear();
    isOnboardingValid.value = false;
  }

  void clearVerify() {
    phoneController.clear();
    isPhoneVerifyValid.value = false;
  }

  // Password prefix icon visibility
  final createPasswordFocusNode = FocusNode();
  final createConfirmPasswordFocusNode = FocusNode();

  final showCreatePasswordPrefixIcon = true.obs;
  final showCreateConfirmPasswordPrefixIcon = true.obs;

  final showCreatePasswordSuffixIcon = false.obs;
  final showCreateConfirmPasswordSuffixIcon = false.obs;

  void _updateCreatePasswordPrefixIconVisibility() {
    final isFocused = createPasswordFocusNode.hasFocus;
    final hasText = newPassword.text.isNotEmpty;
    showCreatePasswordPrefixIcon.value = !(isFocused || hasText);
    showCreatePasswordSuffixIcon.value = isFocused || hasText;
  }

  void _updateCreateConfirmPasswordPrefixIconVisibility() {
    final isFocused = createConfirmPasswordFocusNode.hasFocus;
    final hasText = confirmPassword.text.isNotEmpty;
    showCreateConfirmPasswordPrefixIcon.value = !(isFocused || hasText);
    showCreateConfirmPasswordSuffixIcon.value = isFocused || hasText;
  }
}

class Interests {
  final String name;
  bool selected;

  Interests({required this.name, this.selected = false});
}

import 'package:get/get.dart';
import 'package:nudge/core/constants/app_success_screen.dart';
import 'package:nudge/features/account_privacy/presentation/controllers/account_privacy_bindings.dart';
import 'package:nudge/features/account_privacy/presentation/screens/account_privacy_screen.dart';
import 'package:nudge/features/change_password/presentation/controllers/change_password_bindings.dart';
import 'package:nudge/features/change_password/presentation/screens/change_password_screen.dart';
import 'package:nudge/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:nudge/features/edit_profile/presentation/controllers/edit_profile_bindings.dart';
import 'package:nudge/features/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:nudge/features/email_notification/presentation/controllers/email_notification_bindings.dart';
import 'package:nudge/features/email_notification/presentation/screens/email_notification_screen.dart';
import 'package:nudge/features/explainers/presentation/screens/explainers_screen.dart';
import 'package:nudge/features/faqs/presentation/controllers/faqs_bindings.dart';
import 'package:nudge/features/faqs/presentation/screens/faqs_screen.dart';
import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_bindings.dart';
import 'package:nudge/features/favourite_events/presentation/screens/favourite_events_screen.dart';
import 'package:nudge/features/help/presentation/controllers/help_bindings.dart';
import 'package:nudge/features/help/presentation/screens/help_screen.dart';
import 'package:nudge/features/home/presentation/controllers/home_bindings.dart';
import 'package:nudge/features/home/presentation/screens/home_screen.dart';
import 'package:nudge/features/home/presentation/screens/widgets/event_details.dart';
import 'package:nudge/features/invite_friends/presentation/controllers/invite_friends_bindings.dart';
import 'package:nudge/features/invite_friends/presentation/screens/invite_friends_screen.dart';
import 'package:nudge/features/login/presentation/controllers/forgot_password_bindings.dart';
import 'package:nudge/features/login/presentation/controllers/login_bindings.dart';
import 'package:nudge/features/login/presentation/controllers/otp_bindings.dart';
import 'package:nudge/features/login/presentation/controllers/reset_password_bindings.dart';
import 'package:nudge/features/login/presentation/screens/forgot_password.dart';
import 'package:nudge/features/login/presentation/screens/login_screen.dart';
import 'package:nudge/features/login/presentation/screens/otp_screen.dart';
import 'package:nudge/features/login/presentation/screens/password_success_screen.dart';
import 'package:nudge/features/login/presentation/screens/reset_password.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_bindings.dart';
import 'package:nudge/features/onboarding/presentation/screens/create_password_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/enable_location_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/notification_success.dart';
import 'package:nudge/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/select_interest_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/set_notification_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/signup_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/upload_photo_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/verify_phone_screen.dart';
import 'package:nudge/features/privacy_policy/presentation/controllers/privacy_policy_bindings.dart';
import 'package:nudge/features/privacy_policy/presentation/screens/privacy_policy_screen.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_bindings.dart';
import 'package:nudge/features/profile/presentation/screens/profile_screen.dart';
import 'package:nudge/features/push_notification_settings/presentation/controllers/push_notification_bindings.dart';
import 'package:nudge/features/push_notification_settings/presentation/screens/push_notification_screen.dart';
import 'package:nudge/features/search/presentation/controllers/search_bindings.dart';
import 'package:nudge/features/search/presentation/screens/search_screen.dart';
import 'package:nudge/features/splash/splash.dart';
import 'package:nudge/features/terms_and_conditions/presentation/controllers/terms_and_conditions_bindings.dart';
import 'package:nudge/features/terms_and_conditions/presentation/screens/terms_and_conditions_screen.dart';
import 'package:nudge/features/user_profile/presentation/controllers/user_profile_bindings.dart';
import 'package:nudge/features/user_profile/presentation/screens/user_profile_screen.dart';
import 'package:nudge/features/user_profile/presentation/screens/widgets/user_connected.dart';

class AppRoutes {
  static const String splash = '/';
  static const String explainerScreen = '/explainerScreen';
  static const String loginPage = '/login';
  static const String forgotPass = '/forgotPass';
  static const String otpScreen = '/otpScreen';
  static const String main = '/main';
  static const String onboarding = '/onboarding';
  static const String verifyPhone = '/verifyPhone';
  static const String signup = '/signup';
  static const String signupScreen = '/signupScreen';
  static const String resetPassword = '/resetPassword';
  static const String createPassword = '/createPassword';
  static const String uploadPhoto = '/uploadPhoto';
  static const String success = '/success';
  static const String successParam = '/successParam';
  static const String dashboard = '/dashboard';
  static const String selectInterest = '/selectInterest';
  static const String enableLocation = '/enableLocation';
  static const String setNotification = '/setNotification';
  static const String notificationSuccess = '/notificationSuccess';
  static const String home = '/homeScreen';
  static const String bottomNav = '/bottomNav';

  // static const String createPassword = '/createPassword';
  static const String changePassword = '/changePassword';
  static const String chatConversationScreen = '/chatConvesationScreen';
  static const String addYourPhotoScreen = '/addYourPhotoScreen';
  static const String addYourDetailsScreen = '/addYourDetailsScreen';
  static const String addYourOccupation = '/addYourOccupation';
  static const String notification = '/notification';
  static const String gettingStartedScreen = '/gettingStartedScreen';
  static const String landingScreen = '/landingScreen';
  static const String assesmentsScreen = '/assesmentsScreen';
  static const String assesmentsTrailer = '/assesmentsTrailer';
  static const String assesmentsResult = '/assesmentsResult';
  static const String notificationHistory = '/notificationHistory';
  static const String goalsOverview = '/goalsOverview';
  static const String profile = '/profile';
  static const String userProfile = '/userProfile';
  static const String favoriteEvent = '/favoriteEvent';
  static const String eventDetails = '/eventDetails';
  static const String reflectionScreen = '/reflectionScreen';
  static const String journalLibrary = '/journalLibrary';
  static const String addNewTask = '/addNewTask';
  static const String editProfile = '/editProfile';
  static const String accountPrivacy = '/accountPrivacy';
  static const String pushNotification = '/pushNotification';
  static const String emailNotification = '/emailNotification';
  static const String inviteFriends = '/inviteFriends';
  static const String help = '/help';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String communityGuidelines = '/community_guide_lines';
  static const String faqs = '/faq';
  static const String contactUs = '/user/contact-us';
  static const String search = '/search';
  static const String userConnected = '/userConnected';

  static List<GetPage<dynamic>>? appPages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: explainerScreen, page: () => const ExplainersScreen()),
    GetPage(
      name: loginPage,
      page: () => const LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: forgotPass,
      page: () => const ForgotPassword(),
      binding: ForgotPasswordBindings(),
    ),
    GetPage(
      name: otpScreen,
      page: () => const OtpScreen(),
      binding: OtpBindings(),
    ),
    GetPage(
      name: resetPassword,
      page: () => const ResetPassword(),
      binding: ResetPasswordBindings(),
    ),
    GetPage(name: success, page: () => const PasswordSuccessScreen()),
    GetPage(
      name: onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: signupScreen,
      page: () => const SignupScreen(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: verifyPhone,
      page: () => const VerifyPhoneScreen(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: createPassword,
      page: () => const CreatePasswordScreen(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: uploadPhoto,
      page: () => const UploadPhotoScreen(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: selectInterest,
      page: () => const SelectInterestScreen(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: enableLocation,
      page: () => const EnableLocationScreen(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: setNotification,
      page: () => const SetNotificationScreen(),
      binding: OnboardingBindings(),
    ),

    GetPage(
      name: notificationSuccess,
      page: () => const NotificationSuccess(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: accountPrivacy,
      page: () => const AccountPrivacyScreen(),
      binding: AccountPrivacyBindings(),
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfileScreen(),
      binding: EditProfileBindings(),
    ),
    GetPage(
      name: accountPrivacy,
      page: () => const AccountPrivacyScreen(),
      binding: AccountPrivacyBindings(),
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBindings(),
    ),
    GetPage(
      name: pushNotification,
      page: () => const PushNotificationSettingsScreen(),
      binding: PushNotificationSettingsBindings(),
    ),
    GetPage(
      name: emailNotification,
      page: () => const EmailNotificationScreen(),
      binding: EmailNotificationBindings(),
    ),
    GetPage(
      name: inviteFriends,
      page: () => const InviteFriendsScreen(),
      binding: InviteFriendsBindings(),
    ),
    GetPage(
      name: privacyPolicy,
      page: () => const PrivacyPolicyScreen(),
      binding: PrivacyPolicyBindings(),
    ),
    GetPage(
      name: termsAndConditions,
      page: () => const TermsAndConditionsScreen(),
      binding: TermsAndConditionsBindings(),
    ),
    GetPage(
      name: faqs,
      page: () => const FaqsScreen(),
      binding: FaqsBindings(),
    ),
    GetPage(
      name: help,
      page: () => const HelpScreen(),
      binding: HelpBindings(),
    ),
    GetPage(
      name: favoriteEvent,
      page: () => const FavouriteEventsScreen(),
      binding: FavouriteEventsBindings(),
    ),
    GetPage(name: eventDetails, page: () => const EventDetails()),
    GetPage(
      name: userProfile,
      page: () => const UserProfileScreen(),
      binding: UserProfileBindings(),
    ),
    GetPage(name: successParam, page: () => AppSuccessScreen()),

    GetPage(
      name: dashboard,
      page: () => DashboardScreen(),
      // binding: LoginBindings(),
    ),
    GetPage(
      name: search,
      page: () => SearchScreen(),
      binding: SearchBindings(),
    ),
    GetPage(
      name: userConnected,
      page: () => UserConnectedScreen(),
      // binding: SearchBindings(),
    ),
  ];
}

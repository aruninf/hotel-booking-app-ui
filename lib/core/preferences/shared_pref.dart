import 'package:nudge/core/preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  // Constructor to initialize SharedPreferences
  AppSharedPref(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  // Tokens

  Future<void> remove(key) async {
    await sharedPreferences.remove(key);
  }

  Future<String?> getAccessToken() async {
    final value = sharedPreferences.getString(PreferenceKeys.accessToken);
    return value;
  }

  Future<void> saveAccessToken(String value) async {
    await sharedPreferences.setString(PreferenceKeys.accessToken, value);
  }

  Future<String?> getRefreshToken() async {
    final value = sharedPreferences.getString(PreferenceKeys.refreshToken);
    return value;
  }

  Future<void> saveRefreshToken(String value) async {
    await sharedPreferences.setString(PreferenceKeys.refreshToken, value);
  }

  Future<void> saveString(String key, String val) async {
    await sharedPreferences.setString(key, val);
  }

  Future<String?> getString(String val) async {
    final value = sharedPreferences.getString(val);
    return value;
  }

  // Future<void> saveUserModel(UserProfileModel value) async {
  //   await sharedPreferences.setString(
  //     PreferenceKeys.userProfile,
  //     jsonEncode(value),
  //   );
  // }

  // Future<UserProfileModel?> getUserModel() async {
  //   final value = sharedPreferences.getString(PreferenceKeys.userProfile);
  //   if (value != null) {
  //     return UserProfileModel.fromJson(jsonDecode(value));
  //   } else {
  //     return null;
  //   }
  // }

  Future<void> removeAll() async {
    await sharedPreferences.clear();
  }
}

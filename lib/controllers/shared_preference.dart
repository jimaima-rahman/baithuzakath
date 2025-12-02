import 'package:shared_preferences/shared_preferences.dart';

class UserPreferenceService {
  static String? userToken;
  static String? userId;

  final prefs = SharedPreferences.getInstance();

  void saveToken(String token) async {
    userToken = token;
    await (await prefs).setString("user_token", token);
  }

  Future<String?> getToken() async {
    String? value = (await prefs).getString("user_token");
    userToken = value;
    return value;
  }

  void removeToken() async {
    await (await prefs).remove("user_token");
    userToken = null;
  }

  // User ID methods
  void saveUserId(String id) async {
    userId = id;
    await (await prefs).setString("user_id", id);
  }

  Future<String?> getUserId() async {
    String? value = (await prefs).getString("user_id");
    userId = value;
    return value;
  }

  void removeUserId() async {
    await (await prefs).remove("user_id");
    userId = null;
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    String? token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Clear all user data (logout)
  void clearAllUserData() async {
    await (await prefs).remove("user_token");
    await (await prefs).remove("user_id");
    userToken = null;
    userId = null;
  }
}

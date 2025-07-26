import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  Future<void> register(String fullName, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("fullName", fullName);
    prefs.setString("email", email);
    prefs.setString("password", password);
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final emailPref = prefs.getString("email");
    final passwordPref = prefs.getString("password");
    if (emailPref == email && passwordPref == password) {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("fullName");
    prefs.remove("email");
    prefs.remove("password");
    //prefs.clear();
  }

  Future<String?> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("fullName") ?? prefs.getString("email");
  }

  Future<String?> getSharedPrefByKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}

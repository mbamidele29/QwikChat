import 'package:QwikChat/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<void> setUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("uid", user.id);
    pref.setString("username", user.username);
    pref.setString("email", user.email);
    pref.setString("profilePicture", user.profilePicture);
  }

  Future<String> getUserKey(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey(key))
      return pref.getString(key);
    else
      return "";
  }
}

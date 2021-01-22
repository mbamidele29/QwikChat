import 'package:QwikChat/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<void> setUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("uid", user.id);
    await pref.setString("username", user.username);
    await pref.setString("email", user.email);
    await pref.setString("profilePicture", user.profilePicture);
  }

  Future<String> getUserKey(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey(key))
      return pref.getString(key);
    else
      return "";
  }

  Future<UserModel> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey("uid"))
      return UserModel(
          email: pref.getString("email"),
          id: pref.getString("uid"),
          username: pref.getString("username"),
          profilePicture: pref.getString("profilePicture"));
    else
      return null;
  }

  Future signout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}

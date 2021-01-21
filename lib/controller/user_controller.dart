import 'package:QwikChat/model/user_model.dart';
import 'package:QwikChat/repository/user_repository.dart';
import 'package:QwikChat/util/shared_preferences.dart';

class UserController {
  UserRepository userRepository;
  SharedPreference _preference;
  UserController() {
    _preference = SharedPreference();
    userRepository = UserRepository();
  }

  Future<bool> isUserLoggedin() async {
    String username = await _preference.getUserKey("username");
    return username.isNotEmpty;
    // return await userRepository.isSignedIn() != null;
  }

  Future<bool> signin(String username, String email, String password) async {
    if (username.isEmpty || password.isEmpty) return false;
    UserModel user = await userRepository.signup(username, email, password);

    print(user);
    if (user != null) {
      _preference.setUser(user);
      return true;
    } else
      return false;
  }
}

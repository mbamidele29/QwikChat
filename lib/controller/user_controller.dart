import 'package:QwikChat/model/user_model.dart';
import 'package:QwikChat/repository/user_repository.dart';
import 'package:QwikChat/util/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  UserRepository _userRepository;
  SharedPreference _preference;
  UserController() {
    _preference = SharedPreference();
    _userRepository = UserRepository();
  }

  Future<UserModel> getUser() async {
    return await _preference.getUser();
  }

  Future<bool> signup(String username, String email, String password) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) return false;
    UserModel user = await _userRepository.signup(username, email, password);

    if (user != null) {
      _preference.setUser(user);
      return true;
    } else
      return false;
  }

  Future<bool> signin(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;
    UserModel user = await _userRepository.signin(email, password);

    if (user != null) {
      await _preference.setUser(user);
      return true;
    } else
      return false;
  }

  Future<bool> signout() async {
    await _userRepository.signout();
    await _preference.signout();
    return true;
  }

  Stream<QuerySnapshot> getUsers({String username = ""}) {
    return _userRepository.getUsers(username: username);
  }
}

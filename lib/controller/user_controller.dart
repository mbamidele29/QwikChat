import 'package:QwikChat/model/user_model.dart';
import 'package:QwikChat/repository/user_repository.dart';
import 'package:QwikChat/util/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  UserModel _user;
  UserRepository userRepository;
  SharedPreference _preference;
  UserController() {
    _preference = SharedPreference();
    userRepository = UserRepository();
    setUser();
  }

  setUser() async {
    _user = await _preference.getUser();
  }

  get user => _user;

  Future<bool> isUserLoggedin() async {
    String username = await _preference.getUserKey("username");
    return username.isNotEmpty;
    // return await userRepository.isSignedIn() != null;
  }

  Future<bool> signup(String username, String email, String password) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) return false;
    UserModel user = await userRepository.signup(username, email, password);

    print(user);
    if (user != null) {
      _preference.setUser(user);
      return true;
    } else
      return false;
  }

  Future<bool> signin(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;
    UserModel user = await userRepository.signin(email, password);

    print(user);
    if (user != null) {
      _preference.setUser(user);
      return true;
    } else
      return false;
  }

  Future<bool> signout() async {
    await userRepository.signout();
    await _preference.signout();
    return true;
  }

  Stream<QuerySnapshot> getUsers() {
    return userRepository.getUsers();
  }
}

import 'package:QwikChat/model/user_model.dart';

abstract class UserRepositoryInterface {
  Future<UserModel> isSignedIn();
  Future<UserModel> signin(String username, String password);
  Future<UserModel> signup(String username, String email, String password);
  Future<bool> signout(String token);
}

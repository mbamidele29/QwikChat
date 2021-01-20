import 'package:QwikChat/model/user_model.dart';

abstract class UserRepositoryInterface {
  Future<UserModel> login(String username, String password);
  Future<bool> logout(String token);
}

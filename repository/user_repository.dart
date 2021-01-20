import 'package:QwikChat/interface/user_repository_interface.dart';
import 'package:QwikChat/model/user_model.dart';
import 'package:QwikChat/util/api.dart';
import 'package:QwikChat/util/network.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  Future<UserModel> login(String username, String password) async {
    String url = API.loginUrl;
    Map<String, dynamic> data = await Network.callAPI(
        url: url,
        networkAction: NetworkAction.POST,
        payload: {
          "username": username,
          "password": password,
        });

    if (data != null) {
      UserModel user = UserModel.fromJson(data);
      return user;
    }
    return null;
  }

  @override
  Future<bool> logout(String token) async {
    String url = API.logoutUrl;
    Map<String, dynamic> data = await Network.callAPI(
        url: url, networkAction: NetworkAction.POST, token: token);

    if (data != null) {
      return true;
    }
  }
}

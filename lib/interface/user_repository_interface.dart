import 'package:QwikChat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRepositoryInterface {
  Future<UserModel> isSignedIn();
  Future<UserModel> signin(String username, String password);
  Future<UserModel> signup(String username, String email, String password);
  Future<bool> signout();

  Stream<QuerySnapshot> getUsers({String username});
}

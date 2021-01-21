import 'package:QwikChat/interface/user_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../util/api.dart';
import '../util/network.dart';

class UserRepository implements UserRepositoryInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference collectionReference =
      Firestore.instance.collection("users");

  @override
  Future<UserModel> isSignedIn() async {
    FirebaseUser user = await _auth.currentUser();
    dynamic data = await collectionReference.document(user.uid).get();

    if (user != null) {
      return UserModel(
          id: data["uid"],
          email: data["email"],
          username: data["username"],
          profilePicture: "");
    }
    return null;
  }

  @override
  Future<UserModel> signup(
      String username, String email, String password) async {
    FirebaseUser user;
    try {
      user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (e) {
      print("DDDDDDDDDDD");
      print(e);
      return null;
    }

    if (user != null) {
      await collectionReference.document(user.uid).setData({
        "id": user.uid,
        "username": username,
        "email": email,
        "profilePicture": ""
      });
      return UserModel(id: user.uid, username: user.email, profilePicture: "");
    }
    return null;
  }

  @override
  Future<UserModel> signin(String email, String password) async {
    FirebaseUser user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (e) {
      print(e);
      return null;
    }

    if (user != null) {
      return UserModel(id: user.uid, username: user.email, profilePicture: "");
    }
    return null;
  }

  @override
  Future<bool> signout(String token) async {
    String url = API.logoutUrl;
    Map<String, dynamic> data = await Network.callAPI(
        url: url, networkAction: NetworkAction.POST, token: token);

    if (data != null) {
      return true;
    }
  }
}

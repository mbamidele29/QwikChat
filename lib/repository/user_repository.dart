import 'package:QwikChat/interface/user_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/user_model.dart';

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
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }

    if (user != null) {
      final Map<String, String> data = {
        "uid": user.uid,
        "username": username,
        "email": email,
        "profilePicture": ""
      };
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("uid", isEqualTo: user.uid)
          .getDocuments();

      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance.collection("users").document(user.uid).setData(data);
      }

      return UserModel.fromJson(data);
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
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }

    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("uid", isEqualTo: user.uid)
          .getDocuments();

      final List<DocumentSnapshot> documents = result.documents;
      return UserModel(
          id: user.uid,
          email: user.email,
          username: user.email,
          profilePicture: "");
    }
    return null;
  }

  @override
  Stream<QuerySnapshot> getUsers({String username = ""}) {
    if (username == null || username.isEmpty) {
      return Firestore.instance.collection("users").snapshots();
    } else {
      return Firestore.instance
          .collection("users")
          .where("username", isEqualTo: username.trim())
          .snapshots();
    }
  }

  @override
  Future<bool> signout() async {
    await _auth.signOut();
    return true;
  }
}

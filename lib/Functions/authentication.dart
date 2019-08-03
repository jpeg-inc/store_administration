import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_administration/log_in_screen.dart';

class Authentication {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
  SharedPreferences sharedPreferences;

  Future<String> signIn(
      {@required String email, @required String password}) async {
    try {
      user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return user.uid;
    } catch (error) {
      return null;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    user = await firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }

  Future<bool> changePassword(
      {@required String oldPassword,
      @required String newPassword,
      @required BuildContext context}) async {
    user = await getCurrentUser();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      FirebaseUser reAuthUser = await firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: oldPassword);
      if (reAuthUser.uid != null) {
        reAuthUser.updatePassword(newPassword);
        sharedPreferences.clear().whenComplete(() {
          Navigator.of(context)
              .pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false)
              .whenComplete(() {
            Authentication().signOut();
          });
        });
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> resetPassword({@required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}

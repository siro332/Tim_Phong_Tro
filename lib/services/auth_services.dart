import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tim_phong_tro/models/entities/user.dart';
import 'package:tim_phong_tro/models/my_shared_preferences.dart';
import 'package:tim_phong_tro/models/user.dart';
import 'package:tim_phong_tro/services/user_services.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  AppUserE? _user(User? user) {
    return user == null ? null : AppUserE(uid: user.uid, image: user.photoURL);
  }

  GoogleSignInAccount? _googleUser;
  AppUserE? get currentUser => _user(_auth.currentUser);
  Stream<AppUserE?> get user =>
      _auth.authStateChanges().map((User? user) => _user(user));
  //auth change user stream
  Future googleLogin() async {
    final gUser = await googleSignIn.signIn();
    if (gUser == null) return;
    final gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    await _auth.signInWithCredential(credential);
    _user(FirebaseAuth.instance.currentUser);
    notifyListeners();
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      // _userFromFirebase(user);
      String res = kSignedIn;
      return res;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static signIn(email, password) async {
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + "/api/auth/login"),
        body: {"email": email, "password": password},
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
      );
      var jsonData;
      if (response.statusCode == 200) {
        jsonData = jsonDecode(response.body);
        String token = await MysharedPreferences.instance
            .setStringValue(AppUser.accessToken, jsonData[AppUser.accessToken]);

        await MysharedPreferences.instance.setStringValue(
            AppUser.refreshToken, jsonData[AppUser.refreshToken]);

        String username = await MysharedPreferences.instance
            .setStringValue(AppUser.username, jsonData[AppUser.username]);
        await UserServices.getUserInfo(token, username);
        return kAccessToken;
      } else if (response.statusCode == 401) {
        return kWrongEmailPassword;
      }
      return kNetworkError;
    } catch (error) {
      return kNetworkError;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
    await MysharedPreferences.instance.clearData();
    await MysharedPreferences.instance.setBooleanValue("secondTimeOpen", true);
  }

  bool isLogedIn() {
    return _auth.currentUser != null ? true : false;
  }

  sendPassWordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }
}

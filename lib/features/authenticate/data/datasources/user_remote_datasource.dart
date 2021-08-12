import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tim_phong_tro/core/error/exceptions.dart';
import 'package:tim_phong_tro/core/firebase/firebase.dart';
import 'package:tim_phong_tro/features/authenticate/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:tim_phong_tro/models/my_shared_preferences.dart';

import '../../../../constants.dart';

abstract class UserRemoteDataSource {
  Future<AppUserModel> getCurrentUser();
  Future<AppUserModel> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<AppUserModel> signInWithGoogle();
  Future<AppUserModel> signInWithFacebook();
  Future<AppUserModel> register(
      {required String email, required String password});

  Future<String> getCurrentUserToken();

  Future<void> signOut();

  Future<void> resetPassword({required String email});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth _auth = FirebaseImpl().getAuth();
  final googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookAuth.instance;

  @override
  Future<AppUserModel> getCurrentUser() async {
    try {
      return AppUserModel(uid: _auth.currentUser!.uid);
    } catch (e) {
      throw AuthException(message: "No user");
    }
  }

  @override
  Future<String> getCurrentUserToken() async {
    return await _auth.currentUser!.getIdToken();
  }

  @override
  Future<AppUserModel> register(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String token = await _auth.currentUser!.getIdToken();
      String result = await registerToServer(token);
      if (result == "Ok") {
        await _auth.currentUser!.getIdToken(true);
        return AppUserModel(uid: userCredential.user!.uid);
      } else {
        await signOut();
        throw AuthException(message: "Error registering user to server");
      }
    } catch (e) {
      await signOut();
      throw AuthException(message: e.toString().split("] ")[1]);
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw AuthException(message: e.toString().split("] ")[1]);
    }
  }

  @override
  Future<AppUserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      String token = await _auth.currentUser!.getIdToken();
      String result = await registerToServer(token);
      if (result == "Ok") {
        await _auth.currentUser!.getIdToken(true);
        return AppUserModel(uid: userCredential.user!.uid);
      } else {
        await signOut();
        throw AuthException(message: "Error registering user to server");
      }
    } catch (e) {
      await signOut();
      throw AuthException(message: e.toString().split("] ")[1]);
    }
  }

  @override
  Future<AppUserModel> signInWithFacebook() async {
    final LoginResult result = await facebookSignIn.login();
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);
      try {
        await _auth.signInWithCredential(facebookAuthCredential);
        String token = await _auth.currentUser!.getIdToken();
        String serverResult = await registerToServer(token);
        if (serverResult == "Ok") {
          await _auth.currentUser!.getIdToken(true);
          return AppUserModel(uid: _auth.currentUser!.uid);
        } else {
          await signOut();
          throw AuthException(message: "Error registering user to server");
        }
      } catch (e) {
        await signOut();
        throw AuthException(message: e.toString().split("] ")[1]);
      }
    }
    throw AuthException(message: result.message.toString());
  }

  @override
  Future<AppUserModel> signInWithGoogle() async {
    final gUser = await googleSignIn.signIn();
    if (gUser == null)
      throw AuthException(message: "Cannot find this Google User");
    final gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    await _auth.signInWithCredential(credential);
    String token = await _auth.currentUser!.getIdToken();
    String serverResult = await registerToServer(token);
    if (serverResult == "Ok") {
      await _auth.currentUser!.getIdToken(true);
      return AppUserModel(uid: _auth.currentUser!.uid);
    } else {
      await signOut();
      throw AuthException(message: "Error registering user to server");
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {}
    await MysharedPreferences.instance.clearData();
    await MysharedPreferences.instance.setBooleanValue("secondTimeOpen", true);
  }

  Future<String> registerToServer(String token) async {
    Map data = {'token': token};
    //encode Map to JSON
    var body = json.encode(data);

    try {
      var response = await http.post(
        Uri.parse(BASE_URL + "/api/auth/signup"),
        body: body,
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200 ||
          response.body.toString().contains("already exist")) {
        return "Ok";
      } else {
        return "";
      }
    } catch (e) {
      return e.toString();
    }
  }
}

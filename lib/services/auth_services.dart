// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:tim_phong_tro/features/authenticate/domain/entities/user.dart';
// import 'package:tim_phong_tro/models/my_shared_preferences.dart';
// import 'package:tim_phong_tro/services/user_services.dart';

// import '../constants.dart';
// import 'package:http/http.dart' as http;

// class AuthServices extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final googleSignIn = GoogleSignIn();
//   final facebookSignIn = FacebookAuth.instance;
//   AppUser? _user(User? user) {
//     return user == null ? null : AppUser(uid: user.uid);
//   }

//   Future<String> getCurrentUserToken() async {
//     return await _auth.currentUser!.getIdToken();
//   }

//   AppUser? get currentUser => _user(_auth.currentUser);
//   Stream<AppUser?> get user =>
//       _auth.authStateChanges().map((User? user) => _user(user));
//   //auth change user stream
//   Future<String> googleLogin() async {
//     final gUser = await googleSignIn.signIn();
//     if (gUser == null) return "Error";
//     final gAuth = await gUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//         accessToken: gAuth.accessToken, idToken: gAuth.idToken);
//     await _auth.signInWithCredential(credential);
//     String token = await _auth.currentUser!.getIdToken();
//     await registerToServer(token);
//     String newToken = await _auth.currentUser!.getIdToken(true);
//     _user(_auth.currentUser);
//     UserServices().getUserInfo(newToken, _auth.currentUser!.uid);
//     notifyListeners();
//     return kSignedIn;
//   }

//   Future<String> facebookLogin() async {
//     final LoginResult result = await facebookSignIn.login();
//     if (result.status == LoginStatus.success) {
//       final AccessToken accessToken = result.accessToken!;

//       final OAuthCredential facebookAuthCredential =
//           FacebookAuthProvider.credential(accessToken.token);
//       try {
//         await _auth.signInWithCredential(facebookAuthCredential);
//         String token = await _auth.currentUser!.getIdToken();
//         await registerToServer(token);
//         String newToken = await _auth.currentUser!.getIdToken(true);
//         _user(_auth.currentUser);

//         UserServices().getUserInfo(newToken, _auth.currentUser!.uid);
//         notifyListeners();
//         return kSignedIn;
//       } on Exception catch (e) {
//         return e.toString().split("] ")[1];
//       }
//     }
//     return result.message.toString();
//   }

//   Future<String> signInWithEmailPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       String token = await _auth.currentUser!.getIdToken();
//       await registerToServer(token);
//       log(await _auth.currentUser!.getIdToken(true));
//       this._user(result.user);
//       return kSignedIn;
//     } catch (e) {
//       await signOut();
//       return e.toString().split("] ")[1];
//     }
//   }

//   Future<String> registerWithEmailPassword(
//       String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       String token = await result.user!.getIdToken();
//       await registerToServer(token);
//       String newToken = await _auth.currentUser!.getIdToken(true);
//       UserServices().getUserInfo(newToken, _auth.currentUser!.uid);
//       return kSignedIn;
//     } catch (e) {
//       return e.toString().split("] ")[1];
//     }
//   }

//   Future<String> registerToServer(String token) async {
//     Map data = {'token': token};
//     //encode Map to JSON
//     var body = json.encode(data);

//     try {
//       var response = await http.post(
//         Uri.parse(BASE_URL + "/api/auth/signup"),
//         body: body,
//         headers: {
//           "Content-Type": "application/json",
//         },
//       );
//       if (response.statusCode == 200 ||
//           response.body.toString().contains("already exist")) {
//         return "Ok";
//       } else {
//         await signOut();
//         return "";
//       }
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       return null;
//     }
//     await MysharedPreferences.instance.clearData();
//     await MysharedPreferences.instance.setBooleanValue("secondTimeOpen", true);
//   }

//   bool isLogedIn() {
//     return _auth.currentUser != null ? true : false;
//   }

//   sendPassWordResetEmail(String email) async {
//     return _auth.sendPasswordResetEmail(email: email);
//   }
// }

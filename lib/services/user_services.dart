import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tim_phong_tro/features/authenticate/domain/entities/user.dart';
import 'package:tim_phong_tro/models/my_shared_preferences.dart';
import 'package:tim_phong_tro/models/dtos/user_info.dart';
import 'package:tim_phong_tro/services/auth_services.dart';

import '../constants.dart';

import 'package:http/http.dart' as http;

class UserServices {
  var user = FirebaseAuth.instance.currentUser;
  Future<String> updateUserCommonInfo(String name, String phoneNumber) async {
    if (user != null) {
      user!.updateDisplayName(name);
      return "Ok";
    }
    return kNetworkError;
  }

  getUserInfo(String token, String uid) async {
    try {
      var response = await http.get(
        Uri.parse(BASE_URL + "/api/user/info/" + uid),
        headers: {
          "Authorization": "Bearer " + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        await MysharedPreferences.instance
            .setStringValue(jImage, jsonData[jImage]);
        return new AppUserInfo(
            firstName: jsonData[jFirstName],
            lastName: jsonData[jLastName],
            phoneNumber: jsonData[jPhoneNumber],
            description: jsonData[jDescription],
            image: jsonData[jImage]);
      } else {
        return "Error";
      }
    } catch (e) {
      return "Error";
    }

    // var jsonData;
    // if (response.statusCode == 200) {
    //   jsonData = jsonDecode(response.body);
    //   await MysharedPreferences.instance
    //       .setStringValue(UserInfo.fistName, jsonData[UserInfo.fistName]);
    //   await MysharedPreferences.instance
    //       .setStringValue(UserInfo.lastName, jsonData[UserInfo.phoneNumber]);
    //   await MysharedPreferences.instance
    //       .setStringValue(UserInfo.description, jsonData[UserInfo.description]);
    //   await MysharedPreferences.instance
    //       .setStringValue(UserInfo.phoneNumber, jsonData[UserInfo.phoneNumber]);
    //   await MysharedPreferences.instance
    //       .setStringValue(UserInfo.image, jsonData[UserInfo.image]);
    // }
  }

  Future<String> saveUserInfo(AppUserInfo userInfo) async {
    AppUser user = AuthServices().currentUser!;
    Map data = {
      jFirstName: userInfo.firstName != null ? userInfo.firstName : "",
      jLastName: userInfo.lastName != null ? userInfo.lastName : "",
      jPhoneNumber: userInfo.phoneNumber != null ? userInfo.phoneNumber : "",
      jImage: userInfo.image != null ? userInfo.image : "",
      jDescription: userInfo.description != null ? userInfo.description : ""
    };
    var body = json.encode(data);
    try {
      String token = await AuthServices().getCurrentUserToken();
      var response = await http.post(
        Uri.parse(BASE_URL +
            "/api/user/info/save/" +
            AuthServices().currentUser!.uid),
        body: body,
        headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json",
        },
        encoding: Encoding.getByName('utf-8'),
      );
      if (response.statusCode == 200) {
        return "Ok";
      }
      return kNetworkError;
    } catch (error) {
      return kNetworkError;
    }
  }
}

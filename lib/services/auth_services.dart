import 'dart:convert';

import 'package:tim_phong_tro/models/User.dart';
import 'package:tim_phong_tro/models/my_shared_preferences.dart';
import 'package:tim_phong_tro/services/user_services.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class AuthServices {
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

  static signOut() async {
    await MysharedPreferences.instance.clearData();
    await MysharedPreferences.instance.setBooleanValue("secondTimeOpen", true);
  }

  static Future<bool> isLogedIn() async {
    String token =
        await MysharedPreferences.instance.getStringValue(kAccessToken);
    if (token != "") {
      return Future.value(true);
    }
    return Future.value(false);
  }
}

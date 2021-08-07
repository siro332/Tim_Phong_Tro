import 'dart:convert';

import 'package:tim_phong_tro/models/my_shared_preferences.dart';
import 'package:tim_phong_tro/models/user_info.dart';

import '../constants.dart';

import 'package:http/http.dart' as http;

class UserServices {
  static getUserInfo(String token, String username) async {
    var response = await http.get(
      Uri.parse(BASE_URL + "/api/user/info/" + username),
      headers: {
        "Authorization": "Bearer " + token,
      },
    );
    var jsonData;
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      await MysharedPreferences.instance
          .setStringValue(UserInfo.fistName, jsonData[UserInfo.fistName]);
      await MysharedPreferences.instance
          .setStringValue(UserInfo.lastName, jsonData[UserInfo.phoneNumber]);
      await MysharedPreferences.instance
          .setStringValue(UserInfo.description, jsonData[UserInfo.description]);
      await MysharedPreferences.instance
          .setStringValue(UserInfo.phoneNumber, jsonData[UserInfo.phoneNumber]);
      await MysharedPreferences.instance
          .setStringValue(UserInfo.image, jsonData[UserInfo.image]);
    }
  }
}

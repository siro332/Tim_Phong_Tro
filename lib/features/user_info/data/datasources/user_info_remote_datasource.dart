import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tim_phong_tro/core/error/exceptions.dart';
import 'package:tim_phong_tro/core/firebase/firebase.dart';
import 'package:http/http.dart' as http;
import 'package:tim_phong_tro/features/user_info/data/models/user_info_model.dart';

import '../../../../constants.dart';

abstract class UserInfoRemoteDataSource {
  Future<AppUserInfoModel> getUserInfo({required String uid});

  Future<void> setUserInfo({required AppUserInfoModel info});
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  final FirebaseAuth _auth = FirebaseImpl().getAuth();
  @override
  Future<AppUserInfoModel> getUserInfo({required String uid}) async {
    try {
      var response = await http.get(
        Uri.parse(BASE_URL + "/api/user/info/" + uid),
        headers: {
          "Authorization": "Bearer " + await _auth.currentUser!.getIdToken(),
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        return new AppUserInfoModel.fromJson(jsonData);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> setUserInfo({required AppUserInfoModel info}) async {
    Map data = info.toJson();
    var body = json.encode(data);
    try {
      String uid = _auth.currentUser!.uid;
      String token = await _auth.currentUser!.getIdToken();
      var response = await http.post(
        Uri.parse(BASE_URL + "/api/user/info/save/" + uid),
        body: body,
        headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json",
        },
        encoding: Encoding.getByName('utf-8'),
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException();
    }
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/search_post.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/firebase/firebase.dart';
import 'package:http/http.dart' as http;
import '../model/user_post_model.dart';
import '../model/user_post_preview_model.dart';

import '../../../../constants.dart';

abstract class UserPostRemoteDataSource {
  Future<List<UserPostPreviewModel>> getPostPreviewList(
      int page, int size, String sortParam, int sortDirection);

  Future<UserPostModel> getPostDetail(int id);
  Future<List<UserPostPreviewModel>> getUserListPosts(
      int page, int size, String uid);
  Future<List<UserPostPreviewModel>> searchPost(int page, int size,
      String sortParam, int sortDirection, List<SearchParam> searchParams);
  Future<List<UserPostPreviewModel>> getSavedPost(
      int page, int size, String sortParam, int sortDirection, String uid);
}

class UserPostRemoteDataSourceImpl implements UserPostRemoteDataSource {
  final FirebaseAuth _auth = FirebaseImpl().getAuth();
  @override
  Future<List<UserPostPreviewModel>> getPostPreviewList(
      int page, int size, String sortParam, int sortDirection) async {
    try {
      var response = await http.get(
        Uri.parse(BASE_URL +
            "/api/posts" +
            "?page=" +
            page.toString() +
            "&size=" +
            size.toString()),
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        return (jsonData["posts"] as List)
            .map((e) => UserPostPreviewModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserPostModel> getPostDetail(int id) async {
    try {
      String token = await _auth.currentUser!.getIdToken();
      var response = await http.get(
        Uri.parse(BASE_URL + "/api/posts/detail/" + id.toString()),
        headers: {
          "Authorization": "Bearer " + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        return UserPostModel.fromJson(jsonData);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<UserPostPreviewModel>> getUserListPosts(
      int page, int size, String uid) async {
    try {
      String token = await _auth.currentUser!.getIdToken();
      var response = await http.get(
        Uri.parse(BASE_URL +
            "/api/posts/" +
            uid +
            "?page=" +
            page.toString() +
            "&size=" +
            size.toString()),
        headers: {
          "Authorization": "Bearer " + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        return (jsonData["posts"] as List)
            .map((e) => UserPostPreviewModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<UserPostPreviewModel>> searchPost(
      int page,
      int size,
      String sortParam,
      int sortDirection,
      List<SearchParam> searchParams) async {
    try {
      var body = json.encode(searchParams.map((e) => e.toJson()).toList());
      String sort = sortParam == ""
          ? ""
          : ("&sortParam=" +
              sortParam +
              "&sortDirection=" +
              sortDirection.toString());
      String url = BASE_URL +
          "/api/posts/search" +
          "?page=" +
          page.toString() +
          "&size=" +
          size.toString() +
          sort;

      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": "application/json",
        },
        encoding: Encoding.getByName('utf-8'),
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        return (jsonData["posts"] as List)
            .map((e) => UserPostPreviewModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<UserPostPreviewModel>> getSavedPost(int page, int size,
      String sortParam, int sortDirection, String uid) async {
    try {
      String token = await _auth.currentUser!.getIdToken();

      var response = await http.get(
        Uri.parse(BASE_URL +
            "/api/posts/saved/" +
            uid +
            "?page=" +
            page.toString() +
            "&size=" +
            size.toString()),
        headers: {
          "Authorization": "Bearer " + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        return (jsonData["posts"] as List)
            .map((e) => UserPostPreviewModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}

import 'package:tim_phong_tro/features/user_info/data/models/user_info_model.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/user_detail.dart';

class UserDetailModel extends UserDetail {
  UserDetailModel({
    required email,
    required uid,
    required info,
  }) : super(
          uid: uid,
          info: info,
          email: email,
        );

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
        uid: json["uid"],
        email: json["email"] != null ? json["email"] : "",
        info: new AppUserInfoModel.fromJson(json["userInfo"]));
  }
  Map<String, dynamic> toJson() => {};
}

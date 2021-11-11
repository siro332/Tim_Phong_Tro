import 'package:tim_phong_tro/features/authenticate/domain/entities/user.dart';

class AppUserModel extends AppUser {
  AppUserModel({
    required String uid,
  }) : super(uid: uid);
  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(uid: json["uid"]);
  }
}

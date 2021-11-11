import 'package:tim_phong_tro/features/user_info/data/models/const.dart';

import '../../domain/entities/user_info.dart';

class AppUserInfoModel extends AppUserInfo {
  AppUserInfoModel({
    required firstName,
    required lastName,
    required phoneNumber,
    required image,
    required description,
  }) : super(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            image: image,
            description: description);

  factory AppUserInfoModel.fromJson(Map<String, dynamic> json) {
    return AppUserInfoModel(
        firstName: json[jFirstName] != null ? json[jFirstName] : "",
        lastName: json[jLastName] != null ? json[jLastName] : "",
        phoneNumber: json[jPhoneNumber] != null ? json[jPhoneNumber] : "",
        image: json[jImage] != null ? json[jImage] : "",
        description: json[jDescription] != null ? json[jDescription] : "");
  }
  Map<String, dynamic> toJson() => {
        jFirstName: firstName,
        jLastName: lastName,
        jPhoneNumber: phoneNumber,
        jDescription: description,
        jImage: image,
      };
}

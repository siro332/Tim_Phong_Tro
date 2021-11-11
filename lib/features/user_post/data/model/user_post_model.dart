import 'package:tim_phong_tro/features/user_post/data/model/room_info_model.dart';
import 'package:tim_phong_tro/features/user_post/data/model/user_detail_model.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/user_post.dart';

class UserPostModel extends UserPost {
  UserPostModel(
      {required id,
      required name,
      required phoneNumber,
      required thumbnailImage,
      required roomInfo,
      required description,
      required isVerifired,
      required postingDate,
      required user})
      : super(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            thumbnailImage: thumbnailImage,
            roomInfo: roomInfo,
            description: description,
            isVerifired: isVerifired,
            postingDate: postingDate,
            user: user);

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(
        id: json["id"],
        name: json["name"] == null ? "" : json["name"],
        phoneNumber: json["phoneNumber"] == null ? "" : json["phoneNumber"],
        thumbnailImage:
            json["thumbnailImage"] == null ? "" : json["thumbnailImage"],
        roomInfo: new RoomInfoModel.fromJson(json["roomInfo"]),
        description: json["description"] == null ? "" : json["description"],
        isVerifired: json["isVerifired"] == null ? false : json["isVerifired"],
        postingDate: DateTime.parse(json["postingDate"]),
        user: new UserDetailModel.fromJson(json["appUser"]));
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "thumbnailImage": thumbnailImage,
      };
}
